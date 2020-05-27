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
import 'package:fiction/providers/bookDetailProvider.dart';
import 'package:fiction/public/public.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class BookDetailPage extends StatelessWidget {
  final arguments;
  BookDetailPage({this.arguments});

  @override
  Widget build(BuildContext context) {
    dynamic _data = arguments['data'];
    return ChangeNotifierProvider(
        create: (context) => BookDetailProvider(),
        child: Scaffold(
          body: PageBody(
            data: _data,
          ),
        ));
  }
}

class PageBody extends StatelessWidget with PixelSize {
  final data;
  PageBody({this.data});

  double paddingTop;
  double screenWidth;

  /// AppBar
  Widget _buildAppBar(context, provider) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(provider.alpha),
          ),
          padding: EdgeInsets.only(
              left: getPixe(5, context), top: getPixe(paddingTop, context)),
          height: kToolbarHeight + paddingTop,
          child: Row(
            children: <Widget>[
              IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Iconfont.zuo,
                    color: Colors.black,
                    size: getPixe(26, context),
                  )),
              Expanded(
                child: Opacity(
                  opacity: provider.alpha,
                  child: Text(
                    data['title'],
                    style: TextStyle(
                        fontSize: getPixe(20, context),
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(width: getPixe(44, context)),
            ],
          ),
        ),
      ],
    );
  }

  /// 内容简介
  Widget _buildNovelDesc(context) {
    return Container(
      width: screenWidth,
      margin: EdgeInsets.symmetric(vertical: getPixe(10, context)),
      padding: EdgeInsets.all(getPixe(15, context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '内容简介',
            style: TextStyle(
                fontSize: getPixe(19, context), fontWeight: FontWeight.w500),
          ),
          Container(
              padding: EdgeInsets.symmetric(vertical: getPixe(20, context)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: getPixe(10, context)),
                    padding: EdgeInsets.symmetric(
                        horizontal: getPixe(9, context),
                        vertical: getPixe(4, context)),
                    decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius:
                            BorderRadius.circular(getPixe(4, context))),
                    child: Text(
                      '${data['desc_word'][0]}',
                      style: TextStyle(
                          fontSize: getPixe(12, context), color: Config.color),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: getPixe(10, context)),
                    padding: EdgeInsets.symmetric(
                        horizontal: getPixe(10, context),
                        vertical: getPixe(4, context)),
                    decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius:
                            BorderRadius.circular(getPixe(4, context))),
                    child: Text(
                      '${data['desc_word'][1]}',
                      style: TextStyle(
                          fontSize: getPixe(12, context), color: Config.color),
                    ),
                  ),
                ],
              )),
          Text(
            data['sutitle'],
            style: TextStyle(
              color: Colors.black54,
              fontSize: getPixe(16, context),
            ),
            maxLines: 4,
            overflow: TextOverflow.clip,
          ),
          Container(
              margin: EdgeInsets.only(top: getPixe(25, context)),
              padding: EdgeInsets.symmetric(),
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled:true,  // 设置为true即可设置高度
                      builder: (BuildContext context) {
                        return Container(
                          height: getHeight(context) * 0.75,
                          child: _buildBottomSheet(context),
                        );
                      });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(children: [
                      Text(
                        '目录',
                        style: TextStyle(
                            fontSize: getPixe(16, context),
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: getPixe(10, context),
                      ),
                      Text(
                        '连载至${data['chapter']}章',
                        style: TextStyle(
                            color: Colors.black38,
                            fontSize: getPixe(12, context)),
                      )
                    ]),
                    Row(
                      children: <Widget>[
                        Text(
                          '更新于今天',
                          style: TextStyle(
                              color: Colors.black45,
                              fontSize: getPixe(14, context)),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: Colors.black26,
                          size: getPixe(22, context),
                        )
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
 
  /// 目录详情
  Widget _buildBottomSheet(context) {
    return Column(
      children: <Widget>[
        Container(
          width: getWidth(context),
          child: Row(
            children: <Widget>[
              Spacer(
                flex: 1,
              ),
              Expanded(
                flex: 6,
                child: Text(
                  '目录',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: getPixe(18, context),
                      fontWeight: FontWeight.w500),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.close),
                color: Colors.grey,
              )
            ],
          ),
        ),
        Container(
          width: getWidth(context),
          padding: EdgeInsets.symmetric(horizontal: getPixe(15, context)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '共${data['chapter']}章',
                style: TextStyle(
                    fontSize: getPixe(12, context), color: Config.color),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.swap_vert),
                color: Config.color,
                iconSize: getPixe(20, context),
              )
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 20,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                  onTap: () {
                    print('=========第${index + 1}章=========');
                  },
                  child: Ink(
                    height: getPixe(50, context),
                    padding: EdgeInsets.symmetric(
                        vertical: getPixe(10, context),
                        horizontal: getPixe(20, context)),
                    child:
                        Text('第${index + 1}章  ${data['read_chapter_title']}'),
                  ));
            },
          ),
        )
      ],
    );
  }

  /// 底部工具栏
  Widget _buildToolBar(context, provider) {
    double buttonPadding = screenWidth / 6;
    return Material(
        elevation: 3,
        color: Colors.transparent,
        child: Container(
          width: screenWidth,
          color: Colors.white,
          padding: EdgeInsets.all(getPixe(5, context)),
          height: getMediaQuery(context).padding.bottom + 50,
          child: Row(
            children: <Widget>[
              GestureDetector(
                  onTap: provider.handleBookShelf,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(getPixe(8, context))),
                    padding: EdgeInsets.symmetric(
                        horizontal: getPixe(buttonPadding, context),
                        vertical: getPixe(10, context)),
                    child: provider.isBookShelf
                        ? Text('已在书架', style: TextStyle(color: Colors.grey))
                        : Text('加入书架', style: TextStyle(color: Config.color)),
                  )),
              Spacer(),
              InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: getPixe(buttonPadding, context),
                        vertical: getPixe(10, context)),
                    decoration: BoxDecoration(
                        color: Config.color,
                        borderRadius:
                            BorderRadius.circular(getPixe(8, context))),
                    child: Text(
                      '免费阅读',
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    BookDetailProvider provider = Provider.of<BookDetailProvider>(context);
    paddingTop = getMediaQuery(context).padding.top;
    screenWidth = getWidth(context);
    return AnnotatedRegion(
      value: provider.alpha > 0.5
          ? SystemUiOverlayStyle.dark
          : SystemUiOverlayStyle.light,
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child: CustomScrollView(
                  controller: provider.scrollController,
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: Column(children: <Widget>[
                        BookDetailHeader(
                          data: data,
                        ), // 头部
                        _buildNovelDesc(context), // 内容介绍
                        BookDetailRecommend(provider: provider), // 推荐
                      ]),
                    )
                  ],
                ),
              ),
              _buildToolBar(context, provider)
            ],
          ),
          _buildAppBar(context, provider)
        ],
      ),
    );
  }
}
