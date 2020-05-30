import 'package:fiction/public/public.dart';
import 'package:flutter/material.dart';

class BonusStorePage extends StatefulWidget {
  @override
  _BonusStorePageState createState() => _BonusStorePageState();
}

class _BonusStorePageState extends State<BonusStorePage> with PixelSize {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '积分兑换',
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
        actions: <Widget>[
          InkWell(
              onTap: () {},
              child: Container(
                  padding: EdgeInsets.only(
                    right: getPixe(15, context),
                  ),
                  child: Center(
                    child: Text(
                      '明细',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: getPixe(16, context),
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  )))
        ],
      ),
    );
  }
}