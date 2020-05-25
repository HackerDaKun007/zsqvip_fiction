import 'package:fiction/public/public.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

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
      margin: EdgeInsets.only(bottom: getPixe(10, context)),
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

  /// 推荐
  Widget _buildRecommend() {
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
                        // _shuffleContent();
                      },
                      child: Row(
                        children: <Widget>[
                          Text(
                            '换一批',
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
                      PageHeader(data: _data,),
                      _buildNovelDesc(),
                      _buildRecommend(),
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


class PageHeader extends StatelessWidget with PixelSize{
  
  final dynamic data;
  PageHeader({this.data});

  Widget _buildHeaderContent(context) {
    double paddingTop = getMediaQuery(context).padding.top;
    return Container(
      height: getPixe(220, context),
      width: getWidth(context),
      padding: EdgeInsets.fromLTRB(
          getPixe(15, context), getPixe(58 + paddingTop, context), getPixe(10, context), 0),
      child: Row(
        children: <Widget>[
          Material(
            elevation: 5,
            color: Colors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(getPixe(4, context)),
              child: Image.network(
                data['imageUrl'],
                width: getPixe(100, context),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          SizedBox(
            width: getPixe(20, context),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                data['title'],
                maxLines: 2,
                style: TextStyle(
                    fontSize: getPixe(22, context),
                    fontWeight: FontWeight.w500),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data['author'],
                    style: TextStyle(
                      fontSize: getPixe(14, context),
                      color: Colors.black45
                    )
                  ),
                  SizedBox(height: getPixe(5, context),),
                  Text(
                    '${data['category'][0]} · ${data['update_status']} · ${(data['total_num'] / 10000).floor()}万字',
                    style: TextStyle(
                      fontSize: getPixe(13, context),
                      color: Colors.black45
                    )
                  ),
                  SizedBox(height: getPixe(5, context),),
                  Text(
                    '${(data['total_num'] / 10000).round()} 万人气',
                    style: TextStyle(
                      fontSize: getPixe(16, context),
                    )
                  ),
                ],
              )
            ],
          )
        ],
      ));
  }


  @override
  Widget build(BuildContext context) {
    double width = getWidth(context);
    double height = getMediaQuery(context).padding.top + 200;
    return Container(
      width: width,
      height: getPixe(height, context),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(data['imageUrl']),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.linearToSrgbGamma(),
        )
      ),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: _buildHeaderContent(context)
      ),
    );
  }
}