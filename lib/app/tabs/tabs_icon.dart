/*
 * @author      Yuri Chen <pluto401zz@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         底部导航栏图标
*/ 



import 'package:flutter/material.dart';

class MyIcons {
  // 图书
  static const IconData book = const IconData(
    0xe6be,
    fontFamily: 'myIcon',
    matchTextDirection: true
  );
  static const IconData book_active = const IconData(
    0xee38,
    fontFamily: 'myIcon',
    matchTextDirection: true
  );

  // 首页
  static const IconData home = const IconData(
    0xe731,
    fontFamily: 'myIcon',
    matchTextDirection: true
  );
  static const IconData home_active = const IconData(
    0xe631,
    fontFamily: 'myIcon',
    matchTextDirection: true
  );

  // 分类
  static const IconData category = const IconData(
    0xe7f9,
    fontFamily: 'myIcon',
    matchTextDirection: true
  );
  static const IconData category_active = const IconData(
    0xe7f8,
    fontFamily: 'myIcon',
    matchTextDirection: true
  );

  // 我的
  static const IconData mine = const IconData(
    0xe78b,
    fontFamily: 'myIcon',
    matchTextDirection: true
  );
  static const IconData mine_active = const IconData(
    0xe78c,
    fontFamily: 'myIcon',
    matchTextDirection: true
  );
  
}