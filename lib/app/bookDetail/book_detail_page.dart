/*
 * @author      Yuri Chen <pluto401zz@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 * 
 * @see         书籍界面
*/

import 'package:fiction/app/bookDetail/book_detail_catalogue.dart';
import 'package:fiction/app/bookDetail/book_detail_header.dart';
import 'package:fiction/app/bookDetail/book_detail_recommend.dart';
import 'package:fiction/public/public.dart';
import 'package:flutter/material.dart';

class BookDetailPage extends StatefulWidget {
  final arguments;
  BookDetailPage({this.arguments, Key key}):super(key: key);

  @override
  _BookDetailPageState createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  final PixelSize pixel = PixelSize();

  Map data;
  double paddingTop;
  double screenWidth;
  ScrollController scrollController; // 滚动控制
  double alpha; // 透明度
  bool isBookShelf; // 是否已在书架

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  void initState() {
    super.initState();
    data = widget.arguments['data'];
    scrollController = ScrollController();
    alpha = 0;
    isBookShelf = false;

    scrollController.addListener(() {
      var offset = scrollController.offset;
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

  /// 书架管理
  handleBookShelf() {
    if (isBookShelf) return;
    setState(() {
      isBookShelf = !isBookShelf;
    });
  }

  /// AppBar
  Widget _buildAppBar() {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(alpha),
          ),
          padding: EdgeInsets.only(
              left: pixel.setFontSize(5, context), top: pixel.setFontSize(paddingTop, context)),
          height: kToolbarHeight + paddingTop,
          child: Row(
            children: <Widget>[
              IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Iconfont.zuo,
                    color: Colors.black,
                    size: pixel.setFontSize(26, context),
                  )),
              Expanded(
                child: Opacity(
                  opacity: alpha,
                  child: Text(
                    data['title'],
                    style: TextStyle(
                        fontSize: pixel.setFontSize(20, context),
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(width: pixel.setFontSize(44, context)),
            ],
          ),
        ),
      ],
    );
  }

  /// 内容
  Widget _buildNovelContent() {
    return Container(
      width: pixel.screenWidthDp(context),
      margin: EdgeInsets.symmetric(vertical: pixel.setFontSize(10, context)),
      padding: EdgeInsets.all(pixel.setFontSize(15, context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '内容简介',
            style: TextStyle(
                fontSize: pixel.setFontSize(19, context), fontWeight: FontWeight.w500),
          ),
          Container(
              padding: EdgeInsets.symmetric(vertical: pixel.setFontSize(20, context)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: pixel.setFontSize(10, context)),
                    padding: EdgeInsets.symmetric(
                        horizontal: pixel.setFontSize(9, context),
                        vertical: pixel.setFontSize(4, context)),
                    decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius:
                            BorderRadius.circular(pixel.setFontSize(4, context))),
                    child: Text(
                      '${data['desc_word'][0]}',
                      style: TextStyle(
                          fontSize: pixel.setFontSize(12, context), color: Config.color),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: pixel.setFontSize(10, context)),
                    padding: EdgeInsets.symmetric(
                        horizontal: pixel.setFontSize(10, context),
                        vertical: pixel.setFontSize(4, context)),
                    decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius:
                            BorderRadius.circular(pixel.setFontSize(4, context))),
                    child: Text(
                      '${data['desc_word'][1]}',
                      style: TextStyle(
                          fontSize: pixel.setFontSize(12, context), color: Config.color),
                    ),
                  ),
                ],
              )),
          Text(
            data['sutitle'],
            style: TextStyle(
              color: Colors.black54,
              fontSize: pixel.setFontSize(16, context),
            ),
            maxLines: 4,
            overflow: TextOverflow.clip,
          ),
          Container(
              margin: EdgeInsets.only(top: pixel.setFontSize(25, context)),
              padding: EdgeInsets.symmetric(),
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true, // 设置为true即可设置高度
                      builder: (BuildContext context) {
                        return Container(
                          height: pixel.screenHeightDp(context) * 0.75,
                          child: BookDetailCatalogue(
                            data: data,
                          ),
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
                            fontSize: pixel.setFontSize(16, context),
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: pixel.setFontSize(10, context),
                      ),
                      Text(
                        '连载至${data['chapter']}章',
                        style: TextStyle(
                            color: Colors.black38,
                            fontSize: pixel.setFontSize(12, context)),
                      )
                    ]),
                    Row(
                      children: <Widget>[
                        Text(
                          '更新于今天',
                          style: TextStyle(
                              color: Colors.black45,
                              fontSize: pixel.setFontSize(14, context)),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: Colors.black26,
                          size: pixel.setFontSize(22, context),
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

  /// 底部工具栏
  Widget _buildToolBar() {
    double buttonPadding = screenWidth / 6;
    return Material(
        elevation: 3,
        color: Colors.transparent,
        child: Container(
          width: screenWidth,
          color: Colors.white,
          padding: EdgeInsets.all(pixel.setFontSize(5, context)),
          height: pixel.bottomBarHeight(context) + 50,
          child: Row(
            children: <Widget>[
              GestureDetector(
                  onTap: handleBookShelf,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(pixel.setFontSize(8, context))),
                    padding: EdgeInsets.symmetric(
                        horizontal: pixel.setFontSize(buttonPadding, context),
                        vertical: pixel.setFontSize(10, context)),
                    child: isBookShelf
                        ? const Text('已在书架', style: TextStyle(color: Colors.grey))
                        : const Text('加入书架', style: TextStyle(color: Colors.lightBlue)),
                  )),
              Spacer(),
              InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: pixel.setFontSize(buttonPadding, context),
                        vertical: pixel.setFontSize(10, context)),
                    decoration: BoxDecoration(
                        color: Config.color,
                        borderRadius:
                            BorderRadius.circular(pixel.setFontSize(8, context))),
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
    paddingTop = pixel.statusBarHeight(context);
    screenWidth = pixel.screenWidthDp(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child: CustomScrollView(
                  controller: scrollController,
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: Column(children: <Widget>[
                        BookDetailHeader(
                          data: data,
                        ), // 头部
                        _buildNovelContent(), // 内容介绍
                        BookDetailRecommend(), // 推荐
                      ]),
                    )
                  ],
                ),
              ),
              _buildToolBar()
            ],
          ),
          _buildAppBar()
        ],
      ),
    );
  }
}

