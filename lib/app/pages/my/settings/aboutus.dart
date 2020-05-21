import 'package:fiction/public/public.dart';
import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget with PixelSize {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '关于我们',
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
      body: Container(
      child: Text('About Us'),
      ),
    );
  }
}