/*
 * @author      Yuri Chen <pluto401zz@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 * 
 * @see         书籍界面
*/


import 'package:fiction/app/bookDetail/book_detail_header.dart';
import 'package:fiction/app/bookDetail/book_detail_recommend.dart';
import 'package:fiction/public/public.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

class BookDetailPage extends StatefulWidget {
  final arguments;
  BookDetailPage({this.arguments});

  @override
  _BookDetailPageState createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> with PixelSize {
  dynamic _data;
  ScrollController _scrollController = ScrollController();
  double alpha = 0;

  @override
  void initState() {
    super.initState();
    _data = widget.arguments['data'];

    _scrollController.addListener(() {
      var offset = _scrollController.offset;
      if (offset < 0) {
        if (alpha != 0) {
          setState(() {
            alpha = 0;
          });
        }
      } else if (offset < 50) {
        setState(() {
          alpha = 1 - (50 - offset) / 50;
        });
      } else if (alpha != 1) {
        setState(() {
          alpha = 1;
        });
      }

    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  /// AppBar
  Widget _buildAppBar() {
    double paddingTop = getMediaQuery(context).padding.top;
    return Stack(
      children: <Widget>[
        Container(
          width: getPixe(44, context),
          height: kToolbarHeight + paddingTop,
          padding: EdgeInsets.only(left: getPixe(5, context), top: getPixe(paddingTop, context)),
          child: InkWell(
            onTap: ()=>Navigator.pop(context),
            child: Icon(Iconfont.zuo, color: Colors.black,),
          ),
        ),
        Opacity(
          opacity: alpha,
          child: Container(
            decoration: BoxDecoration(color: Colors.white,),
            padding: EdgeInsets.only(left: getPixe(5, context), top: getPixe(paddingTop, context)),
            height: kToolbarHeight + paddingTop,
            child: Row(
              children: <Widget>[
                Container(
                  width: getPixe(44, context),
                  child: InkWell(onTap: ()=>Navigator.pop(context), child: Icon(Iconfont.zuo, color: Colors.black,)),
                ),
                Expanded(
                  child: Text(
                    _data['title'],
                    style: TextStyle(fontSize: getPixe(20, context), fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(width: getPixe(44, context)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// 内容简介
  Widget _buildNovelDesc() {
    return Container(
      width: getWidth(context),
      margin: EdgeInsets.symmetric(vertical: getPixe(10, context)),
      padding: EdgeInsets.all(getPixe(15, context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('内容简介', style: TextStyle(fontSize: getPixe(19, context), fontWeight: FontWeight.w500),),
          Container(
            padding: EdgeInsets.symmetric(vertical: getPixe(20, context)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: getPixe(10, context)),
                  padding: EdgeInsets.symmetric(horizontal: getPixe(9, context), vertical: getPixe(4, context)),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(getPixe(4, context))
                  ),
                  child: Text('${_data['desc_word'][0]}', style: TextStyle(fontSize: getPixe(12, context) ,color: Config.color),),
                ),
                Container(
                  margin: EdgeInsets.only(right: getPixe(10, context)),
                  padding: EdgeInsets.symmetric(horizontal: getPixe(10, context), vertical: getPixe(4, context)),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(getPixe(4, context))
                  ),
                  child: Text('${_data['desc_word'][1]}', style: TextStyle(fontSize: getPixe(12, context) ,color: Config.color),),
                ),
              ],
            )
          ),
          Text(
            _data['sutitle'],
            style: TextStyle(
              color: Colors.black54,
              fontSize: getPixe(17, context),
            ),
            maxLines: 4,
            overflow: TextOverflow.clip,
          ),
          Container(
            margin: EdgeInsets.only(top: getPixe(25, context)),
            padding: EdgeInsets.symmetric(),
            child: InkWell(
              onTap: (){},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: [
                      Text('目录', style: TextStyle(fontSize: getPixe(16, context), fontWeight: FontWeight.w500),),
                      SizedBox(width: getPixe(10, context),),
                      Text('连载至${_data['chapter']}章', style: TextStyle(color: Colors.black38, fontSize: getPixe(12, context)),)
                    ]
                  ),
                  Row(
                    children: <Widget>[
                      Text('更新于今天', style: TextStyle(color: Colors.black45, fontSize: getPixe(14, context)),),
                      Icon(Icons.chevron_right, color: Colors.black26,size: getPixe(22, context),)
                    ],
                  )
                ],
              ),
            )
          )
        ],
      ),
    );
  }


  /// 底部工具栏
  Widget _buildToolBar() {
    double buttonPadding = getWidth(context) / 6;
    return Container(
      width: getWidth(context),
      padding: EdgeInsets.all(getPixe(5, context)),
      height: getMediaQuery(context).padding.bottom + 50,
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(getPixe(8, context))
              ),
              padding: EdgeInsets.symmetric(horizontal: getPixe(buttonPadding, context), vertical: getPixe(10, context)),
              child: Text('加入书架',style: TextStyle(color: Config.color)),
            )
          ),
          Spacer(),
          InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: getPixe(buttonPadding, context), vertical: getPixe(10, context)),
              decoration: BoxDecoration(
                color: Config.color,
                borderRadius: BorderRadius.circular(getPixe(8, context))
              ),
              child: Text('免费阅读', style: TextStyle(color: Colors.white),),
            )
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion(
        value: alpha > 0.5 ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    controller: _scrollController,
                    children: <Widget>[
                      BookDetailHeader(data: _data,),  // 头部
                      _buildNovelDesc(),  // 内容介绍
                      BookDetailRecommend(), // 推荐
                    ],
                  ),
                ),
                _buildToolBar()
              ],
            ),
            _buildAppBar()
          ],
        ),
      ),
    );
  }
}
