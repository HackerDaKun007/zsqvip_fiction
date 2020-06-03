import 'package:fiction/app/reader/reader_bottom_bar.dart';
import 'package:fiction/app/reader/reader_tool_bar.dart';
import 'package:fiction/public/public.dart';
import 'package:flutter/material.dart';

class ReaderPage extends StatefulWidget {
  final arguments;
  ReaderPage({this.arguments});

  @override
  _ReaderPageState createState() => _ReaderPageState();
}

class _ReaderPageState extends State<ReaderPage> {
  Color paperColor = Color(0xffF0E3C0);
  Color textColor = Color(0xff603c18);
  double textSize = 20;
  final PixelSize pixel = PixelSize();

  Widget _buildContent() {
    return Container(
      width: pixel.screenWidthDp(context),
      height: pixel.screenHeightDp(context),
      padding: EdgeInsets.only(top: kToolbarHeight+pixel.statusBarHeight(context)),
      color:  Color(0xffF0E3C0),
      child: Text.rich(
        TextSpan(children: [
          TextSpan(
            text: '生活时尚上升空间空间',
            style: TextStyle(color: textColor, fontSize: pixel.setFontSize(textSize, context))
          )
        ])
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: paperColor,
      body: Stack(
        children: [
          _buildContent(),
          Positioned(
            top: 0,
            left: 0,
            child: ReaderToolBar(),
          ),
          Positioned(
            bottom: 0,
            child: BottomBar()
          )
        ]
      ),
    );
  }
}
