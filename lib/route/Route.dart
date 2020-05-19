import 'package:fiction/app/book_list/book_list_detail.dart';
import 'package:fiction/app/book_list/book_list_page.dart';
/**
 * @author      HackerDaKun007 <hackerdakun007@gmail.com>
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
import 'package:fiction/app/pages/home/Home.dart';  //书城
import 'package:fiction/app/pages/bookshelf/BookShelf.dart'; //书架
import 'package:fiction/app/pages/Category.dart';  //分类
import 'package:fiction/app/pages/My.dart';  //我的
import 'package:fiction/app/search/Search.dart';  //搜索页面
import 'package:fiction/app/search/Result.dart';  //搜索结果页面

//Yuri配置_路由区域
import 'package:fiction/app/pages/home/top_charts.dart'; // 排行榜

//配置命令路由
final routes = {
  '/': (context) => Tabs(),
  '/home': (context) => HomePage(),
  '/bookshelf': (context) => BookShelfPage(),
  '/categorypage': (context) => CategoryPage(),
  '/mypage': (context) => MyPage(),
  '/search': (context) => Search(),
  '/result': (context, {arguments}) => ResultSearch(arguments:arguments),

  //Yuri配置_路由区域
  '/topcharts': (context) => TopChartsPage(),
  '/booklist': (context) => BookListPage(),
  '/booklistdetail': (context, {arguments}) => BookListDetail(arguments:arguments),
  
};

var onGenerateRoute = (RouteSettings settings) {
  // 统一处理 MaterialPageRoute CupertinoPageRoute
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