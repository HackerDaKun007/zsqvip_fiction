/*
 * @author      HackerDaKun007 <hackerdakun007@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         执行模块
*/

import 'dart:io';

import 'package:flutter/material.dart';

import 'package:fiction/route/route.dart'; //路由文件
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; //国际包

import 'package:provider/provider.dart'; //provider
//大坤配置_provider
import 'package:fiction/providers/readTime.dart'; //阅读时间
import 'package:fiction/providers/bookShelf.dart'; //书架数据
import 'package:fiction/providers/recordingData.dart'; //阅读记录数据

//Yuri_provider
import 'package:fiction/providers/tabIndexProvider.dart'; // 导航栏记录

void main() {
  runApp(MyApp());

  // 设置安卓沉浸式
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ReadTimeProvider()), //阅读时间
        ChangeNotifierProvider(create: (_) => BookShelfProviders()), //书架数据
        ChangeNotifierProvider(create: (_) => RecordingDataProviders()), //阅读记录
        ChangeNotifierProvider(create: (_) => TabIndexProvider()), //导航栏记录
      ],
      child: MaterialApp(
        //配置国际中文
        localizationsDelegates: [
          //此处
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        //配置国际中文
        supportedLocales: [
          //此处
          const Locale('zh', 'CH'),
          const Locale('en', 'US'),
        ],
        debugShowCheckedModeBanner: false, //移除左上角的图标
        initialRoute: '/', //初始化加载路由

        onGenerateRoute: onGenerateRoute,
        theme: ThemeData(
            primaryColor: Colors.white, splashColor: Colors.transparent),
      ),
    );
  }
}
