/*
 * @author      Yuri Chen <pluto401zz@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 * 
 * @see         书城页面-广告版块
*/

import 'package:fiction/public/public.dart';
import 'package:fiction/res/adData.dart';
import 'package:flutter/material.dart';

class AdWidget extends StatefulWidget {
  AdWidget({Key key}):super(key:key);
  @override
  _AdWidgetState createState() => _AdWidgetState();
}

class _AdWidgetState extends State<AdWidget> {

  final PixelSize pixel = PixelSize();
  List<Map> _adData = adData; 

  @override
  void initState() {
    super.initState();
    _adData.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: pixel.screenWidthDp(context),
      height: pixel.setFontSize(180, context),
      margin: EdgeInsets.symmetric(horizontal: pixel.setFontSize(10, context), vertical: pixel.setFontSize(15, context)),
      child: InkWell(
        onTap: () {
          print('广告');
          setState(() {
            _adData.shuffle();
          });
        },
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(pixel.setFontSize(8, context)),
              child: Image.network(_adData.last['image'], width: pixel.screenWidthDp(context),fit: BoxFit.fitWidth,),
            ),
            Positioned(
              bottom: pixel.setFontSize(10, context),
              left: pixel.setFontSize(20, context),
              child: Text('广告', style: TextStyle(fontSize: pixel.setFontSize(12, context), color: Colors.black26),),
            )
          ]
        )
      )
    );
  }
}