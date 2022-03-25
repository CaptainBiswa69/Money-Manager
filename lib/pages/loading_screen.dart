import 'package:flutter/material.dart';
import 'package:flutter_application_3/pages/fingerprint_auth.dart';
import 'package:flutter_application_3/pages/homepage.dart';
import 'package:flutter_application_3/pages/namepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    _settingsCheck();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  void _settingsCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString("Name");
    if (name != null) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => FingerprintAuth()));
    } else {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => NamePAge()));
    }
  }
}
