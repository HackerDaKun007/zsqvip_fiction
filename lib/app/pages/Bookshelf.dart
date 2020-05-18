import 'package:flutter/material.dart';
import 'package:fiction/public/public.dart';
import 'dart:ui';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:fiction/res/listData.dart';

//阅读分钟
int minute = 0;
// int parindex = 0BuildContext context, ;

class BookShelfPage extends StatefulWidget {
  final getCurrenIndex;
  // int print;
  BookShelfPage({Key key, this.getCurrenIndex}) : super(key: key);

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
    // double screenWidth = MediaQuery.of(context).size.width;
    // print(screenWidth);
    // rpx = screenWidth / 750;
    // print(getPixe(50, context));
    // getPixe(12);
  }

  void initState() {
    super.initState();
    setState(() {
      minute = 10;
    });

    //添加一项追加数据
    if (listData[(listData.length - 1)]['system'] == null) {
      //防止数据追加
      //添加书架
      listData.add({
        "title": '',
        "author": '',
        "imageUrl": 'images/jia.png',
        "system": 1,
      });
    }
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
                this._readTime(),
                //推荐内容
                this._recommendedContent(),
                //列表内容
                this._content(),
              ],
            ),
          ),
        ),
        this._columnReadTime(),
        this._columnIocn(),
        this._footerAd(),
      ],
    );
  }

  //头部背景显示阅读
  Widget _readTime() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          // image: NetworkImage('https://www.itying.com/images/flutter/2.png'),
          image: AssetImage('images/home.png'),
          fit: BoxFit.cover,
        ),
      ),
      height: getPixe(220, context),
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
                        padding:
                            EdgeInsets.fromLTRB(0, getPixe(100, context), 0, 0),
                        child: Text(
                          '${minute}',
                          style: TextStyle(fontSize: getPixe(50, context)),
                        ),
                      ),
                      Text(
                        '今日已读 / 分钟',
                        style: TextStyle(fontSize: getPixe(12, context)),
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
                      height: getPixe(30, context),
                      width: getPixe(70, context),
                      // color: Colors.white,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/li.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            getPixe(30, context), getPixe(8, context), 0, 0),
                        child: Text(
                          '签到',
                          style: TextStyle(
                            fontSize: getPixe(12, context),
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
  Widget _columnReadTime() {
    return Align(
      alignment: Alignment.topCenter,
      child: Opacity(
        opacity: this.appBarAlpha,
        child: Container(
          height: getPixe(70, context),
          width: double.infinity,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                getPixe(10, context), getPixe(40, context), 0, 0),
            child: Row(
              children: <Widget>[
                Text('今天阅读'),
                Padding(
                  padding: EdgeInsets.fromLTRB(3, 0, 3, 6),
                  child: Text("${minute}",
                      style: TextStyle(
                          fontSize: getPixe(20, context), color: Colors.black)),
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
  Widget _columnIocn() {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        height: getPixe(70, context),
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, getPixe(35, context), 10, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              // IconButton(
              //   icon: Icon(
              //     Iconfont.vip,
              //     size: getPixe(20),
              //     color: Color(0xFF000000),
              //   ),
              //   onPressed: () {
              //     print(1);
              //   },
              // ),
              IconButton(
                icon: Icon(
                  Iconfont.sousuo,
                  size: getPixe(20, context),
                  color: Color(0xFF000000),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/search');
                },
              ),
              IconButton(
                icon: Icon(
                  Iconfont.youcecaidan,
                  size: getPixe(20, context),
                  color: Color(0xFF000000),
                ),
                onPressed: () {
                  showMenu(
                      context: context,
                      position: RelativeRect.fromLTRB(getPixe(500, context),
                          getPixe(70, context), getPixe(10, context), 0),
                      items: [
                        PopupMenuItem(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.history,
                                color: Colors.blue,
                                size: getPixe(21, context),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(
                                    getPixe(10, context), 0, 0, 0),
                                child: Text(
                                  "记录",
                                  style:
                                      TextStyle(fontSize: getPixe(14, context)),
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
                                size: getPixe(21, context),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(
                                    getPixe(11, context), 0, 0, 0),
                                child: Text(
                                  "编辑",
                                  style:
                                      TextStyle(fontSize: getPixe(14, context)),
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
            width: getPixe(40, context),
            child: Center(
              child: Icon(
                Iconfont.remen,
                color: Colors.red,
                size: getPixe(18, context),
              ),
            ),
          ),
          // SizedBox(width: getPixe(10),),
          Expanded(
              flex: 1,
              child: Center(
                // mainAxisAlignment: MainAxisAlignment.center,
                child: Swiper(
                  itemCount: list.length,
                  autoplay: true, //自动播放
                  // scrollDirection: Axis.vertical,
                  // autoplayDisableOnInteraction:false,
                  // onIndexChanged: (index) {
                  //   print(index);
                  // },
                  duration: 500,
                  autoplayDelay: 5000,
                  // autoplayDisableOnInteraction: true,
                  onTap: (index) {
                    print(list[index]['title']);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                      child: Text(list[index]['title'],
                          style: TextStyle(
                            fontSize: getPixe(13, context),
                            color: Color(0x99333333),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                    );
                  },
                ),
              )),
          SizedBox(
            width: getPixe(10, context),
          ),
          Container(
            width: getPixe(30, context),
            // color: Colors.yellow,
            child: Icon(Icons.keyboard_arrow_right,
                size: getPixe(20, context), color: Color(0x99333333)),
          ),
        ],
      ),
      // color: Colors.white,
      height: getPixe(37, context),
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
      margin: EdgeInsets.fromLTRB(
          getPixe(25, context), 0, getPixe(25, context), getPixe(10, context)),
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
    if (index == dataLength) {
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
                  style: TextStyle(
                      color: Colors.black, fontSize: getPixe(12, context)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          onTap: () {
            //修改父级组件
            widget.getCurrenIndex(1);
          },
        ),
      );
    } else {
      //验证是否更新，并且是否点击查看过
      _isUpdate() {
        if (listData[index]['click'] == 0 &&
            listData[index]['chapter'] > listData[index]['watched_chapter'] && listData[index]['ad'] == 0) {
          return Positioned(
            top: getPixe(10, context),
            left: 0,
            child: Container(
              width: getPixe(40, context),
              height: getPixe(20, context),
              color: Config.color,
              child: Center(
                child: Text(
                  '更新',
                  style: TextStyle(
                      fontSize: getPixe(12, context), color: Colors.white),
                ),
              ),
            ),
          );
        } else {
          return Text('');
        }
      }

      return Container(
        child: GestureDetector(
          child: Column(
            children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(5),
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  children: <Widget>[
                    Image.network(
                      listData[index]['imageUrl'],
                    ),
                    _isUpdate(),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Row(
                  children: <Widget>[
                    Text(
                      listData[index]['ad'] == 1 ? "[广告]" : "",
                      style: TextStyle(
                        color: Color(0x99C9C9C9),
                        fontSize: getPixe(9, context),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        listData[index]['title'],
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: getPixe(12, context)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          onTap: () {
            if (listData[index]['ad'] == 1) {
              print('广告');
            } else {
              print(listData[index]['title']);
              setState(() {
                listData[index]['click'] = 1;
              });
            }
          },
        ),
      );
    }
  }

  //底部广告位置
  Widget _footerAd() {
    return Positioned(
      bottom: getPixe(20, context),
      right: 20,
      child: Container(
        width: getPixe(60, context),
        height: getPixe(60, context),
        child: GestureDetector(
          child: Center(
            child: Text('广告位置'),
          ),
          onTap: () {
            print('底部广告');
          },
        ),
        color: Colors.blue,
      ),
    );
  }
}
