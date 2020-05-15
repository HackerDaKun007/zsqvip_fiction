import 'package:fiction/config/Config.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

const APPBAR_ALPHA = 100; //滚动最大值
//阅读分钟
int minute = 0;

class BookshelfPage extends StatefulWidget {
  BookshelfPage({Key key}) : super(key: key);

  @override
  _BookshelfPageState createState() => _BookshelfPageState();
}

class _BookshelfPageState extends State<BookshelfPage> {
  @override
  List<Widget> _arr() {
    List<Widget> list = new List();
    for (var i = 0; i < 100; i++) {
      list.add(Text('sdf',
          style: TextStyle(
            fontSize: 20.0,
          )));
    }
    return list;
  }

//修改顶部透明值
  double appBarAlpha = 0;
  //获取滚动事件方法
  _onScroll(Offset) {
    double appha = Offset / APPBAR_ALPHA;
    if (appha < 0) {
      appha = 0;
    } else if (appha > 1) {
      appha = 1;
    }
    setState(() {
      appBarAlpha = appha;
    });
    // print(Config.domain);
  }

  void initState() {
    super.initState();
    setState(() {
      minute = 10;
    });
  }

  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: NotificationListener(
            onNotification: (ScrollNotification) {
              if (ScrollNotification is ScrollUpdateNotification &&
                  ScrollNotification.depth == 0) {
                //滚动且是列表滚动的时候
                _onScroll(ScrollNotification.metrics.pixels);
              }
            },
            child: ListView(
              children: <Widget>[
                this._topBack(),
                //内容
                this._content(),
              ],
            ),
          ),
        ),
        this._topLeftColumn(),
        this._topRightColumn(),
      ],
    );
  }

  //头部背景显示阅读
  Widget _topBack() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('https://www.itying.com/images/flutter/2.png'),
          fit: BoxFit.cover,
        ),
      ),
      height: 220.0,
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
                  child: Text(
                    '${minute}',
                    style: TextStyle(fontSize: 50.0),
                  ),
                ),
                Text(
                  '今日已读/分钟',
                  style: TextStyle(fontSize: 12.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //顶部左边导航
  Widget _topLeftColumn() {
    return Align(
      alignment: Alignment.topCenter,
      child: Opacity(
        opacity: this.appBarAlpha,
        child: Container(
          height: 70.0,
          width: double.infinity,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 40, 0, 0),
            child: Row(
              children: <Widget>[
                Text('今天阅读'),
                Padding(
                  padding: EdgeInsets.fromLTRB(3, 0, 3, 6),
                  child: Text("${minute}",
                      style: TextStyle(fontSize: 20.0, color: Colors.black)),
                ),
                Text('分钟'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //顶部右边导航
  Widget _topRightColumn() {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        height: 70.0,
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 35, 10, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.account_balance,
                  size: 20.0,
                  color: Color(0xFF000000),
                ),
                onPressed: () {
                  print(1);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.search,
                  size: 20.0,
                  color: Color(0xFF000000),
                ),
                onPressed: () {
                  print(1);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.more_vert,
                  size: 20.0,
                  color: Color(0xFF000000),
                ),
                onPressed: () {
                  showMenu(
                      context: context,
                      position: RelativeRect.fromLTRB(500, 76, 10, 0),
                      items: [
                        PopupMenuItem(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.history,
                                color: Colors.blue,
                                size: 24.0,
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: Text("阅读记录"),
                              )
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.border_color,
                                color: Colors.blue,
                                size: 20.0,
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: Text("书架编辑"),
                              )
                            ],
                          ),
                        )
                      ]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  //内容模块
  Widget _content() {
    return Container(
      height: 800,
      child: ListTile(
        title: Text('测试'),
        onTap: () {
          setState(() {
            minute += 1;
          });
        },
      ),
    );
  }
}
