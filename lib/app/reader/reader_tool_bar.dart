import 'package:fiction/public/public.dart';
import 'package:flutter/material.dart';

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
      padding: EdgeInsets.only(top: pixel.statusBarHeight(context)),
      width: pixel.screenWidthDp(context),
      color: Colors.black.withOpacity(0.7),
      child: Row(
        children: <Widget>[
          IconButton(
          icon: const Icon(Iconfont.zuo, color: Colors.white,),
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