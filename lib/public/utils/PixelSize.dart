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

class PixelSize {
  // var win = window.physicalSize; //获取屏幕
  static double width = 0.0;  //当前屏幕宽度
  static double height = 0.0;  //当前屏幕高度
  static var mediaQuery;  //获取设备相关信息

  //返回正常的像素大小
  double getPixe(double number, BuildContext context) {

    int defaultValue = 750;
    if (width == 0.0) {
      width = getMediaQuery(context).size.width;
    }
    return (number * 1.83) * (getWidth(context)/ defaultValue);
  }

  //返回当前屏幕高度
  double getHeight(BuildContext context) {
    if (height == 0.0) {
        height = getMediaQuery(context).size.height;
    }
    return height;
  }
  
  //返回当前屏幕宽度
  double getWidth(BuildContext context) {
    if (width == 0.0) {
        width = getMediaQuery(context).size.width;
    }
    return width;
  }

  //获取设备相关信息
  MediaQueryData getMediaQuery(BuildContext context) {
    if(mediaQuery == null) {
        mediaQuery = MediaQuery.of(context);
    }
      return mediaQuery;
  }
  

} 