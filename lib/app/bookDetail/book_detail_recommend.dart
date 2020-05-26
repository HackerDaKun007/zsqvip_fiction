/*
 * @author      Yuri Chen <pluto401zz@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 * 
 * @see         书籍界面-推荐
*/

import 'package:flutter/material.dart';

import 'package:fiction/public/public.dart';
import 'package:fiction/res/guessYouLikeData.dart';


class BookDetailRecommend extends StatefulWidget {
  @override
  _BookDetailRecommendState createState() => _BookDetailRecommendState();
}

class _BookDetailRecommendState extends State<BookDetailRecommend> with PixelSize {
  List<Map> _listData = guessYouLikeData;

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

  @override
  Widget build(BuildContext context) {
     return Container(
      margin: EdgeInsets.only(bottom: getPixe(20, context)),
      height: getPixe(500, context),
      color: Colors.grey,
      child: Column(
        children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  '编辑推荐',
                  style: TextStyle(
                      fontSize: getPixe(20, context), fontWeight: FontWeight.w500),
                ),
                Container(
                    padding: EdgeInsets.only(right: getPixe(10, context)),
                    child: InkWell(
                      onTap: () {
                        _shuffleContent();
                      },
                      child: Row(
                        children: <Widget>[
                          Text(
                            '换一换',
                            style: TextStyle(
                                color: Colors.black45, fontSize: getPixe(14, context)),
                          ),
                          SizedBox(
                            width: getPixe(5, context),
                          ),
                          Icon(
                            Icons.loop,
                            size: getPixe(16, context),
                            color: Colors.grey[400],
                          )
                        ],
                      ),
                    ))
              ],
            ),
        ],
      ),
    );
  }
}

