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

class SettingsPage extends StatelessWidget with PixelSize {
  Widget _buildContent(context) {
    return Container(
      width: Config.width,
      padding: EdgeInsets.symmetric(vertical: getPixe(10, context)),
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
          horizontal: getPixe(15, context), vertical: getPixe(20, context)),
          width: Config.width,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: Colors.grey[200],))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(fontSize: getPixe(16, context), height: 1),
              ),
              Icon(
                Icons.chevron_right,
                size: getPixe(22, context),
                color: Colors.grey,
              )
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff7f7f7),
      appBar: AppBar(
        title: Text(
          '设置',
          style: TextStyle(fontSize: getPixe(20, context)),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Iconfont.zuo),
          iconSize: getPixe(30, context),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _buildContent(context),
    );
  }
}
