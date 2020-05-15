// import 'package:flutter/material.dart';
import 'dart:ui';

// import 'package:flutter/cupertino.dart';

//定义类型 - 像素大小
class PixelSize {
  var win = window.physicalSize; //获取屏幕

  double fontSize(int number) {
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