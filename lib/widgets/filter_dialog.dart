import 'package:flutter/material.dart';

class FilterDialog {
  DateTimeRange dateTimeRange = DateTimeRange(
      start: DateTime(DateTime.now().year, DateTime.now().month - 1,
          DateTime.now().day - 3),
      end: DateTime.now());
  filterDialog(BuildContext context) {
    final start = dateTimeRange.start;
    final end = dateTimeRange.end;
    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text("Pick Range"),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 1,
                          style: BorderStyle.solid,
                          color: Colors.blueAccent)),
                  child: Text(
                    "${start.day} ${start.month} ${start.year}",
                  )),
              Container(child: Text("${end.day} ${end.month} ${end.year}")),
              ElevatedButton(
                  onPressed: () async {
                    DateTimeRange? n = await showDateRangePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                        initialDateRange: dateTimeRange);
                    if (n != null) {
                      setState(() => dateTimeRange = n);
                      print(dateTimeRange);
                    }
                  },
                  child: const Text("Change"))
            ],
          ),
        ),
      ),
    );
  }

  void pickdaterange(BuildContext context) async {
    DateTimeRange? n = await showDateRangePicker(
        context: context,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
        initialDateRange: dateTimeRange);
  }
}
