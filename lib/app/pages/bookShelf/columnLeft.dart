/*
 * @author      HackerDaKun007 <hackerdakun007@gmail.com> 
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         书架页面 - 顶部导航左边阅读分钟
*/

import 'package:flutter/material.dart';
import 'package:fiction/public/public.dart';
import 'package:fiction/app/readTime/readTime.dart';

GlobalKey<_ColumnLetState> columnLetTime = GlobalKey();
class ColumnLet  extends StatefulWidget {
  ColumnLet({
    Key key,
  }) : super(key: key);
  @override
  _ColumnLetState createState() => _ColumnLetState();
}
 
class _ColumnLetState extends State<ColumnLet> {
  
  PixelSize pixel = PixelSize();
 
  double appBarAlpha = 0.0;

  void updateOpacity(double appBarAlpha){
    setState(() {
      this.appBarAlpha = appBarAlpha;
    });
  }
 
  @override

  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Opacity(
        opacity: this.appBarAlpha,
        child: Container(
          height: pixel.setHeight(120, context),
          width: double.infinity,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                pixel.setWidth(10, context), pixel.setHeight(35, context), 0, 0),
            child: Row(
              children: <Widget>[
                Text('今天阅读'),
                Padding(
                  padding: EdgeInsets.fromLTRB(3, 0, 3, 6),
                  child: ReadTime(style:TextStyle(
                          fontSize: pixel.setFontSize(20, context), color: Colors.black))
                ),
                Text('分钟'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
