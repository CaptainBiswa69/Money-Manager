import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_3/static.dart' as Static;

class AddTransaction extends StatefulWidget {
  const AddTransaction({Key? key}) : super(key: key);

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  int? amount;
  String note = "Given";
  String type = "Expense";
  DateTime selectedDate = DateTime.now();
  List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  Future<void> _selectedDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2019, 1),
        lastDate: DateTime(2100, 12)) as DateTime;

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Add Transctions",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: const Color(0xffe2e7ef),
      body: ListView(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 25.0),
        children: [
          Row(
            children: [
              Container(
                child: const Icon(
                  CupertinoIcons.money_dollar_circle,
                  color: Colors.white,
                  size: 25.0,
                ),
                decoration: const BoxDecoration(
                    color: Static.PrimaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                padding: const EdgeInsets.all(12.0),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(hintText: "0"),
                  style: const TextStyle(fontSize: 20),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    try {
                      amount = int.parse(value);
                    } catch (e) {}
                  },
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                child: const Icon(
                  Icons.description_rounded,
                  color: Colors.white,
                  size: 25.0,
                ),
                decoration: const BoxDecoration(
                    color: Static.PrimaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                padding: const EdgeInsets.all(12.0),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(hintText: "Take a note"),
                  style: const TextStyle(fontSize: 20),
                  maxLength: 30,
                  onChanged: (value) {
                    note = value;
                  },
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                child: const Icon(
                  CupertinoIcons.money_rubl_circle,
                  color: Colors.white,
                  size: 25.0,
                ),
                decoration: const BoxDecoration(
                    color: Static.PrimaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                padding: const EdgeInsets.all(12.0),
              ),
              const SizedBox(
                width: 20,
              ),
              ChoiceChip(
                label: Text(
                  "Income",
                  style: TextStyle(
                      fontSize: 18,
                      color: type == "Income" ? Colors.white : Colors.black),
                ),
                selected: type == "Income" ? true : false,
                selectedColor: Static.PrimaryColor,
                onSelected: (val) {
                  if (val) {
                    setState(() {
                      type = "Income";
                    });
                  }
                },
              ),
              const SizedBox(
                width: 20,
              ),
              ChoiceChip(
                label: Text(
                  "Expense",
                  style: TextStyle(
                      fontSize: 18,
                      color: type == "Expense" ? Colors.white : Colors.black),
                ),
                selected: type == "Expense" ? true : false,
                selectedColor: Static.PrimaryColor,
                onSelected: (val) {
                  if (val) {
                    setState(() {
                      type = "Expense";
                    });
                  }
                },
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                child: const Icon(
                  CupertinoIcons.calendar_today,
                  color: Colors.white,
                  size: 25.0,
                ),
                decoration: const BoxDecoration(
                    color: Static.PrimaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                padding: const EdgeInsets.all(12.0),
              ),
              const SizedBox(
                width: 20,
              ),
              TextButton(
                onPressed: () {
                  _selectedDate(context);
                },
                child: Text(
                    "${selectedDate.day} ${months[selectedDate.month - 1]} ${selectedDate.year}",
                    style: const TextStyle(fontSize: 20)),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                print(type);
              },
              child: const Text(
                "Add",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
