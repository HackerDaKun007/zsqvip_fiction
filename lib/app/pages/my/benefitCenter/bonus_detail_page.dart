/*
 * @author      Yuri Chen <pluto401zz@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         积分详细页面
*/

import 'package:fiction/public/public.dart';
import 'package:flutter/material.dart';

class BonusDetailPage extends StatefulWidget {
  @override
  _BonusDetailPageState createState() => _BonusDetailPageState();
}

class _BonusDetailPageState extends State<BonusDetailPage> {
  PixelSize pixel = PixelSize();

  Widget _buildListItem() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
          horizontal: pixel.setFontSize(10, context), vertical: pixel.setFontSize(15, context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text('每日签到奖励'),
              Text(
                '2020-05-29 18:09:32',
                style: TextStyle(
                    color: Colors.grey, fontSize: pixel.setFontSize(12, context)),
              )
            ],
          ),
          Row(
            children: [
              Text(
                '+20',
                style: TextStyle(
                    fontSize: pixel.setFontSize(17, context), color: Colors.deepOrange),
              ),
              Text(' 积分', style: TextStyle(fontSize: pixel.setFontSize(14, context), color: Colors.deepOrange),)
            ]
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '积分明细',
            style: TextStyle(fontSize: pixel.setFontSize(20, context)),
          ),
          centerTitle: true,
          elevation: 1,
          leading: IconButton(
            icon: const Icon(Iconfont.zuo),
            iconSize: pixel.setFontSize(26, context),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(pixel.setFontSize(10, context)),
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    _buildListItem(),
                    _buildListItem(),
                    _buildListItem(),
                    _buildListItem(),
                    _buildListItem(),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              color: Colors.grey[200],
                              width: pixel.setFontSize(0.5, context)))),
                  padding: EdgeInsets.symmetric(vertical: pixel.setFontSize(10, context)),
                  child: Center(
                    child: Text(
                      '仅展示最近60天的记录',
                      style: TextStyle(
                          color: Colors.grey, fontSize: pixel.setFontSize(12, context)),
                    ),
                  ),
                )
              ],
            )));
  }
}
