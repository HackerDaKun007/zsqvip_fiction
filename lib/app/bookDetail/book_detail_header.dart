/*
 * @author      Yuri Chen <pluto401zz@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 * 
 * @see         书籍界面-头部
*/

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:fiction/public/public.dart';


class BookDetailHeader extends StatelessWidget {
  final PixelSize pixel = PixelSize();
  
  final dynamic data;
  BookDetailHeader({this.data, Key key}):super(key: key);

  Widget _buildHeaderContent(context) {
    double paddingTop = pixel.statusBarHeight(context);
    return Container(
      height: pixel.setFontSize(220, context),
      width: pixel.screenWidthDp(context),
      padding: EdgeInsets.fromLTRB(
          pixel.setFontSize(15, context), pixel.setFontSize(58 + paddingTop, context), pixel.setFontSize(10, context), 0),
      child: Row(
        children: <Widget>[
          Material(
            elevation: 5,
            color: Colors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(pixel.setFontSize(4, context)),
              child: Image.network(
                data['imageUrl'],
                width: pixel.setFontSize(100, context),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          SizedBox(
            width: pixel.setFontSize(20, context),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                data['title'],
                maxLines: 2,
                style: TextStyle(
                    fontSize: pixel.setFontSize(22, context),
                    fontWeight: FontWeight.w500),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data['author'],
                    style: TextStyle(
                      fontSize: pixel.setFontSize(14, context),
                      color: Colors.black45
                    )
                  ),
                  SizedBox(height: pixel.setFontSize(5, context),),
                  Text(
                    '${data['category'][0]} · ${data['update_status']} · ${(data['total_num'] / 10000).floor()}万字',
                    style: TextStyle(
                      fontSize: pixel.setFontSize(13, context),
                      color: Colors.black45
                    )
                  ),
                  SizedBox(height: pixel.setFontSize(5, context),),
                  Text(
                    '${(data['total_num'] / 10000).round()} 万人气',
                    style: TextStyle(
                      fontSize: pixel.setFontSize(16, context),
                    )
                  ),
                ],
              )
            ],
          )
        ],
      ));
  }


  @override
  Widget build(BuildContext context) {
    double width = pixel.screenWidthDp(context);
    double height = pixel.statusBarHeight(context)+ 200;
    return Container(
      width: width,
      height: pixel.setFontSize(height, context),
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: NetworkImage(data['imageUrl']),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.linearToSrgbGamma(),
        )
      ),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: _buildHeaderContent(context)
      ),
    );
  }
}