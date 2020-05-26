/*
 * @author      Yuri Chen <pluto401zz@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         状态管理-书籍界面
*/

import 'package:fiction/res/guessYouLikeData.dart';
import 'package:flutter/material.dart';

class BookDetailProvider extends ChangeNotifier {
  ScrollController scrollController; // 滚动控制
  double alpha; // 透明度
  List<Map> recommendData; // 推荐数据
  bool isBookShelf; // 是否已在书架

  BookDetailProvider() {
    scrollController = ScrollController();
    alpha = 0;
    isBookShelf = false;
    _initData();
    scrollController.addListener(() {
      var offset = scrollController.offset;
      if (offset < 0) {
        if (alpha != 0) {
          alpha = 0;
        }
      } else if (offset < 50) {
        alpha = 1 - (50 - offset) / 50;
      } else if (alpha != 1) {
        alpha = 1;
      }
      notifyListeners();
    });
  }

  /// 初始化
  _initData() {
    recommendData = guessYouLikeData;
    recommendData.shuffle(); 
  }

  /// 随机数据
  shuffleRecommendData() {
    recommendData.shuffle();
    notifyListeners();
  }

  /// 书架管理
  handleBookShelf() {
    if (isBookShelf) return;
    isBookShelf = !isBookShelf;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }
}
