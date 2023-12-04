import 'package:account/app/modules/all_more/my_book/my_book_logic.dart';
import 'package:get/get.dart';

import 'more_logic.dart';

class MoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MoreLogic());
    Get.lazyPut(() => MyBookLogic());
  }
}
