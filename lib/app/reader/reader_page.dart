
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
  final PixelSize pixel = PixelSize();
  bool isVisible = false;
  dynamic _data;


  @override
  void initState() {
    super.initState();
    _data = widget.arguments['data'];
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
      padding:
          EdgeInsets.only(top: kToolbarHeight + pixel.statusBarHeight(context)),
      color: ZFColors.paperColor,
      child: Text.rich(TextSpan(children: [
        TextSpan(
            text: '生活时尚上升空间空间',
            style: TextStyle(
                color: ZFColors.textColor,
                fontSize: pixel.setFontSize(textSize, context)))
      ])),
    );
  }

  Widget _buildDrawer() {
    return Container(
      color: ZFColors.toolBarColor,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(pixel.setWidth(20, context), pixel.statusBarHeight(context)+10, pixel.setWidth(20, context), pixel.setHeight(30, context)),
            color: ZFColors.paperColor,
            child:Stack(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.network(_data['imageUrl'], width: pixel.setWidth(110, context), fit: BoxFit.fitWidth,),
                    SizedBox(width: pixel.setWidth(20, context),),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(_data['title'], style: TextStyle(fontSize: pixel.setFontSize(20, context), fontWeight: FontWeight.w500),),
                        Text(_data['author']),
                        Text('共${_data['chapter']}章'),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: InkWell(
                    child: Icon(Icons.swap_vert,size: pixel.setFontSize(26, context), color: ZFColors.textColor,),
                    onTap: (){print('========== reversed ======');},
                  )
                )
              ]
            ),
          ),
         
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ZFColors.paperColor,
      drawer: Drawer(
        child: ReaderDrawer(data:_data),
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
            child: BottomBar())
      ]),
    );
  }
}
