import 'package:flutter/material.dart';

import '../../utils/date_util.dart';

class AddState {
  var moneyCtrl = TextEditingController();
  var dateCtrl = TextEditingController(text: DateUtil.getNowFormattedDate());
  var nameCtrl = TextEditingController();
  var merchantCtrl = TextEditingController();
  var remarkCtrl = TextEditingController();
  num bookId = 0;
  int typeId = 0;
  String? imgUrl;
  num consumeId = 0;

  List<String> wordList = [];

  AddState() {
    ///Initialize variables
  }
}
