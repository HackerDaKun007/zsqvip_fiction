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
// import 'package:fiction/app/Text.dart';  //测试
import 'package:fiction/app/tabs/tabs.dart';  //首页底部导航栏目
import 'package:fiction/app/pages/home/home.dart';  //书城
import 'package:fiction/app/pages/bookshelf/bookShelf.dart'; //书架
import 'package:fiction/app/pages/bookShelf/recorDing.dart';  //阅读记录
import 'package:fiction/app/pages/bookShelf/editBookShelf.dart';  //编辑书架
import 'package:fiction/app/search/search.dart';  //搜索页面
import 'package:fiction/app/search/result.dart';  //搜索结果页面

import 'package:fiction/app/pages/category/category.dart';  //分类
import 'package:fiction/app/pages/my/my.dart';  //我的

//文章目录
import 'package:fiction/app/article/present.dart';  //介绍

//Yuri配置_路由区域
import 'package:fiction/app/pages/home/top_charts.dart'; // 排行榜页面
import 'package:fiction/app/bookList/book_list_detail.dart'; // 书单详情页面
import 'package:fiction/app/bookList/book_list_page.dart'; // 书单页面
import 'package:fiction/app/pages/my/settings/settings_page.dart'; // 设置页面
import 'package:fiction/app/pages/my/settings/aboutus.dart';  // 关于我们页面
import 'package:fiction/app/bookDetail/book_detail_page.dart'; // 书籍详情页面

//配置命令路由
final routes = {

  //大坤配置_路由区域
  // '/text': (context) => MyHomePage(),
  '/': (context) => Tabs(),
  '/home': (context) => HomePage(),
  '/bookshelf': (context) => BookShelfPage(),
  '/recording': (context) => Recording(),
  '/editbookshelf': (context) => EditBookShelf(),

  '/search': (context) => Search(),
  '/result': (context, {arguments}) => ResultSearch(arguments:arguments),

  '/categorypage': (context) => CategoryPage(),
  '/mypage': (context) => MyPage(),

  //文章
  '/present': (context) => Present(), //介绍

  //Yuri配置_路由区域
  '/topcharts': (context) => TopChartsPage(),
  '/booklist': (context) => BookListPage(),
  '/booklistdetail': (context, {arguments}) => BookListDetail(arguments:arguments),
  '/settings': (context) => SettingsPage(),
  '/aboutus': (context) => AboutUsPage(),
  '/bookdetail': (context, {arguments}) => BookDetailPage(arguments:arguments),
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