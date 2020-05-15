/**
 * @author      dakun007 <dakun007@hotmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         路由配置文件
*/
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';  //动画执行

//大坤配置_路由区域
import 'package:fiction/app/tabs/Tabs.dart';  //首页底部导航栏目
import 'package:fiction/app/pages/Home.dart';  //书城
import 'package:fiction/app/pages/BookShelf.dart';  //书架
import 'package:fiction/app/pages/Category.dart';  //分类
import 'package:fiction/app/pages/My.dart';  //我的

//晓镘配置_路由区域


//配置命令路由
final routes = {
  '/': (context) => Tabs(),
  '/home': (context) => HomePage(),
  '/bookshelf': (context) => BookShelfPage(),
  '/categorypage': (context) => CategoryPage(),
  '/mypage': (context) => MyPage(),
  
};

var onGenerateRoute = (RouteSettings settings) {
  // 统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = CupertinoPageRoute(
          builder: (context) => pageContentBuilder(context,
              arguments: settings.arguments));
      return route;
    } else {
      final Route route = CupertinoPageRoute(
          builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};