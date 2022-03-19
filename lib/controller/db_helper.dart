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
    await box.deleteAt(index);
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
