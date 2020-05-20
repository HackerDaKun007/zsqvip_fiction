/**
 * @author      HackerDaKun007 <hackerdakun007@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         定义类型 - 像素大小
*/

import 'package:flutter/cupertino.dart';
import 'package:fiction/public/public.dart';

class PixelSize {
  // var win = window.physicalSize; //获取屏幕
  static double width = 0.0;  //当前屏幕宽度
  static double height = 0.0;  //当前屏幕高度

  //返回正常的像素大小
  double getPixe(double number, BuildContext context) {

    int defaultValue = 750;
    if (width == 0.0) {
      width = MediaQuery.of(context).size.width;
      Config.width = width;
      // print(Config.width);
    }
    return (number * 1.83) * (Config.width / defaultValue);
  }

  //返回当前屏幕高度
  double getHeight(BuildContext context) {
    if (height == 0.0) {
        height = MediaQuery.of(context).size.height;
    }
    return height;
  }
  
  //返回当前屏幕宽度
  double getWidth(BuildContext context) {
    if (width == 0.0) {
        width = MediaQuery.of(context).size.width;
    }
    return width;
  }

} 