import 'package:flutter/material.dart';
import 'package:flutter_application_3/pages/fingerprint_auth.dart';
import 'package:flutter_application_3/static.dart' as Static;
import 'package:shared_preferences/shared_preferences.dart';

class NamePAge extends StatefulWidget {
  const NamePAge({Key? key}) : super(key: key);

  @override
  State<NamePAge> createState() => _NamePAgeState();
}

class _NamePAgeState extends State<NamePAge> {
  String nameCheck = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.asset(
                  "assets/images/log.png",
                  width: 300,
                  height: 300,
                ),
                Text(
                  "Welcome",
                  style: TextStyle(
                    color: Static.PrimaryColor,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  margin: EdgeInsets.all(20),
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'What should we call you?',
                    ),
                    onChanged: (value) {
                      setState(() {
                        _addName(value);
                        nameCheck = value;
                      });
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                          onPressed: () {
                            if (nameCheck.isNotEmpty) {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => FingerprintAuth()));
                            }
                          },
                          child: Icon(Icons.arrow_right_alt)),
                    )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addName(String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("Name", val);
    prefs.setBool("AuthToogle", false);
  }
}
