/*
 * @author      Yuri Chen <pluto401zz@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         阅读页面 - 底部工具栏
*/

import 'package:fiction/public/public.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  final Map data;
  BottomBar({this.data});
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final PixelSize pixel = PixelSize();
  double _value = 0;

  /// 弹出目录侧边栏
  void openDrawer() {
    Scaffold.of(context).openDrawer();
  }

  /// 弹出底部栏
  void openMoreBar() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true, // 设置为true即可设置高度
        backgroundColor: ZFColors.toolBarColor,
        elevation: 0,
        builder: (BuildContext context) {
          return Container(
            height: pixel.screenHeightDp(context) * 0.2,
            child: _buildBottomSheetContent(),
          );
        });
  }

  /// 更多
  Widget _buildBottomSheetContent() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/bookdetail',
                    arguments: {'data': widget.data});
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                    vertical: pixel.setFontSize(15, context),
                    horizontal: pixel.setFontSize(30, context)),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Iconfont.bookDetail,
                      color: ZFColors.textColor,
                      size: pixel.setFontSize(23, context),
                    ),
                    SizedBox(
                      width: pixel.setWidth(25, context),
                    ),
                    Expanded(
                      child: Text(
                        '书籍详情',
                        style: TextStyle(
                            fontSize: pixel.setFontSize(15, context),
                            color: ZFColors.textColor),
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }

  /// 切换上下文章
  Widget _buildChapterChangeBar() {
    final double _progressWidth = pixel.setWidth(360, context);
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
            child:  Container(
              height: pixel.setFontSize(30, context),
              child: Slider(
                value: _value,
                onChanged: (double value) {
                  setState(() {
                    _value = value;
                    print(_value);
                  });
                },
                // onChangeEnd: (double value) {
                //   // Chapter chapter = this.widget.chapters[currentArticleIndex()];
                //   // this.widget.onToggleChapter(chapter);
                // },
                activeColor: ZFColors.toolTextColor,
                inactiveColor: Colors.black.withOpacity(0.2),
              ),
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

  /// 底部工具栏
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
          _buildBottomBarItem(
              icon: Iconfont.more, title: '更多', callback: openMoreBar),
        ],
      ),
    );
  }

  /// 底部工具栏按钮
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
      height: pixel.setHeight(250, context),
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
