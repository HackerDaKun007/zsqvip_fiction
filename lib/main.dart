/**
 * @author      dakun007 <dakun007@hotmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         执行模块
*/

import 'package:flutter/material.dart';

import 'package:fiction/route/Route.dart'; //路由文件
import 'package:flutter_localizations/flutter_localizations.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      theme: ThemeData(primaryColor: Colors.white,),
    );
  }
}
