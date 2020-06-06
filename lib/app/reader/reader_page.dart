/*
 * @author      Yuri Chen <pluto401zz@gmail.com> 
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         阅读页面 - 主页
*/



import 'package:fiction/app/ad/readerAd.dart';
import 'package:fiction/app/reader/reader_bottom_bar.dart';
import 'package:fiction/app/reader/reader_drawer.dart';
import 'package:fiction/app/reader/reader_tool_bar.dart';
import 'package:fiction/public/public.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


String articleContent = '<h3>第1章：点名要她</h3><p>　　“音音啊，你爸爸病倒，现在还在ICU，我们都不能进去探望他呜呜呜……”</p><p>　　“音音，他们趁你爸爸生病弄了一批辐射珠宝。”</p><p>　　“音音，你爸爸当初给你杜叔叔做担保，你杜叔叔破产，公司被冻结，银行要你爸爸赔三亿。”</p><p>　　……</p><p>　　电话里的哭诉一声比一声凄惨和绝望。</p><p>　　回应电话的是“笃笃笃”有规律的刀与砧板碰撞的声音。</p><p>　　少女的手机远远放在与操作台相连的木质饭桌上，少女系着围裙，乌黑长发高挽，修长的身体站在砧板前，手起刀落，手法娴熟迅速的用刀背敲打着鱼肉面。</p><p>　　少女的手机远远放在与操作台相连的木质饭桌上，少女系着围裙，乌黑长发高挽，修长的身体站在砧板前，手起刀落，手法娴熟迅速的用刀背敲打着鱼肉面。</p><p>　　电话那头的方美娴哭了半晌，没有得到女儿一言半语的回应，停下了抽泣声，听到了熟悉的声音，顿时怒火高涨。</p><p>　　“郦唯音，你有没有良心，你爸进了ICU面临破产，你妈妈和妹妹都快流落街头，你还有心情做菜！”</p><p>　　尖锐的指责声，让郦唯音停下了手上的动作，她看了看鱼肉，放下了刀，拿了一把钢精匙，同时伸手把手机抓近一些。</p>';

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
            padding: EdgeInsets.only(
                top: pixel.statusBarHeight(context),
                left: pixel.setFontSize(20, context),
                right: pixel.setFontSize(20, context),
                ),
            child: Container(
              // padding: EdgeInsets.only(top:pixel.setFontSize(10, context)),
              child: Text.rich(TextSpan(children: [
                TextSpan(
                    text: articleContent,
                    style: TextStyle(
                        color: ZFColors.textColor,
                        fontSize: pixel.setFontSize(textSize, context), height: 1.7,),
                    )
              ])),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(pixel.setFontSize(20, context)),
          child: Text(
            '1/28',
            style: TextStyle(
                fontSize: pixel.setFontSize(12, context),
                color: ZFColors.textColor),
          ),
        ),
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
            child: BottomBar(
              data: _data,
            ))
      ]),
    );
  }
}
