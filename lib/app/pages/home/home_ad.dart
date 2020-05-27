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

class _AdWidgetState extends State<AdWidget> with PixelSize{

  List<Map> _adData = adData; 

  @override
  void initState() {
    super.initState();
    _adData.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getWidth(context),
      height: getPixe(180, context),
      margin: EdgeInsets.symmetric(horizontal: getPixe(10, context), vertical: getPixe(15, context)),
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
              borderRadius: BorderRadius.circular(getPixe(8, context)),
              child: Image.network(_adData.last['image'], width: getWidth(context),fit: BoxFit.fitWidth,),
            ),
            Positioned(
              bottom: getPixe(10, context),
              left: getPixe(20, context),
              child: Text('广告', style: TextStyle(fontSize: getPixe(12, context), color: Colors.black26),),
            )
          ]
        )
      )
    );
  }
}