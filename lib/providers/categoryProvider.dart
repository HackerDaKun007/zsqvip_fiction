/*
 * @author      Yuri Chen <pluto401zz@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         状态管理-分类界面
*/

import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {
  List statusList = List(); // 存储状态

  final Map data;
  List categorydata = List(); // 分类名数据
  List booksData = List(); // 书籍数据
  List booksList = List(); // 存储书籍改动数据

  List<int> selectIndexes = List<int>(); // 存储每组选择的下标
  List<int> categoryIDs = List<int>(); // 存储分类ID

  CategoryProvider(this.data) {
    categorydata = this.data['category_list'];
    booksData = this.data['books'];
    booksList = booksData;
    _initData();
  }

  /// 初始化数据
  _initData() {
    List.generate(categorydata.length, (index) => selectIndexes.add(0));

    List.generate(categorydata.length, (index) => statusList.add([]));

    for (var i = 0; i < statusList.length; i++) {
      if (i == 0) {
        List.generate(categorydata[0].length,
            (index) => categoryIDs.add(categorydata[0][index]['id']));
      }
      List.generate(categorydata[i].length, (index) {
        bool _tempBool = false;
        if (index == 0) {
          _tempBool = true;
        }
        statusList[i].add(_tempBool);
      });
    }
  }


  setBtnStatus(index, parentIndex) {
    if (selectIndexes[parentIndex] == index) return;

    int selectIndex = selectIndexes[parentIndex];
    statusList[parentIndex][selectIndex] = false; // 设置前一个按钮

    selectIndexes[parentIndex] = index; // 存储当前按钮的下标
    statusList[parentIndex][index] = true; // 设置当前按钮

    booksList = filterData();
    notifyListeners();
  }

  filterData() {
    List _data = booksData;

    if (selectIndexes.every((element) => element == 0)) {
      _data = booksData;
    } else {
      if (selectIndexes[0] > 0) {
        _data = _firstFilter(_data);
      }
      if (selectIndexes[1] > 0) {
        _data = _secondFilter(_data);
      }
      if (selectIndexes[2] > 0) {
        _data = _thirdFilter(_data);
      }
      if (selectIndexes[3] > 0) {
        _data = _fourthFilter(_data);
      }
    }
    return _data;
  }

  /// 过滤第一个分类数据，根据分类过滤
  _firstFilter(data) {
    int _id = categoryIDs[selectIndexes[0]];
    List _list = List();
    data.forEach((item) {
      if (item['category_id'] == _id) {
        _list.add(item);
      }
    });
    return _list;
  }

  /// 过滤第二个分类数据，根据书籍字数过滤
  _secondFilter(data) {
    int index = selectIndexes[1];
    List _list = List();
    data.forEach((item) {
      bool isFit = (index == 1 && item['total_num'] < 1000000) ||
          (index == 2 && (item['total_num'] <= 2000000 && item['total_num'] >= 1000000)) ||
          (index == 3 && item['total_num'] > 2000000);
      if (isFit) {
        _list.add(item);
      }
    });
    return _list;
  }

  /// 过滤第三个分类数据, 根据书籍当前状态过滤
  _thirdFilter(data) {
    int index = selectIndexes[2];
    List _list = List();
    data.forEach((item) {
      bool isFit = item['status'] == index;
      if (isFit) {
        _list.add(item);
      }
    });
    return _list;
  }

  /// 过滤第四个分类数据，根据时间和评分排序
  _fourthFilter(data) {
    int index = selectIndexes[3];
    List _list = data;

    switch (index) {
      case 1:
        _list.sort((a, b) {
          return b['update_time'].compareTo(a['update_time']); // 时间
        });
        break;
      case 2:
        _list.sort((a, b) {
          return b['score'].compareTo(a['score']);  // 评分
        });
        break;
      default:
       _list = _list;
       break;
    }
    return _list;
  }
}
