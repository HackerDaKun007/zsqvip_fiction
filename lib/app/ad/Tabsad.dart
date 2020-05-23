/**
 * @author      HackerDaKun007 <hackerdakun007@gmail.com> 
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         首页栏目右下角区域广告 - 底部广告位置
*/
import 'package:flutter/material.dart';
import 'package:fiction/public/public.dart';

class TabsAd extends StatefulWidget {
  TabsAd({Key key}) : super(key: key);

  @override
  _TabsAdState createState() => _TabsAdState();
}

class _TabsAdState extends State<TabsAd> with PixelSize {
  int _num = 1;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: getPixe(20, context),
      right: 20,
      child: Container(
        width: getPixe(60, context),
        height: getPixe(60, context),
        child: GestureDetector(
          child: Center(
            child: Text("$_num", style: TextStyle(
              color: Colors.red,
            ),),
          ),
          onTap: () {
            // print('底部广告');
            setState(() {
              this._num += 1;
            });
          },
        ),
        color: Colors.blue,
      ),
    );
  }
}
