/*
 * @author      Yuri Chen <pluto401zz@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         状态管理-书籍界面
*/

import 'package:flutter/material.dart';

class BookDetailProvider extends ChangeNotifier {

  ScrollController scrollController;
  double alpha;

  BookDetailProvider() {
    scrollController = ScrollController();
    alpha = 0;
  }


  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }
}