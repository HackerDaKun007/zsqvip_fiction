import 'package:flutter/material.dart';

import 'package:fiction/public/public.dart';


class SettingsPage extends StatelessWidget with PixelSize{

  Widget _buildContent(context) {
    return Container(
      width: Config.width,
      padding: EdgeInsets.all(getPixe(10, context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('消息设置'),
          Text('关于我们'),
        ],
      ),
    );
  }

  Widget _settingItem({context, String title, Function callbak}) {
    return InkWell(
      onTap: callbak,
      child: Ink(
        height: getPixe(50, context),
        width: Config.width,
        child: Row(
          children: <Widget>[
            Text(title, )
          ],
        ),
      )
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设置', style: TextStyle(fontSize: getPixe(20, context)),),
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