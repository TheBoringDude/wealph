import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:wealph/src/models/wealph.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextEditingController _tokenController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => {_tokenController.text = context.read<WealphModel>().token});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
        ),
        body: SettingsList(
          contentPadding: EdgeInsets.only(top: 10, bottom: 10),
          sections: [
            SettingsSection(
              title: 'OpenWeather API',
              tiles: [
                SettingsTile(
                  title: 'Token',
                  subtitle: Provider.of<WealphModel>(context).token,
                  leading: Icon(Icons.api_sharp),
                  onPressed: (context) {
                    _editTokenModal();
                  },
                )
              ],
            )
          ],
        ));
  }

  Future<void> _editTokenModal() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Edit OpenWeather API"),
            insetPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  TextField(
                      controller: _tokenController,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        labelText: 'Your API Token',
                      ))
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () async {
                    if (_tokenController.text != "") {
                      await Provider.of<WealphModel>(context, listen: false)
                          .editToken(_tokenController.text)
                          .then((_) {
                        Navigator.of(context).pop();
                      });
                    }
                  },
                  child: Text('Save')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel"))
            ],
          );
        });
  }
}
