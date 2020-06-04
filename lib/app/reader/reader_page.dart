import 'dart:io';

import 'package:fiction/app/reader/reader_bottom_bar.dart';
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
  Color paperColor = Color(0xffF0E3C0);
  Color textColor = Color(0xff603c18);
  double textSize = 20;
  final PixelSize pixel = PixelSize();
  bool isVisible = false;

  // AnimationController _animationController;
  // Animation _animation;

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle =
          SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
    SystemChrome.setEnabledSystemUIOverlays([]);
    // _animationController = AnimationController(
    //     vsync: this, duration: const Duration(milliseconds: 200));
    // _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
    // _animation.addListener(() {
    //   setState(() {});
    // });
    // _animationController.forward();
  }

  onTapHandler(Offset position) {
    double xRate = position.dx / pixel.screenWidthDp(context);
    if (xRate > 0.33 && xRate < 0.66) {
      setState(() {
        isVisible = !isVisible;
        isVisible
            ? SystemChrome.setEnabledSystemUIOverlays(
                [SystemUiOverlay.top, SystemUiOverlay.bottom])
            : SystemChrome.setEnabledSystemUIOverlays([]);

        print(isVisible);
      });
    } else if (xRate >= 0.66) {}
  }

  Widget _buildContent() {
    return Container(
      width: pixel.screenWidthDp(context),
      height: pixel.screenHeightDp(context),
      padding:
          EdgeInsets.only(top: kToolbarHeight + pixel.statusBarHeight(context)),
      color: Color(0xffF0E3C0),
      child: Text.rich(TextSpan(children: [
        TextSpan(
            text: '生活时尚上升空间空间',
            style: TextStyle(
                color: textColor,
                fontSize: pixel.setFontSize(textSize, context)))
      ])),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: paperColor,
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
            child: BottomBar())
      ]),
    );
  }
}
