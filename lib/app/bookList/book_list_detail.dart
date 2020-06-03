/*
 * @author      Yuri Chen <pluto401zz@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 * 
 * @see         书单单个列表详情页面
*/

import 'package:fiction/public/public.dart';
import 'package:flutter/material.dart';

import 'package:fiction/res/booklistData.dart';

class BookListDetail extends StatefulWidget {
  final arguments;
  BookListDetail({Key key, this.arguments}) : super(key: key);
  @override
  _BookListDetailState createState() => _BookListDetailState();
}

class _BookListDetailState extends State<BookListDetail> {
  double rpx;
  dynamic _data;
  final PixelSize pixel = PixelSize();
  

  @override
  void initState() {
    super.initState();
    _data = bookListData[widget.arguments['index']];
  }

  Widget _listViewWidget() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return _buildItemWidget(index);
      }, childCount: _data['list'].length),
    );
  }

  Widget _buildItemWidget(int index) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 210 * rpx,
        padding: EdgeInsets.symmetric(horizontal: 20 * rpx),
        margin: EdgeInsets.only(bottom: 30 * rpx),
        child: Row(
          children: <Widget>[
            Material(
              elevation: 5,
              color: Colors.transparent,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4 * rpx),
                child: Image.network(
                  _data['list'][index]['image'],
                  height: 190 * rpx,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              width: 20 * rpx,
            ),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    _data['list'][index]['bookname'],
                    style: TextStyle(fontSize: 30 * rpx),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(_data['list'][index]['author'],
                          style: TextStyle(
                              fontSize: 24 * rpx, color: Colors.grey[500])),
                      SizedBox(
                        width: 10 * rpx,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6 * rpx, vertical: 1 * rpx),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1 * rpx, color: Colors.blue[100]),
                            borderRadius: BorderRadius.circular(6 * rpx)),
                        child: Text(
                          _data['list'][index]['category'][0],
                          style: TextStyle(
                              fontSize: 18 * rpx, color: Colors.lightBlue),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    _data['list'][index]['desc'],
                    style: TextStyle(fontSize: 26 * rpx, color: Colors.grey),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    rpx = pixel.screenWidthDp(context) / 750;
    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
            pinned: true,
            floating: true,
            expandedHeight: 350 * rpx,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Iconfont.zuo),
              iconSize: pixel.setFontSize(26, context),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                _data['title'],
                style: TextStyle(),
              ),
              background: Image.network(
                _data['image'],
                fit: BoxFit.fitWidth,
              ),
            )),
        SliverPadding(
          padding: EdgeInsets.all(40 * rpx),
          sliver: _listViewWidget(),
        )
      ],
    ));
  }
}
