/**
 * @author      dakun007 <dakun007@hotmail.com>  YuriChen <pluto401zz@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         定义类型 - 像素大小
*/

import 'dart:ui';

class PixelSize {
  var win = window.physicalSize; //获取屏幕

  double getPixe(int number) {
    int defaultValue = 750;
    double width = win.width;
    //  print(width);
    if(width >= 1242) { //针对大屏幕优化和苹果8p
      width = width - 414;
    }
    // print(width);
    // print(number * (width / defaultValue));
    // print(val);
    // print(MediaQuery.of(context).size.width / 750);
    // print(MediaQuery.of(context).size.width);
    // print(width / defaultValue);
    // print(number * (width / defaultValue));
    return (number * (width / defaultValue));
  }

} 