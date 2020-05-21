/*
 * @author      Yuri Chen <pluto401zz@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 * 
 * @see         书城页面-编辑推荐板块
*/

import 'package:fiction/res/guessYouLikeData.dart';
import 'package:flutter/material.dart';

import 'package:fiction/public/public.dart';
import 'package:fiction/app/pages/home/home_build_book.dart';


class EditorsRecommend extends StatefulWidget {
  @override
  _EditorsRecommendState createState() => _EditorsRecommendState();
}

class _EditorsRecommendState extends State<EditorsRecommend> {

  final double rpx = Config.width / 750;
  Map _firstRecommendData; // 第一个推荐
  List<Map> _listData = guessYouLikeData;


    /// 其余推荐
  Widget _getLeftRecommendItem(Map data) {
    return Container(
      width: (750 / 5) * rpx,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(6 * rpx),
            child: Image.network(
              data['imageUrl'],
              height: 190 * rpx,
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  data['title'],
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontSize: 28 * rpx),
                ),
                Text(
                  '110万人气',
                  style: TextStyle(fontSize: 22 * rpx, color: Colors.black54),
                  textAlign: TextAlign.left,
                ),
              ],
            )
          )
        ],
      ),
    );
  }

  _getLeftItemList(listData) {
    List<Widget> _list = List();

    for(var i=1; i<5; i++) {
      _list.add(_getLeftRecommendItem(listData[i]));
    }
    return _list;
  }

  @override
  void initState() {
    super.initState();
    _listData.shuffle();  // 打乱数组
    _firstRecommendData = _listData[0];
  }

  /// 换一换
  _shuffleContent() {
    setState(() {
      _listData.shuffle();
      _firstRecommendData = _listData[0];
    });
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      width: 750 * rpx,
      height: 630 * rpx,
      margin: EdgeInsets.all(20 * rpx),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  '编辑力荐',
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
            height: 25 * rpx,
          ),
          BookContentWidget(
            data: _firstRecommendData,
            isElevation: true,
          ),
          SizedBox(
            height: 50 * rpx,
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: 750 * rpx,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _getLeftItemList(_listData),
              ),
            )
          )
        ],
      ),
    );
  }
}
