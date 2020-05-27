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
  BookDetailRecommend({Key key}):super(key: key);

  @override
  _BookDetailRecommendState createState() => _BookDetailRecommendState();
}

class _BookDetailRecommendState extends State<BookDetailRecommend> with PixelSize {
  List<Map> recommendData = guessYouLikeData;

  @override
  void initState() {
    super.initState();
    recommendData.shuffle();
  }

  /// 随机数据
  shuffleRecommendData() {
    setState(() {
      recommendData.shuffle();
    });
  }


  Widget _buildContentItem(data, context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/bookdetail', arguments: {'data': data});
      },
      child: Container(
        width: (getWidth(context) - 80) / 3,
        height: getPixe(190, context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Material(
              elevation: 3,
              color: Colors.transparent,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(getPixe(4, context)),
                child: Image.network(data['imageUrl'], fit: BoxFit.fitWidth),
              )
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(data['title'], style: TextStyle(fontSize: getPixe(14, context)),),
                Text('${(data['total_num'] / 10000).floor()} 万人气', style: TextStyle(fontSize: getPixe(12, context), color: Colors.grey),)
              ],
            )
          ],
        ),
      )
    );
  }

  _getContentList(context) {
    List<Widget> _list = List<Widget>();
    for(var i=0; i<6; i++) {
      _list.add(_buildContentItem(recommendData[i], context));
    }
    return _list;
  }

  Widget _buildRecommendContent(context) {
    return Container(
      margin: EdgeInsets.only(top: getPixe(20, context)),
      padding: EdgeInsets.symmetric(vertical: getPixe(10, context)),
      child: Wrap(
        direction: Axis.horizontal,
        spacing: getPixe(20, context),
        runSpacing: getPixe(20, context),
        children: _getContentList(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: getPixe(20, context)),
      padding: EdgeInsets.all(getPixe(15, context)),
      height: getPixe(500, context),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                '编辑推荐',
                style: TextStyle(
                    fontSize: getPixe(20, context),
                    fontWeight: FontWeight.w500),
              ),
              Container(
                  padding: EdgeInsets.only(right: getPixe(10, context)),
                  child: InkWell(
                    onTap: () {
                      shuffleRecommendData();
                    },
                    child: Row(
                      children: <Widget>[
                        Text(
                          '换一换',
                          style: TextStyle(
                              color: Colors.black45,
                              fontSize: getPixe(14, context)),
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
          Expanded(child: _buildRecommendContent(context))
        ],
      ),
    );
  }
}
