/**
 * @author      HackerDaKun007 <hackerdakun007@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         provider配置阅读时间
*/
import 'package:flutter/material.dart';
class ReadTimeProvider with ChangeNotifier {

  int _time = 0; //默认状态

  ReadTimeProvider() { //初始化
    this._time = 10;
  }

  //获取时间
  int get readTime => this._time;

  //更新阅读时间
  updateTime(int value) {
    this._time = value; //赋值
    notifyListeners(); //更新状态
  }

}