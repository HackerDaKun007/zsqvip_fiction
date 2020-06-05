import 'package:fiction/public/public.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final PixelSize pixel = PixelSize();

  void openDrawer() {
    Scaffold.of(context).openDrawer();
  }

  void openSettingBar() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true, // 设置为true即可设置高度
        backgroundColor: ZFColors.toolBarColor,
        barrierColor: Colors.transparent,
        elevation: 0,
        builder: (BuildContext context) {
          return Container(
            height: pixel.screenHeightDp(context) * 0.35,
            child: _buildBottomSheetContent(),
          );
        });
  }

  Widget _buildBottomSheetContent() {
    return Container(
      child: Text('hello world'),
    );
  }

  Widget _buildChapterChangeBar() {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: pixel.setFontSize(15, context),
          horizontal: pixel.setFontSize(30, context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            onTap: () {
              print('======= previous chapter ======');
            },
            child: Text(
              '上一章',
              style: TextStyle(
                  color: ZFColors.toolTextColor,
                  fontSize: pixel.setFontSize(16, context),
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            width: pixel.setFontSize(20, context),
          ),
          Expanded(
            child: Container(
              height: 1,
              color: ZFColors.toolTextColor,
            ),
          ),
          SizedBox(
            width: pixel.setFontSize(20, context),
          ),
          InkWell(
              onTap: () {
                print('========== next chapter==========');
              },
              child: Text(
                '下一章',
                style: TextStyle(
                    color: ZFColors.toolTextColor,
                    fontSize: pixel.setFontSize(16, context),
                    fontWeight: FontWeight.w500),
              ))
        ],
      ),
    );
  }

  Widget _buildBottomToolBar() {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: pixel.setFontSize(20, context),
          vertical: pixel.setFontSize(10, context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildBottomBarItem(
              icon: Iconfont.list, title: '目录', callback: openDrawer),
          _buildBottomBarItem(icon: Iconfont.moon, title: '夜间'),
          _buildBottomBarItem(icon: Iconfont.setting, title: '设置'),
          _buildBottomBarItem(icon: Iconfont.more, title: '更多', callback: openSettingBar),
        ],
      ),
    );
  }

  Widget _buildBottomBarItem(
      {IconData icon, String title, VoidCallback callback}) {
    return InkWell(
        onTap: callback,
        child: Column(
          children: <Widget>[
            Icon(
              icon,
              color: ZFColors.toolTextColor,
              size: pixel.setFontSize(26, context),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: pixel.setFontSize(13, context),
                  color: ZFColors.toolTextColor),
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ZFColors.toolBarColor,
      height: pixel.setFontSize(135, context),
      width: pixel.screenWidthDp(context),
      child: Column(
        children: <Widget>[
          _buildChapterChangeBar(),
          Expanded(flex: 1, child: _buildBottomToolBar())
        ],
      ),
    );
  }
}
