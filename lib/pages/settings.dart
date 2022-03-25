import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool authentication_enable = false;
  String name = "";

  @override
  void initState() {
    super.initState();
    _getName();
    _getAuthToogle();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: Icon(Icons.portrait),
                title: Text('Name'),
                value: Text('${name}'),
                onPressed: (context) => openDailog().whenComplete(() {
                  setState(() {
                    _getName();
                  });
                }),
              ),
              SettingsTile.switchTile(
                onToggle: (value) {
                  setState(() {
                    _setAuthtoogle(value);
                  });
                },
                initialValue: authentication_enable,
                leading: Icon(Icons.fingerprint_outlined),
                title: Text('Biometric Authentication'),
              ),
            ],
          ),
        ],
      ),
    ));
  }

  void _getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString("Name")!;
    });
  }

  void _setAuthtoogle(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool("AuthToogle", value);
      authentication_enable = value;
    });
  }

  void _getAuthToogle() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    authentication_enable = prefs.getBool("AuthToogle")!;
  }

  Future openDailog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("Change Your Name"),
            content: TextField(
              onChanged: (value) {
                if (value.isNotEmpty) {
                  add(value);
                }
              },
              decoration: InputDecoration(
                hintText: "Enter Your Name",
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("SUBMIT"))
            ],
          ));

  add(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("Name", value);
  }
}
