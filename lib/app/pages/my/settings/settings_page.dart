/*
 * @author      Yuri Chen <pluto401zz@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         设置界面
*/

import 'package:flutter/material.dart';

import 'package:fiction/public/public.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key key}):super(key: key);
  final PixelSize pixel = PixelSize();


  Widget _buildContent(context) {
    return Container(
      width: pixel.screenWidthDp(context),
      padding: EdgeInsets.symmetric(vertical: pixel.setFontSize(10, context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _settingItem(title: '消息通知', context: context, callback: null),
          _settingItem(title: '关于我们', context: context, callback: () {
            Navigator.pushNamed(context, '/aboutus');
          }),
        ],
      ),
    );
  }

  Widget _settingItem({context, String title, Function callback}) {
    return InkWell(
        onTap: callback,
        child: Ink(
          padding: EdgeInsets.symmetric(
          horizontal: pixel.setFontSize(15, context), vertical: pixel.setFontSize(20, context)),
          width: pixel.screenWidthDp(context),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: Colors.grey[200],))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(fontSize: pixel.setFontSize(16, context), height: 1),
              ),
              Icon(
                Icons.chevron_right,
                size: pixel.setFontSize(22, context),
                color: Colors.grey,
              )
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f7f7),
      appBar: AppBar(
        title: Text(
          '设置',
          style: TextStyle(fontSize: pixel.setFontSize(20, context)),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Iconfont.zuo),
          iconSize: pixel.setFontSize(26, context),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _buildContent(context),
    );
  }
}
