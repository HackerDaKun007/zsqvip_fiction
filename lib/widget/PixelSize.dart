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

class PixelSize {
  var win = window.physicalSize; //获取屏幕

  double getPixe(int number) {
    int defaultValue = 750;
    double width = win.width;
    // if(width >= 1080) { //针对大屏幕优化和苹果8p
    //   width = width - 200;
    // } 
    print(width);
    return number * (width / defaultValue);
  }

} 