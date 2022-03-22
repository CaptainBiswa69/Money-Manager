import 'package:hive/hive.dart';

class DbHelper {
  late Box box;

  DbHelper() {
    openBox();
  }

  openBox() {
    box = Hive.box("Money");
  }

  Future deleteData(int index) async {
    int length = box.values.length;
    await box.deleteAt(length - 1 - index);
  }

  Future addData(int amount, DateTime date, String note, String type) async {
    var values = {'amount': amount, 'date': date, 'note': note, 'type': type};
    box.add(values);
  }

  // Future<Map> fetch() {
  //   if (box.values.isEmpty) {
  //     return Future.value({});
  //   } else {
  //     return Future.value(box.toMap());
  //   }
  // }
}
