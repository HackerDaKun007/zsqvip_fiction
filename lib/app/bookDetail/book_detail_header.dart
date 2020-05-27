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


class BookDetailHeader extends StatelessWidget with PixelSize{
  
  final dynamic data;
  BookDetailHeader({this.data, Key key}):super(key: key);

  Widget _buildHeaderContent(context) {
    double paddingTop = getMediaQuery(context).padding.top;
    return Container(
      height: getPixe(220, context),
      width: getWidth(context),
      padding: EdgeInsets.fromLTRB(
          getPixe(15, context), getPixe(58 + paddingTop, context), getPixe(10, context), 0),
      child: Row(
        children: <Widget>[
          Material(
            elevation: 5,
            color: Colors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(getPixe(4, context)),
              child: Image.network(
                data['imageUrl'],
                width: getPixe(100, context),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          SizedBox(
            width: getPixe(20, context),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                data['title'],
                maxLines: 2,
                style: TextStyle(
                    fontSize: getPixe(22, context),
                    fontWeight: FontWeight.w500),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data['author'],
                    style: TextStyle(
                      fontSize: getPixe(14, context),
                      color: Colors.black45
                    )
                  ),
                  SizedBox(height: getPixe(5, context),),
                  Text(
                    '${data['category'][0]} · ${data['update_status']} · ${(data['total_num'] / 10000).floor()}万字',
                    style: TextStyle(
                      fontSize: getPixe(13, context),
                      color: Colors.black45
                    )
                  ),
                  SizedBox(height: getPixe(5, context),),
                  Text(
                    '${(data['total_num'] / 10000).round()} 万人气',
                    style: TextStyle(
                      fontSize: getPixe(16, context),
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
    double width = getWidth(context);
    double height = getMediaQuery(context).padding.top + 200;
    return Container(
      width: width,
      height: getPixe(height, context),
      decoration: BoxDecoration(
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