import 'package:account/app/data/entity/book.dart';
import 'package:account/app/data/net/api_book.dart';
import 'package:account/app/utils/db_util.dart';
import 'package:get/get.dart';

import '../../../data/entity/consume.dart';
import 'my_book_state.dart';

class MyBookLogic extends GetxController {
  final MyBookState state = MyBookState();

  Future<List<Book>> getAllBook() async {
    var book = await ApiBook.getBook();
    if (book == null) {
      book = [];
      // get from db
      var list = await DBUtil.query(DBTable.tBook.name);
      for (var i = 0; i < list.length; i++) {
        book.add(Book.fromJson(list[i]));
      }
    } else {
      for (var i = 0; i < book.length; i++) {
        DBUtil.insert(DBTable.tBook.name, book[i].toJson());
      }
    }
    return book;
  }

  Future<bool> addBook(String bookName) async {
    return await ApiBook.addBook(bookName);
  }

  Future<bool> deleteBook(Book book) async {
    return await ApiBook.deleteBook(book);
  }

  Future<List<ConsumeData>> getBookRecord(num ledgerId) async {
    return await ApiBook.getBookRecord(ledgerId);
  }
}
