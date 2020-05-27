/*
 * @author      HackerDaKun007 <hackerdakun007@gmail.com> 
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         书架页面
*/

import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fiction/public/public.dart';

//引入页面
import 'package:fiction/app/pages/bookShelf/columnleft.dart'; //顶部左边导航
import 'package:fiction/app/pages/bookShelf/content.dart'; //内容模块
import 'package:fiction/app/ad/tabsAd.dart'; //底部广告位置
import 'package:fiction/app/readTime/readTime.dart'; //阅读时间

//状态管理
import 'package:fiction/providers/bookShelf.dart'; //书架数据
import 'package:http/http.dart';
import 'package:provider/provider.dart';

//网络状态
import 'package:fiction/public/widget/internet.dart';

//阅读分钟
// int Path.minute = 0;
// int parindex = 0BuildContext context, ;

class BookShelfPage extends StatefulWidget {
  final getCurrenIndex;
  // int print;
  BookShelfPage({Key key, this.getCurrenIndex}) : super(key: key);
  @override
  _BookShelfPageState createState() => _BookShelfPageState();
}

class _BookShelfPageState extends State<BookShelfPage> with PixelSize {
  var providerListData; //状态

  final int appbarAlpha = 100; //滚动最大值
  //修改顶部透明值
  double appBarAlpha = 0;
  //获取滚动事件方法
  _onScroll(double offset) {
    double appha = offset / this.appbarAlpha;
    if (appha <= 1.5 && appha >= -1) {
      if (appha < 0) {
        appha = 0;
      } else if (appha > 1) {
        appha = 1;
      }
      this.appBarAlpha = appha;
      //更新局部 - 顶部左边导航
      columnLetTime.currentState.updateOpacity(this.appBarAlpha);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    //数据管理状态
    this.providerListData = Provider.of<BookShelfProviders>(context);
    return Internet(_init(), providerListData.isData);
  }

  //主体内容
  Widget _init() {
    return Stack(
      children: <Widget>[
        MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: NotificationListener(
            onNotification: (scrollNotification) {
              if (scrollNotification is ScrollUpdateNotification &&
                  scrollNotification.depth == 0) {
                //滚动且是列表滚动的时候
                _onScroll(scrollNotification.metrics.pixels);
              }
            },
            child: ListView(
              children: <Widget>[
                this._readTime(),
                //推荐内容
                RecommendedContent(),
                //列表内容
                Content(getOut: () => _getOut()),
              ],
            ),
          ),
        ),
        ColumnLet(key: columnLetTime), //顶部左边导航

        this._columnIocn(),
        // this._footerAd(),
        TabsAd(),
      ],
    );
  }

  //头部背景显示阅读
  Widget _readTime() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
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
                        child: ReadTime(
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
                    print('签到');
                    // setState(() {
                    //   Path.minute += 1;
                    // });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //顶部右边导航
  Widget _columnIocn() {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        height: getPixe(75, context),
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, getPixe(35, context), 10, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Iconfont.sousuo,
                  size: getPixe(22, context),
                  color: Color(0xFF000000),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/search');
                },
              ),
              IconButton(
                icon: Icon(
                  Iconfont.youcecaidan,
                  size: getPixe(22, context),
                  color: Color(0xFF000000),
                ),
                onPressed: () {
                  showMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(getPixe(500, context),
                        getPixe(74, context), getPixe(10, context), 0),
                    items: <PopupMenuEntry<String>>[
                      PopupMenuItem(
                        value: '1',
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              Icons.query_builder,
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
                      PopupMenuDivider(),
                      PopupMenuItem(
                        value: '2',
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
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
                    ],
                  ).then<void>((String value) {
                    // Navigator.pop(context);
                    if (value == '1') {
                      Navigator.pushNamed(context, '/recording');
                    } else if (value == '2') {
                      Navigator.pushNamed(context, '/editbookshelf');
                    }
                    // pop.onSelected(value);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  //修改父级组件
  void _getOut() {
    widget.getCurrenIndex(1);
  }
}

//推荐内容
class RecommendedContent extends StatelessWidget with PixelSize {
  List<Map> list = [
    {"title": "我把你当兄弟你居然想上我？", "id": 1},
    {"title": "穿越异界，成为一代邪君！", "id": 2},
    {"title": "守护我方轩宇，千秋在线刚枪", "id": 3},
    {"title": "守护我方轩宇，千秋在线刚枪", "id": 4},
    {"title": "最强斗神重生复活，再战丧尸末世", "id": 5},
  ];
  @override
  Widget build(BuildContext context) {
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
                            fontSize: getPixe(14, context),
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
}
