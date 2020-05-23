/*
 * @author      HackerDaKun007 <hackerdakun007@gmail.com> 
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         书架页面 -阅读记录数据
*/
import 'package:flutter/material.dart';
import 'package:fiction/res/recordingData.dart';

class RecordingDataProviders with ChangeNotifier{

  List<Map> _listData = []; //数据

  RecordingDataProviders() {
    _listData = listData;
  }
  
  List<Map> get data => this._listData;


  //清空数据
  remove() {
    _listData = [];
    notifyListeners();
  }

  //修改是否加入书架
  addBookshle(int key) {
    if (_listData[key]['book_shelf'] == 0) {
      _listData[key]['book_shelf'] = 1;
      notifyListeners();
    }
  }

  //删除单条书架
  removeIndex(int key) {
    _listData.removeAt(key);
    notifyListeners();
  }
}