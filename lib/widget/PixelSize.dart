/**
 * @author      dakun007 <dakun007@hotmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         定义类型 - 像素大小
*/

import 'dart:ui';

import 'package:flutter/cupertino.dart';

class PixelSize {
  var win = window.physicalSize; //获取屏幕

  //返回正常的像素大小
  double getPixe(int number, var context) {
    int defaultValue = 750;
    double width = MediaQuery.of(context).size.width;
    return (number * 1.817) * (width / defaultValue);
  }

} 