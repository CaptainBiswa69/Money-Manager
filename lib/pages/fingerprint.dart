import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_3/pages/homepage.dart';
import 'package:local_auth/local_auth.dart';

class Finger extends StatefulWidget {
  Finger({Key? key}) : super(key: key);

  @override
  State<Finger> createState() => _FingerprintAuthState();
}

class _FingerprintAuthState extends State<Finger> {
  final LocalAuthentication auth = LocalAuthentication();

  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
          localizedReason: 'Let OS determine authentication method',
          useErrorDialogs: true,
          stickyAuth: true);
      setState(() {
        _isAuthenticating = false;
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = "Error - ${e.message}";
      });
      return;
    }
    if (!mounted) return;

    setState(() {
      if (authenticated) {
        _isAuthenticating = true;
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage()));
      }
      _authorized = authenticated ? 'Authorized' : 'Not Authorized';
    });
  }

  void _cancelAuthentication() async {
    await auth.stopAuthentication();
    setState(() => _isAuthenticating = false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Current State: $_authorized\n'),
              (_isAuthenticating)
                  ? ElevatedButton(
                      onPressed: _cancelAuthentication,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Cancel Authentication"),
                          Icon(Icons.cancel),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        ElevatedButton(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Authenticate'),
                              Icon(Icons.fingerprint),
                            ],
                          ),
                          onPressed: () {
                            _authenticate();
                          },
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
