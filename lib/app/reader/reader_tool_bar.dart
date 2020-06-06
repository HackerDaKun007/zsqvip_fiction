/*
 * @author      Yuri Chen <pluto401zz@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         阅读页面 - 顶部栏
*/

import 'package:fiction/public/public.dart';
import 'package:flutter/material.dart';

class ReaderToolBar extends StatefulWidget {
  @override
  _ReaderToolBarState createState() => _ReaderToolBarState();
}

class _ReaderToolBarState extends State<ReaderToolBar> {
  final PixelSize pixel = PixelSize();


  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight + pixel.statusBarHeight(context),
      padding: EdgeInsets.only(top: pixel.statusBarHeight(context), left: pixel.setFontSize(5, context)),
      width: pixel.screenWidthDp(context),
      color: ZFColors.toolBarColor,
      child: Row(
        children: <Widget>[
          IconButton(
          icon: Icon(Iconfont.zuo,color: ZFColors.toolTextColor,),
          iconSize: pixel.setFontSize(26, context),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        ],
      )
    );
  }
}