
import 'package:fiction/app/ad/readerAd.dart';
import 'package:fiction/app/reader/reader_bottom_bar.dart';
import 'package:fiction/app/reader/reader_drawer.dart';
import 'package:fiction/app/reader/reader_tool_bar.dart';
import 'package:fiction/public/public.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReaderPage extends StatefulWidget {
  final arguments;
  ReaderPage({this.arguments});

  @override
  _ReaderPageState createState() => _ReaderPageState();
}

class _ReaderPageState extends State<ReaderPage> {
  double textSize = 20;
  bool isVisible = false;
  dynamic _data;
  final PixelSize pixel = PixelSize();


  @override
  void initState() {
    super.initState();
    _data = widget.arguments['data'];
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  onTapHandler(Offset position) {
    double xRate = position.dx / pixel.screenWidthDp(context);
    if (xRate > 0.33 && xRate < 0.66) {
      systemStatusBarHandler();
    } else if (xRate >= 0.66) {}
  }

  void systemStatusBarHandler() {
    setState(() {
      isVisible = !isVisible;
      isVisible
          ? SystemChrome.setEnabledSystemUIOverlays(
              [SystemUiOverlay.top, SystemUiOverlay.bottom])
          : SystemChrome.setEnabledSystemUIOverlays([]);
    });
  }

  Widget _buildContent() {
    return Container(
      width: pixel.screenWidthDp(context),
      height: pixel.screenHeightDp(context),
      // padding: EdgeInsets.only(top: pixel.statusBarHeight(context)),
      color: ZFColors.paperColor,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: EdgeInsets.all(pixel.setFontSize(20, context)),
          child: Text(
            '第四章：突发情况',
            style: TextStyle(
                fontSize: pixel.setFontSize(12, context),
                color: ZFColors.textColor),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(top: kToolbarHeight),
            child: Text.rich(TextSpan(children: [
              TextSpan(
                  text: '生活时尚上升空间空间',
                  style: TextStyle(
                      color: ZFColors.textColor,
                      fontSize: pixel.setFontSize(textSize, context)))
            ])),
          ),
        ),
        Container (
            padding: EdgeInsets.all(pixel.setFontSize(20, context)),
            child: Text(
                    '1/28',
                    style: TextStyle(
                        fontSize: pixel.setFontSize(12, context),
                        color: ZFColors.textColor),
                  ),),
        ReaderAd()
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ZFColors.paperColor,
      drawer: Drawer(
        child: ReaderDrawer(data: _data),
      ),
      drawerEdgeDragWidth: 0.0,
      body: Stack(children: [
        GestureDetector(
          onTapUp: (TapUpDetails details) {
            onTapHandler(details.globalPosition);
          },
          child: _buildContent(),
        ),
        Positioned(
          top: isVisible
              ? 0
              : -(pixel.statusBarHeight(context) + kToolbarHeight),
          child: ReaderToolBar(),
        ),
        Positioned(
            bottom: isVisible
                ? 0
                : -(pixel.bottomBarHeight(context) +
                    pixel.setFontSize(135, context)),
            child: BottomBar(data: _data,))
      ]),
    );
  }
}
