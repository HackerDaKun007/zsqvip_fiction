/*
 * @author      Yuri Chen <pluto401zz@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 * 
 * @see         书单页面
*/

import 'package:flutter/material.dart';

import 'package:fiction/public/public.dart';
import 'package:fiction/res/booklistData.dart';

class BookListPage extends StatefulWidget {
  BookListPage({Key key}) : super(key: key);
  @override
  _BookListPageState createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  double rpx;
  int listIndex;
  final PixelSize pixel = PixelSize();


  Widget _getBookListWidget(int index) {
    return InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/booklistdetail',
              arguments: {'index': index});
        },
        child: Container(
          height: 300 * rpx,
          padding: EdgeInsets.all(25 * rpx),
          margin: EdgeInsets.only(bottom: 20 * rpx),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                bookListData[index]['title'],
                style: TextStyle(fontSize: 32 * rpx),
              ),
              SizedBox(
                height: 20 * rpx,
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20 * rpx),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: NetworkImage(
                        bookListData[index]['image'],
                      ),
                      fit: BoxFit.fitWidth,
                    )),
                  ))
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    rpx = pixel.screenWidthDp(context) / 750;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '精选书单',
          style: TextStyle(fontSize: 36 * rpx),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Iconfont.zuo),
          iconSize: pixel.setFontSize(26, context),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: bookListData.length,
        itemBuilder: (BuildContext context, int index) {
          return _getBookListWidget(index);
        },
      ),
    );
  }
}
