import 'package:fiction/public/public.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final PixelSize pixel = PixelSize();

  Widget _buildChapterChangeBar() {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: pixel.setFontSize(15, context),
          horizontal: pixel.setFontSize(30, context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            onTap: () {},
            child: Text(
              '上一章',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: pixel.setFontSize(16, context)),
            ),
          ),
          SizedBox(
            width: pixel.setFontSize(20, context),
          ),
          Expanded(
            child: Container(
              height: 1,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: pixel.setFontSize(20, context),
          ),
          InkWell(
              onTap: () {},
              child: Text(
                '下一章',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: pixel.setFontSize(16, context)),
              ))
        ],
      ),
    );
  }


  Widget _buildBottomToolBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: pixel.setFontSize(20, context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildBottomBarItem()
        ],
      ),
    );
  }

  Widget _buildBottomBarItem() {
    return InkWell(
      onTap: () {},
      child: Column(
        children: <Widget>[
          Icon(Icons.list, color: Colors.white,),
          Text('目录', style: TextStyle(fontSize: pixel.setFontSize(14, context), color: Colors.white),)
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.7),
      height: pixel.setFontSize(150, context),
      width: pixel.screenWidthDp(context),
      child: Column(
        children: <Widget>[_buildChapterChangeBar(),_buildBottomToolBar()],
      ),
    );
  }
}
