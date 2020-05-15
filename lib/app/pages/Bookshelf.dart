import 'package:fiction/res/listData.dart';
import 'package:fiction/widget/PixelSize.dart'; //像素插件
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:fiction/config/Config.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:fiction/fonts/Iconfont.dart';
//阅读分钟
int minute = 0;

class BookShelfPage extends StatefulWidget {
  BookShelfPage({Key key}) : super(key: key);

  @override
  _BookShelfPageState createState() => _BookShelfPageState();
}

class _BookShelfPageState extends State<BookShelfPage> with PixelSize {
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

  final int appbarAlpha = 100; //滚动最大值
  //修改顶部透明值
  double appBarAlpha = 0;
  //获取滚动事件方法
  _onScroll(Offset) {
    double appha = Offset / appbarAlpha;
    if (appha < 0) {
      appha = 0;
    } else if (appha > 1) {
      appha = 1;
    }
    setState(() {
      appBarAlpha = appha;
    });
    // print(Config.domain);
    // print(window.physicalSize.width);

    // print(fontSize(12));
    // fontSize(12);
  }

  void initState() {
    super.initState();
    setState(() {
      minute = 10;
    });

    //添加一项追加数据
    listData.add({
      "title": '',
      "author": '',
      "imageUrl":'images/jia.png',
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
                //推荐内容
                this._recommendedContent(),
                //列表内容
                this._content(),
              ],
            ),
          ),
        ),
        this._topLeftColumn(),
        this._topRightColumn(),
        this._bottomAd(),
      ],
    );
  }

  //头部背景显示阅读
  Widget _topBack() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          // image: NetworkImage('https://www.itying.com/images/flutter/2.png'),
          image: AssetImage('images/home.png'),
          fit: BoxFit.cover,
        ),
      ),
      height: fontSize(220),
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, fontSize(100), 0, 0),
                        child: Text(
                          '${minute}',
                          style: TextStyle(fontSize: fontSize(50)),
                        ),
                      ),
                      Text(
                        '今日已读 / 分钟',
                        style: TextStyle(fontSize: fontSize(12)),
                      ),
                    ],
                  ),
                ],
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: GestureDetector(
                  child: Container(
                      height: fontSize(30),
                      width: fontSize(70),
                      // color: Colors.white,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/li.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            fontSize(30), fontSize(8), 0, 0),
                        child: Text(
                          '签到',
                          style: TextStyle(
                            fontSize: fontSize(12),
                          ),
                        ),
                      )),
                  onTap: () {
                    setState(() {
                      minute += 1;
                    });
                  },
                ),
              ),
            ],
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
          height: fontSize(70),
          width: double.infinity,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.fromLTRB(fontSize(10), fontSize(40), 0, 0),
            child: Row(
              children: <Widget>[
                Text('今天阅读'),
                Padding(
                  padding: EdgeInsets.fromLTRB(3, 0, 3, 6),
                  child: Text("${minute}",
                      style: TextStyle(
                          fontSize: fontSize(20), color: Colors.black)),
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
        height: fontSize(70),
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, fontSize(35), 10, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              // IconButton(
              //   icon: Icon(
              //     Iconfont.vip,
              //     size: fontSize(20),
              //     color: Color(0xFF000000),
              //   ),
              //   onPressed: () {
              //     print(1);
              //   },
              // ),
              IconButton(
                icon: Icon(
                  Iconfont.sousuo,
                  size: fontSize(20),
                  color: Color(0xFF000000),
                ),
                onPressed: () {
                  print(1);
                },
              ),
              IconButton(
                icon: Icon(
                  Iconfont.youcecaidan,
                  size: fontSize(20),
                  color: Color(0xFF000000),
                ),
                onPressed: () {
                  showMenu(
                      context: context,
                      position: RelativeRect.fromLTRB(
                          fontSize(500), fontSize(70), fontSize(10), 0),
                      items: [
                        PopupMenuItem(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.history,
                                color: Colors.blue,
                                size: fontSize(21),
                              ),
                              Container(
                                padding:
                                    EdgeInsets.fromLTRB(fontSize(10), 0, 0, 0),
                                child: Text(
                                  "记录",
                                  style: TextStyle(fontSize: fontSize(14)),
                                ),
                              )
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Iconfont.bianji,
                                color: Colors.blue,
                                size: fontSize(21),
                              ),
                              Container(
                                padding:
                                    EdgeInsets.fromLTRB(fontSize(11), 0, 0, 0),
                                child: Text(
                                  "编辑",
                                  style: TextStyle(fontSize: fontSize(14)),
                                ),
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

  //推荐内容
  Widget _recommendedContent() {
    List<Map> list = [
      {"title": "我把你当兄弟你居然想上我？", "id": 1},
      {"title": "穿越异界，成为一代邪君！", "id": 2},
      {"title": "守护我方轩宇，千秋在线刚枪", "id": 3},
      {"title": "守护我方轩宇，千秋在线刚枪", "id": 4},
      {"title": "最强斗神重生复活，再战丧尸末世", "id": 5},
    ];
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            // color: Colors.yellow,
            width: fontSize(40),
            child: Center(
              child: Icon(
                Iconfont.remen,
                color: Colors.red,
                size: fontSize(18),
              ),
            ),
          ),
          // SizedBox(width: fontSize(10),),
          Expanded(
              flex: 1,
              child: Center(
                // mainAxisAlignment: MainAxisAlignment.center,
                child: Swiper(
                  itemCount: list.length,
                  autoplay: true, //自动播放
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                      child: GestureDetector(
                        child: Text(list[index]['title'], style: TextStyle(
                          fontSize: fontSize(13),color: Color(0x99333333),
                        ),),
                        onTap: () {
                          print(list[index]['title']);
                        },
                      ),
                    );
                  },
                ),
              )),
          SizedBox(
            width: fontSize(10),
          ),
          Container(
            width: fontSize(30),
            // color: Colors.yellow,
            child: Icon(Icons.keyboard_arrow_right, size: fontSize(20),color: Color(0x99333333)),
          ),
        ],
      ),
      // color: Colors.white,
      height: fontSize(37),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          // border: Border.all(width: 1, color: Colors.grey),
          boxShadow: [
            BoxShadow(
                color: Color(0x99e7e7e7),
                offset: Offset(1.3, 1.3),
                blurRadius: 5.0,
                spreadRadius: 1.0),
            BoxShadow(color: Color(0x99e7e7e7), offset: Offset(1.0, 1.0)),
            BoxShadow(color: Color(0x99e7e7e7))
          ]),
      margin: EdgeInsets.fromLTRB(fontSize(25), 0, fontSize(25), fontSize(10)),
    );
  }

  //内容模块
  Widget _content() {
    
    return Padding(
      padding: EdgeInsets.all(10),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, //控制一行多个
          crossAxisSpacing: 10.0, //左右距离
          mainAxisSpacing: 10.0, //上下距离
          childAspectRatio: 0.63, //子级的高度、宽度的比例
        ),
        itemCount: listData.length,
        itemBuilder: this._getListData,
      ),
    );
  }
  Widget _getListData(context, index) {
    int dataLength = (listData.length - 1);
    if(index == dataLength) {
       return Container(
        child: GestureDetector(
      child: Column(
        children: <Widget>[
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(5),
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.asset(
              listData[index]['imageUrl'],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: Text(
              listData[index]['title'],
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: fontSize(12)),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      onTap: () {
        // setState(() {
        //   Config.currenIndex = 1;
        // });
        Navigator.pushNamed(context, '/',arguments: {'index':1});
      },
    ),
 
    );
    } else {
      return Container(
        child: GestureDetector(
      child: Column(
        children: <Widget>[
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(5),
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.network(
              listData[index]['imageUrl'],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: Text(
              listData[index]['title'],
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: fontSize(12)),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      onTap: () {
        print(index);
        print(listData.length);
      },
    ),
 
    );
    }
    
  }

  //底部广告位置
  Widget _bottomAd() {
    return Positioned(
      bottom: fontSize(20),
      right: 20,
      child: Container(
        width: fontSize(60),
        height: fontSize(60),
        child: GestureDetector(
          child: Center(
            child: Text('广告位置'),
          ),
          onTap: () {
            print('底部广告');
          },
        ),
        color: Colors.blue,
        //   decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: NetworkImage('https://www.itying.com/images/flutter/2.png'),
        //     fit: BoxFit.cover,
        //   ),
        // ),
      ),
    );
  }
}
