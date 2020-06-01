import 'package:fiction/public/public.dart';
import 'package:flutter/material.dart';

class BonusDetailPage extends StatefulWidget {
  @override
  _BonusDetailPageState createState() => _BonusDetailPageState();
}

class _BonusDetailPageState extends State<BonusDetailPage> with PixelSize{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '积分明细',
          style: TextStyle(fontSize: getPixe(20, context)),
        ),
        centerTitle: true,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Iconfont.zuo),
          iconSize: getPixe(26, context),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
       
      ),
      body: ListView(
        
      ),
    );
  }
}