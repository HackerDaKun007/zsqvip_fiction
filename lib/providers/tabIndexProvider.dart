/*
 * @author      Yuri Chen <pluto401zz@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         状态管理-主导航栏
*/

import 'package:flutter/material.dart';

class TabIndexProvider extends ChangeNotifier {
  int tabCurrentIndex;
  
  TabIndexProvider() {
    tabCurrentIndex = 0;
  }

  changeCurrentIndex(index) {
    tabCurrentIndex = index;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}