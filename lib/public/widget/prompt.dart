/*
 * @author      HackerDaKun007 <hackerdakun007@gmail.com> 
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         背景提示相关信息
*/

import 'package:flutter/material.dart';
import 'package:fiction/public/public.dart';

class Prompt extends StatelessWidget {

  PixelSize pixel = PixelSize(); 

  String _content = '当前没有任何内容';
  double topMargin; // 顶部margin
  Prompt(this._content, {Key key, this.topMargin}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(
                0,
                pixel.setHeight(this.topMargin != null ? this.topMargin : 200, context),
                0,
                pixel.setHeight(10, context)),
            height: pixel.setHeight(150, context),
            child: Image.asset('images/back1.png', fit: BoxFit.fill),
          ),
          Text(
            this._content,
            style: TextStyle(
              fontSize: pixel.setFontSize(14, context),
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
