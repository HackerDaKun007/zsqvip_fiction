/*
 * @author      Yuri Chen <pluto401zz@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 * 
 * @see         书城页面-猜你喜欢
*/
import 'package:flutter/material.dart';

import 'package:fiction/app/pages/home/home_build_book.dart';



class GuessYouLike extends StatefulWidget {
  @override
  _GuessYouLikeState createState() => _GuessYouLikeState();
}

class _GuessYouLikeState extends State<GuessYouLike> {
  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    return Container(
      width: 750 * rpx,
      height: 770 * rpx,
      margin: EdgeInsets.all(20 * rpx),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  '猜你喜欢',
                  style: TextStyle(
                      fontSize: 34 * rpx, fontWeight: FontWeight.bold),
                ),
                Container(
                    padding: EdgeInsets.only(right: 20 * rpx),
                    child: InkWell(
                      onTap: () {
                        print(
                            '=========== pressed to change list content ==========');
                      },
                      child: Row(
                        children: <Widget>[
                          Text(
                            '换一换',
                            style: TextStyle(
                                color: Colors.black54, fontSize: 26 * rpx),
                          ),
                          SizedBox(
                            width: 10 * rpx,
                          ),
                          Icon(
                            Icons.loop,
                            size: 32 * rpx,
                            color: Colors.grey[400],
                          )
                        ],
                      ),
                    ))
              ],
            ),
            SizedBox(
              height: 30 * rpx,
            ),
            Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    BookContentWidget(
                      bookName: '无无无',
                      imageUrl:
                          'https://tse1-mm.cn.bing.net/th/id/OIP.60drNS4gbPF8T1r5poePMAAAAA?pid=Api&rs=1',
                      bookActivityCount: 45,
                      bookCategory: ['仙侠', '传奇'],
                      bookDesc: '测试数据',
                    ),
                    BookContentWidget(
                      bookName: '无无无',
                      imageUrl:
                          'https://tse1-mm.cn.bing.net/th/id/OIP.60drNS4gbPF8T1r5poePMAAAAA?pid=Api&rs=1',
                      bookActivityCount: 10,
                      bookCategory: ['古风', '传奇'],
                      bookDesc: '测试数据',
                    ),
                    BookContentWidget(
                      bookName: '无无无',
                      imageUrl:
                          'https://tse1-mm.cn.bing.net/th/id/OIP.60drNS4gbPF8T1r5poePMAAAAA?pid=Api&rs=1',
                      bookActivityCount: 50,
                      bookCategory: ['现代', '传奇'],
                      bookDesc:
                          '测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据',
                    ),
                  ],
                ))
          ]),
    );
  }
}