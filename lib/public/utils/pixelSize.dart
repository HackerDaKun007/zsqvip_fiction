/*
 * @author      HackerDaKun007 <hackerdakun007@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         像素大小
*/

import 'package:flutter/cupertino.dart';

class PixelSize {
  
  //设计稿的设备尺寸
  double width;
  double height;

  //获取屏幕相关元素
  static MediaQueryData _mediaQueryData;


  //初始化
  PixelSize({
    this.width = 750,
    this.height = 1334,
  });

  //获取屏幕相关元素方法
  MediaQueryData mediaQueryData(BuildContext context) {
    if (_mediaQueryData == null) {
      _mediaQueryData = MediaQuery.of(context);
    }
    return _mediaQueryData;
  }

  //根据设计稿的设备宽度适配 ///高度也根据这个来做适配可以保证不变形
  setWidth(double width, BuildContext context) =>
      width * (screenWidthDp(context) / this.width);

  // 高度适配主要针对想根据设计稿的一屏展示一样的效果
  setHeight(double height, BuildContext context) =>
      height * (screenHeightDp(context) / this.height);

  //字体大小适配方法 
  //@param fontSize 传入设计稿上字体的 px ,  mediaQueryData(context).textScaleFactor //控制字体是要根据系统的“字体大小”辅助选项来进行缩 放
  setFontSize(double fontSize, BuildContext context) =>
      (setWidth(fontSize, context) / textScaleFactory(context)) * 1.75;


  // 每个逻辑像素的字体像素数，字体的缩放比例 
  textScaleFactory(BuildContext context) => mediaQueryData(context).textScaleFactor; 
  // 设备的像素密度 
  pixelRatio(BuildContext context) => mediaQueryData(context).devicePixelRatio; 
  // 当前设备宽度 dp 
  screenWidthDp(BuildContext context) => mediaQueryData(context).size.width; 
  // 当前设备高度 dp 
  screenHeightDp(BuildContext context) => mediaQueryData(context).size.height; 
  // 当前设备宽度 px 
  screenWidth(BuildContext context) => screenWidthDp(context) * pixelRatio(context); 
  // 当前设备高度 px 
  screenHeight(BuildContext context) => screenHeightDp(context) * pixelRatio(context); 
  // 状态栏高度 dp 刘海屏会更高 
  statusBarHeight(BuildContext context) => mediaQueryData(context).padding.top;
  // 底部安全区距离 dp 
  bottomBarHeight(BuildContext context) => mediaQueryData(context).padding.bottom; 
} 