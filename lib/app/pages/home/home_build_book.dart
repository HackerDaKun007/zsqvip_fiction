/*
 * @author      Yuri Chen <pluto401zz@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 * 
 * @see         书城页面-书本信息展示
*/

import 'package:flutter/material.dart';

class BookContentWidget extends StatelessWidget {
  final Map data; // 数据
  final bool isElevation; // 是否要有阴影
  final bool isInfinity; // 是否是无限列表

  BookContentWidget(
      {@required this.data,
      this.isElevation = false,
      this.isInfinity = false});

  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/bookdetail', arguments: {
          'data': data,
        });
      },
      child: Container(
          width: 750 * rpx,
          height: 190 * rpx,
          margin: EdgeInsets.only(bottom: isInfinity ? 50 * rpx : 0 * rpx),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Material(
                elevation: isElevation ? 2 : 0,
                color: Colors.transparent,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6 * rpx),
                  child: Image.network(
                    data['imageUrl'],
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                width: 10 * rpx,
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15 * rpx),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            data['title'],
                            style: TextStyle(
                                fontSize: 30 * rpx, color: Colors.black),
                          ),
                          Text(
                            data['sutitle'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black38, fontSize: 26 * rpx),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  _getCategoryWidget(
                                      name: data['category'][0], rpx: rpx),
                                  SizedBox(
                                    width: 10 * rpx,
                                  ),
                                  _getCategoryWidget(
                                      name: data['category'][1], rpx: rpx),
                                ],
                              ),
                              Text(
                                '${data['update_status']} · 100万人气',
                                style: TextStyle(
                                    color: Colors.grey[400], fontSize: 20 * rpx),
                              )
                            ],
                          )
                        ],
                      )))
            ],
          ))
    );
  }

  // 分类
  Widget _getCategoryWidget({String name, double rpx}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10 * rpx, vertical: 1*rpx),
      decoration: BoxDecoration(
          border: Border.all(width: 1 * rpx, color: Colors.lightBlue[200]),
          borderRadius: BorderRadius.circular(2)),
      child: Text(
        name,
        style: TextStyle(color: Colors.lightBlue, fontSize: 20 * rpx),
      ),
    );
  }
}
