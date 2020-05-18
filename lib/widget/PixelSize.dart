/**
 * @author      HackerDaKun007 <hackerdakun007@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         定义类型 - 像素大小
*/

// import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:fiction/config/Config.dart';
class PixelSize {
  // var win = window.physicalSize; //获取屏幕

  //返回正常的像素大小
  double getPixe(int number, BuildContext context) {

    int defaultValue = 750;
    if (Config.width == 0.0) {
      Config.width = MediaQuery.of(context).size.width;
      // print(Config.width);
    }
    return (number * 1.83) * (Config.width / defaultValue);
  }

} 