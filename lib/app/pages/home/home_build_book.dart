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
  final String imageUrl; // 图片
  final String bookName; // 书名
  final String bookDesc; // 介绍
  final int bookActivityCount; // 人气人数
  final List<String> bookCategory; // 分类
  final bool isElevation; // 是否要有阴影
  final bool isInfinity; // 是否是无限列表
  final int bookStatus; // 状态：1为连载，2为完结

  BookContentWidget(
      {this.imageUrl,
      this.bookName,
      this.bookDesc,
      this.bookCategory,
      this.bookActivityCount,
      this.bookStatus = 1,
      this.isElevation = false,
      this.isInfinity = false});

  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    return Container(
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
                  imageUrl,
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
                          bookName,
                          style: TextStyle(
                              fontSize: 30 * rpx, color: Colors.black),
                        ),
                        Text(
                          bookDesc,
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
                                    name: bookCategory[0], rpx: rpx),
                                SizedBox(
                                  width: 10 * rpx,
                                ),
                                _getCategoryWidget(
                                    name: bookCategory[1], rpx: rpx),
                              ],
                            ),
                            Text(
                              '${bookStatus < 2 ? '连载' : '完结'} · ${bookActivityCount}万人气',
                              style: TextStyle(
                                  color: Colors.grey[400], fontSize: 20 * rpx),
                            )
                          ],
                        )
                      ],
                    )))
          ],
        ));
  }

  // 分类
  Widget _getCategoryWidget({String name, double rpx}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10 * rpx),
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
