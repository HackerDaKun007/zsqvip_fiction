/*
 * @author      Yuri Chen <pluto401zz@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 * 
 * @see         书城页面-猜你喜欢
*/
import 'package:fiction/public/public.dart';
import 'package:fiction/res/guessYouLikeData.dart';
import 'package:flutter/material.dart';

import 'package:fiction/app/pages/home/home_build_book.dart';



class GuessYouLike extends StatefulWidget {
  @override
  _GuessYouLikeState createState() => _GuessYouLikeState();
}

class _GuessYouLikeState extends State<GuessYouLike> {
  List<Map> _listData = guessYouLikeData;
  final double rpx = Config.width / 750;

  @override
  void initState() {
    super.initState();
    _listData.shuffle();
  }

  /// 换一换
  _shuffleContent() {
    setState(() {
      _listData.shuffle();
    });
  }

  _getBookListItem(data) {
    List<Widget> _list = List();

    for(var i=0; i<3; i++) {
      _list.add(BookContentWidget(data:data[i]));
    }
    return _list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 750 * rpx,
      height: 770 * rpx,
      margin: EdgeInsets.symmetric(horizontal: 20 * rpx, vertical: 30*rpx),
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
                        _shuffleContent();
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
                  children: _getBookListItem(_listData),
                ))
          ]),
    );
  }
}