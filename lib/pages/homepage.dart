import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/controller/db_helper.dart';
import 'package:flutter_application_3/models/transaction_model.dart';
import 'package:flutter_application_3/pages/settings.dart';
import 'package:flutter_application_3/static.dart' as Static;
import 'package:flutter_application_3/pages/transaction_add.dart';
import 'package:flutter_application_3/widgets/confirm_dialog.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DbHelper helper = DbHelper();
  late Box box;
  int totalBalance = 0;
  int totalIncome = 0;
  int totalExpense = 0;
  DateTime day = DateTime.now();
  int choicevalue = DateTime.now().month - 1;
  String name = "";
  String dropdownvalue = 'This Month';
  String? customChoice = "";

  DateTimeRange dateTimeRange = DateTimeRange(
      start: DateTime(DateTime.now().year, DateTime.now().month - 1,
          DateTime.now().day - 3),
      end: DateTime.now().add(Duration(days: 2)));
  getTotalBalnace(List<TransactionModel> entireData) {
    totalIncome = 0;
    totalBalance = 0;
    totalExpense = 0;
    for (TransactionModel data in entireData) {
      if (data.type == "Income") {
        totalBalance += data.amount;
        totalIncome += data.amount;
      } else {
        totalBalance -= data.amount;
        totalExpense += data.amount;
      }
    }
  }

  List<String> month = [
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

  List<String> months = [
    "JAN",
    "FEB",
    "MAR",
    "APR",
    "MAY",
    "JUN",
    "JUL",
    "AUG",
    "SEP",
    "OCT",
    "NOV",
    "DEC"
  ];

  var ranges = [
    'Today',
    'This Month',
    'Last Month',
    'Overall',
    'Custom',
  ];

  Future<List<TransactionModel>> fetch() async {
    if (box.values.isEmpty) {
      return Future.value([]);
    } else {
      List<TransactionModel> items = [];
      box.toMap().values.forEach((element) {
        items.add(TransactionModel(element['amount'] as int,
            element['date'] as DateTime, element['note'], element['type']));
      });
      List<TransactionModel> rev = items.reversed.toList();
      return rev;
    }
  }

  @override
  void initState() {
    super.initState();
    box = Hive.box("Money");
    _getName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Hello, $name",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Settings()))
                    .whenComplete(() {
                  setState(() {
                    _getName();
                  });
                });
              },
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
      body: FutureBuilder<List<TransactionModel>>(
          future: fetch(),
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 12.0,
                    ),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side:
                            BorderSide(color: Static.PrimaryColor, width: 1.5),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.greenAccent,
                                offset: const Offset(
                                  5.0,
                                  5.0,
                                ),
                                blurRadius: 10.0,
                                spreadRadius: 2.0,
                              ), //BoxShadow
                              BoxShadow(
                                color: Colors.white,
                                offset: const Offset(0.0, 0.0),
                                blurRadius: 0.0,
                                spreadRadius: 0.0,
                              ), //BoxShadow
                            ],
                            gradient: const LinearGradient(
                                colors: [Static.PrimaryColor, Colors.green])),
                        child: Column(
                          children: [
                            const Text(
                              "Total Balance",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Rs $totalBalance",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 28.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              height: 50,
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
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Transactions",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 32,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton(
                            value: dropdownvalue,
                            elevation: 5,
                            style: TextStyle(
                                fontSize: 18, color: Static.PrimaryColor),
                            borderRadius: BorderRadius.circular(18),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: ranges.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) async {
                              setState(() {
                                dropdownvalue = newValue!;
                              });
                              if (newValue == 'Custom') {
                                customChoice = await openDialog(context);
                                setState(() {});
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        TransactionModel dataIndex = snapshot.data![index];
                        if (dropdownvalue == 'This Month') {
                          if (dataIndex.date.month == DateTime.now().month) {
                            if (dataIndex.type == "Income") {
                              return incomeTile(dataIndex.amount,
                                  dataIndex.note, dataIndex.date, index);
                            } else {
                              return expenseTile(dataIndex.amount,
                                  dataIndex.note, dataIndex.date, index);
                            }
                          } else {
                            return Container();
                          }
                        } else if (dropdownvalue == 'Today') {
                          if (dataIndex.date.day == DateTime.now().day) {
                            if (dataIndex.type == "Income") {
                              return incomeTile(dataIndex.amount,
                                  dataIndex.note, dataIndex.date, index);
                            } else {
                              return expenseTile(dataIndex.amount,
                                  dataIndex.note, dataIndex.date, index);
                            }
                          } else {
                            return Container();
                          }
                        } else if (dropdownvalue == 'Last Month') {
                          if (dataIndex.date.month ==
                              DateTime.now().month - 1) {
                            if (dataIndex.type == "Income") {
                              return incomeTile(dataIndex.amount,
                                  dataIndex.note, dataIndex.date, index);
                            } else {
                              return expenseTile(dataIndex.amount,
                                  dataIndex.note, dataIndex.date, index);
                            }
                          } else {
                            return Container();
                          }
                        } else if (dropdownvalue == 'Overall') {
                          if (dataIndex.type == "Income") {
                            return incomeTile(dataIndex.amount, dataIndex.note,
                                dataIndex.date, index);
                          } else {
                            return expenseTile(dataIndex.amount, dataIndex.note,
                                dataIndex.date, index);
                          }
                        } else if (dropdownvalue == 'Custom') {
                          if (customChoice == "True" || customChoice == null) {
                            if (dateTimeRange.start == dataIndex.date) {
                              if (dataIndex.type == "Income") {
                                return incomeTile(dataIndex.amount,
                                    dataIndex.note, dataIndex.date, index);
                              } else {
                                return expenseTile(dataIndex.amount,
                                    dataIndex.note, dataIndex.date, index);
                              }
                            } else if (dateTimeRange.end == dataIndex.date) {
                              if (dataIndex.type == "Income") {
                                return incomeTile(dataIndex.amount,
                                    dataIndex.note, dataIndex.date, index);
                              } else {
                                return expenseTile(dataIndex.amount,
                                    dataIndex.note, dataIndex.date, index);
                              }
                            } else if (dateTimeRange.start
                                    .isBefore(dataIndex.date) &&
                                dateTimeRange.end
                                    .add(Duration(days: 1))
                                    .isAfter(dataIndex.date)) {
                              if (dataIndex.type == "Income") {
                                return incomeTile(dataIndex.amount,
                                    dataIndex.note, dataIndex.date, index);
                              } else {
                                return expenseTile(dataIndex.amount,
                                    dataIndex.note, dataIndex.date, index);
                              }
                            } else {
                              return Container();
                            }
                          } else {
                            return Container();
                          }
                        } else {
                          return Container();
                        }
                      }),
                  const SizedBox(
                    height: 50,
                  ),
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

  Widget incomeCard(String value) {
    return Row(
      children: [
        Container(
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: Colors.white70),
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
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              value,
              style: const TextStyle(color: Colors.white, fontSize: 20),
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
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: Colors.white70),
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
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              value,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            )
          ],
        ),
      ],
    );
  }

  Widget incomeTile(int value, String note, DateTime date, int index) {
    return InkWell(
      onLongPress: () async {
        bool? answer = await showConfirmDialog(
            context, "Warning", "Do you want to delete this record?");
        if (answer != null && answer) {
          helper.deleteData(index);
          setState(() {});
        }
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: BorderSide(color: Static.PrimaryColor, width: 1.5),
        ),
        child: Container(
          padding: const EdgeInsets.all(5.0),
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
          decoration: BoxDecoration(color: Colors.white60),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                const Icon(
                  CupertinoIcons.arrow_down_circle,
                  color: Colors.green,
                  size: 30,
                ),
                const SizedBox(
                  width: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Income",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${date.day} ${months[date.month - 1]} ${date.year}",
                      style: const TextStyle(
                          color: Colors.green,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ]),
              Row(
                children: [
                  Column(
                    children: [
                      Text("+ $value",
                          style: const TextStyle(
                              color: Colors.green,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        note,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget expenseTile(int value, String note, DateTime date, int index) {
    return InkWell(
      onLongPress: () async {
        bool? answer = await showConfirmDialog(
            context, "Warning", "Do you want to delete this record?");
        if (answer != null && answer) {
          helper.deleteData(index);
          setState(() {});
        }
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: BorderSide(color: Static.PrimaryColor, width: 1.5),
        ),
        child: Container(
          padding: const EdgeInsets.all(5.0),
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
          decoration: BoxDecoration(color: Colors.white60),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                const Icon(
                  CupertinoIcons.arrow_up_circle,
                  color: Colors.red,
                  size: 30,
                ),
                const SizedBox(
                  width: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Expense",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${date.day} ${months[date.month - 1]} ${date.year}",
                      style: const TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ]),
              Row(
                children: [
                  Column(
                    children: [
                      Text("- $value",
                          style: const TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(note, style: const TextStyle(fontSize: 15)),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  openDialog(context) => showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: const Text("Pick Range"),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    DateTimeRange? n = await showDateRangePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                        initialDateRange: dateTimeRange);
                    if (n != null) {
                      setState(() => dateTimeRange = n);
                    }
                  },
                  child: Text(
                    "${dateTimeRange.start.day} ${dateTimeRange.start.month} ${dateTimeRange.start.year}",
                  ),
                ),
                const Icon(CupertinoIcons.arrow_right),
                ElevatedButton(
                  onPressed: () async {
                    DateTimeRange? n = await showDateRangePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                        initialDateRange: dateTimeRange);
                    if (n != null) {
                      setState(() => dateTimeRange = n);
                    }
                  },
                  child: Text(
                      "${dateTimeRange.end.day} ${dateTimeRange.end.month} ${dateTimeRange.end.year}"),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop("True");
                  },
                  child: Text("SUBMIT"))
            ],
          ),
        ),
      );

  void _getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString("Name")!;
    });
  }
}
