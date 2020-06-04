import 'dart:io';

import 'package:fiction/public/public.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReaderToolBar extends StatefulWidget {
  @override
  _ReaderToolBarState createState() => _ReaderToolBarState();
}

class _ReaderToolBarState extends State<ReaderToolBar> {
  final PixelSize pixel = PixelSize();
  Color paperColor = Color(0xFFF5F5F5);



  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight + pixel.statusBarHeight(context),
      padding: EdgeInsets.only(top: pixel.statusBarHeight(context), left: pixel.setFontSize(5, context)),
      width: pixel.screenWidthDp(context),
      color: Color(0xffE3D5AE),
      child: Row(
        children: <Widget>[
          IconButton(
          icon: const Icon(Iconfont.zuo, color: Color(0xffb9610b),),
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