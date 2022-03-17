import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/controller/db_helper.dart';
import 'package:flutter_application_3/static.dart' as Static;
import 'package:flutter_application_3/pages/transaction_add.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DbHelper helper = DbHelper();

  int totalBalance = 0;

  int totalIncome = 0;

  int totalExpense = 0;

  getTotalBalnace(Map entireData) {
    totalIncome = 0;
    totalBalance = 0;
    totalExpense = 0;
    entireData.forEach((key, value) {
      if (value['type'] == "Income") {
        totalBalance += value['amount'] as int;
        totalIncome += value['amount'] as int;
      }
      if (value['type'] == "Expense") {
        totalBalance = totalBalance - value['amount'] as int;
        totalExpense += value['amount'] as int;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Money Manager",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ]),
      backgroundColor: const Color(0xffe2e7ef),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                  builder: (context) => const AddTransaction()))
              .whenComplete(() {
            setState(() {});
          });
        },
        child: const Icon(
          CupertinoIcons.add,
          color: Colors.white,
        ),
        backgroundColor: Static.PrimaryColor,
      ),
      body: FutureBuilder<Map>(
          future: helper.fetch(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("Unxpected error!"),
              );
            }
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return const Center(child: Text("No Data"));
              }
              getTotalBalnace(snapshot.data!);
              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          gradient: const LinearGradient(colors: [
                            Static.PrimaryColor,
                            Colors.greenAccent
                          ])),
                      child: Column(
                        children: [
                          const Text(
                            "Total Balance",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Rs $totalBalance",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              incomeCard(totalIncome.toString()),
                              expenseCard(totalExpense.toString())
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            } else {
              return const Center(
                child: Text("Unxpected error!"),
              );
            }
          }),
    );
  }
}

Widget incomeCard(String value) {
  return Row(
    children: [
      Container(
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.white70),
        padding: const EdgeInsets.all(12.0),
        child: const Icon(
          CupertinoIcons.arrow_down,
          color: Colors.green,
          size: 24,
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Income",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          )
        ],
      ),
    ],
  );
}

Widget expenseCard(String value) {
  return Row(
    children: [
      Container(
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.white70),
        padding: const EdgeInsets.all(12.0),
        child: const Icon(
          CupertinoIcons.arrow_up,
          color: Colors.red,
          size: 24,
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Expense",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          )
        ],
      ),
    ],
  );
}
