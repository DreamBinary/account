import 'package:account/app/utils/db_util.dart';

import '../entity/consume.dart';

class DBConsume {
  // getRangeRecordMap from DB
  // todo
  static Future<List<Map<String, List<ConsumeData>>>>
      getRangeRecordMap() async {
    List<Map<String, List<ConsumeData>>> list = [];
    Map<String, List<ConsumeData>> map = {};
    await DBUtil.query(DBTable.tConsume.name).then((value) {
      for (var element in value) {
        ConsumeData consumeData = ConsumeData.fromJson(element);
        String date = consumeData.consumeDate;
        if (map.containsKey(date)) {
          map[date]!.add(consumeData);
        } else {
          map[date] = [consumeData];
        }
      }
      // map to list
      map.forEach((key, value) {
        list.add({key: value});
      });
    });
    print("getRangeRecordMap");
    print(list);
    return list;
  }

  // add consume to DB
  static Future<void> addConsume(
      List<Map<String, List<ConsumeData>>> cDataList) async {
    print("addConsume");
    for (var element in cDataList) {
      for (var e in element.values) {
        for (var consumeData in e) {
         await DBUtil.insert(DBTable.tConsume.name, consumeData.toJson());
        }
      }
    }
  }
}
