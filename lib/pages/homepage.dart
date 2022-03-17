import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/static.dart' as Static;
import 'package:flutter_application_3/pages/transaction_add.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Money Manager",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: const Color(0xffe2e7ef),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddTransaction()));
        },
        child: const Icon(
          CupertinoIcons.add,
          color: Colors.white,
        ),
        backgroundColor: Static.PrimaryColor,
      ),
      body: const Center(child: Text("No Data")),
    );
  }
}
