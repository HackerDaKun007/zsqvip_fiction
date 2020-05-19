/*
 * @author      Yuri Chen <pluto401zz@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 * 
 * @see         书城页面
*/

import 'package:fiction/res/todayHotChartsData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:fiction/public/public.dart';


class HomePage extends StatelessWidget with PixelSize {
  final getCurrenIndex;
  HomePage({this.getCurrenIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xfff4f4f4),
          elevation: 1,
          title: Container(
            margin: EdgeInsets.only(right: getPixe(10, context)),
            height: getPixe(44, context),
            child: Container(
              color: Color(0xfffcfcfc),
              padding: EdgeInsets.only(left: getPixe(10, context)),
              child: TextField(
                readOnly: true,
                textAlignVertical: TextAlignVertical(y: -1),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: getPixe(10, context)),
                    icon: Icon(
                      Iconfont.sousuo,
                      color: Color(0xffb5b5b5),
                    ),
                    hintText: '搜索书名或作者',
                    hintStyle: TextStyle(
                      fontSize: getPixe(16, context),
                      color: Color(0xffb5b5b5),
                    ),
                    border: InputBorder.none),
                onTap: () {
                  Navigator.pushNamed(context, '/search');
                },
              ),
            ),
          ),
          actions: <Widget>[
            InkWell(
              onTap: () {},
              child: Ink(
                padding: EdgeInsets.only(right: getPixe(10, context)),
                child: Image.asset(
                  'images/box.png',
                  fit: BoxFit.fitWidth,
                  width: getPixe(30, context),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: HomeBody(getCurrenIndex: getCurrenIndex),
        ));
  }
}

class HomeBody extends StatefulWidget {
  final getCurrenIndex;
  HomeBody({this.getCurrenIndex});
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody>
    with SingleTickerProviderStateMixin {
  List<String> swiperList = [
    'https://images.pexels.com/photos/1667071/pexels-photo-1667071.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/376464/pexels-photo-376464.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
  ];

  double rpx = Config.width / 750; // 自适应像素

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildSwiperWidget(), // 轮播图
        _buildCustomNavBarWidget(), // 导航栏
        _buildRecommendWidget(), // 编辑推荐
        _buildHotChartsWidget(),
        _buildGuessYouLikeWidget(), // 猜你喜欢
        _buildInfinityListWidget() // 无限列表
      ],
    );
  }

  /// 轮播图
  Widget _buildSwiperWidget() {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(26 * rpx)),
      padding: EdgeInsets.symmetric(horizontal: 30 * rpx, vertical: 20 * rpx),
      width: Config.width,
      height: 300 * rpx,
      child: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(26 * rpx)),
        child: Swiper(
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
                onTap: () {},
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(26 * rpx),
                  child: Image.network(
                    swiperList[index],
                    fit: BoxFit.fitWidth,
                  ),
                ));
          },
          itemCount: swiperList.length,
          autoplay: true,
          duration: 500,
          pagination: SwiperPagination(
              builder: DotSwiperPaginationBuilder(
                  color: Colors.white.withOpacity(0.5),
                  activeColor: Colors.white,
                  size: 12 * rpx,
                  activeSize: 12 * rpx),
              margin: EdgeInsets.all(3)),
        ),
      ),
    );
  }

  /// 导航栏
  Widget _buildCustomNavBarWidget() {
    return Container(
        height: 110 * rpx,
        width: 750 * rpx,
        margin: EdgeInsets.symmetric(horizontal: 30 * rpx, vertical: 20 * rpx),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _getCustomNavBarItem(
                imageUrl: 'images/category.png',
                title: '分类',
                onTapHandler: () {
                  widget.getCurrenIndex(2);
                }),
            _getCustomNavBarItem(
                imageUrl: 'images/paihang.png',
                title: '排行榜',
                onTapHandler: () {
                  Navigator.of(context).pushNamed('/topcharts');
                }),
            _getCustomNavBarItem(
                imageUrl: 'images/bookopen.png',
                title: '随便看看',
                onTapHandler: () {
                  return showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                            backgroundColor: Colors.white,
                            child: _showRandomBookDialog(context));
                      });
                }),
            _getCustomNavBarItem(
                imageUrl: 'images/lists.png',
                title: '书单',
                onTapHandler: () {
                  Navigator.pushNamed(context, '/booklist');
                }),
          ],
        ));
  }

  /// 导航栏单按钮
  Widget _getCustomNavBarItem(
      {String title, String imageUrl, Function onTapHandler}) {
    return InkWell(
        onTap: () {
          if (onTapHandler != null) {
            return onTapHandler();
          }
        },
        child: Column(
          children: <Widget>[
            Material(
              child: Image.asset(
                imageUrl,
                fit: BoxFit.fill,
                height: 60 * rpx,
                width: 60 * rpx,
              ),
              color: Colors.white.withOpacity(0),
              elevation: 16,
              shadowColor: Colors.black.withOpacity(0.5),
              clipBehavior: Clip.antiAlias,
            ),
            SizedBox(
              height: 15 * rpx,
            ),
            Text(
              title,
              style: TextStyle(fontSize: 22 * rpx, color: Color(0xff888888)),
            )
          ],
        ));
  }

  /// 编辑推荐
  Widget _buildRecommendWidget() {
    return Container(
      width: 750 * rpx,
      height: 600 * rpx,
      margin: EdgeInsets.all(20 * rpx),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '编辑力荐',
            style: TextStyle(fontSize: 34 * rpx, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 25 * rpx,
          ),
          BookContentWidget(
            bookName: '无无无',
            imageUrl:
                'https://tse1-mm.cn.bing.net/th/id/OIP.60drNS4gbPF8T1r5poePMAAAAA?pid=Api&rs=1',
            bookActivityCount: 20,
            bookCategory: ['仙侠', '传奇'],
            bookDesc: '测试数据',
            isElevation: true,
          ),
          SizedBox(
            height: 40 * rpx,
          ),
          Container(
            height: 280 * rpx,
            width: 750 * rpx,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _getLeftRecommendItem(),
                _getLeftRecommendItem(),
                _getLeftRecommendItem(),
                _getLeftRecommendItem(),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// 其余推荐
  Widget _getLeftRecommendItem() {
    return Container(
      width: (750 / 5) * rpx,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(6 * rpx),
            child: Image.network(
              'https://tse1-mm.cn.bing.net/th/id/OIP.60drNS4gbPF8T1r5poePMAAAAA?pid=Api&rs=1',
              height: 190 * rpx,
              fit: BoxFit.fill,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '无无无无无无无无',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(fontSize: 28 * rpx),
              ),
              Text(
                '110万人气',
                style: TextStyle(fontSize: 22 * rpx, color: Colors.black54),
                textAlign: TextAlign.left,
              ),
            ],
          )
        ],
      ),
    );
  }

  /// 猜你喜欢
  Widget _buildGuessYouLikeWidget() {
    return Container(
      width: 750 * rpx,
      height: 770 * rpx,
      margin: EdgeInsets.all(20 * rpx),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  '猜你喜欢',
                  style: TextStyle(
                      fontSize: 34 * rpx, fontWeight: FontWeight.bold),
                ),
                Container(
                    padding: EdgeInsets.only(right: 20 * rpx),
                    child: InkWell(
                      onTap: () {
                        print(
                            '=========== pressed to change list content ==========');
                      },
                      child: Row(
                        children: <Widget>[
                          Text(
                            '换一换',
                            style: TextStyle(
                                color: Colors.black54, fontSize: 26 * rpx),
                          ),
                          SizedBox(
                            width: 10 * rpx,
                          ),
                          Icon(
                            Icons.loop,
                            size: 32 * rpx,
                            color: Colors.grey[400],
                          )
                        ],
                      ),
                    ))
              ],
            ),
            SizedBox(
              height: 30 * rpx,
            ),
            Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    BookContentWidget(
                      bookName: '无无无',
                      imageUrl:
                          'https://tse1-mm.cn.bing.net/th/id/OIP.60drNS4gbPF8T1r5poePMAAAAA?pid=Api&rs=1',
                      bookActivityCount: 45,
                      bookCategory: ['仙侠', '传奇'],
                      bookDesc: '测试数据',
                    ),
                    BookContentWidget(
                      bookName: '无无无',
                      imageUrl:
                          'https://tse1-mm.cn.bing.net/th/id/OIP.60drNS4gbPF8T1r5poePMAAAAA?pid=Api&rs=1',
                      bookActivityCount: 10,
                      bookCategory: ['古风', '传奇'],
                      bookDesc: '测试数据',
                    ),
                    BookContentWidget(
                      bookName: '无无无',
                      imageUrl:
                          'https://tse1-mm.cn.bing.net/th/id/OIP.60drNS4gbPF8T1r5poePMAAAAA?pid=Api&rs=1',
                      bookActivityCount: 50,
                      bookCategory: ['现代', '传奇'],
                      bookDesc:
                          '测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据',
                    ),
                  ],
                ))
          ]),
    );
  }

  /// 无限列表
  Widget _buildInfinityListWidget() {
    return Container(
      width: 750 * rpx,
      margin: EdgeInsets.all(20 * rpx),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '最多阅读',
              style: TextStyle(fontSize: 34 * rpx, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30 * rpx,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                BookContentWidget(
                    bookName: '无无无',
                    imageUrl:
                        'https://tse1-mm.cn.bing.net/th/id/OIP.60drNS4gbPF8T1r5poePMAAAAA?pid=Api&rs=1',
                    bookActivityCount: 45,
                    bookCategory: ['仙侠', '传奇'],
                    bookDesc: '测试数据',
                    isInfinity: true),
                BookContentWidget(
                    bookName: '无无无',
                    imageUrl:
                        'https://tse1-mm.cn.bing.net/th/id/OIP.60drNS4gbPF8T1r5poePMAAAAA?pid=Api&rs=1',
                    bookActivityCount: 45,
                    bookCategory: ['仙侠', '传奇'],
                    bookDesc: '测试数据',
                    isInfinity: true),
              ],
            )
          ]),
    );
  }

  /// 随便看看弹框
  Widget _showRandomBookDialog(context) {
    return Container(
      height: 620 * rpx,
      width: 450 * rpx,
      padding: EdgeInsets.fromLTRB(30 * rpx, 10 * rpx, 10 * rpx, 10 * rpx),
      child: Stack(
        children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                      padding:EdgeInsets.fromLTRB(0, 20 * rpx, 20 * rpx, 20 * rpx),
                      child: Column(
                        children: <Widget>[
                          Material(
                            elevation: 8,
                            color: Colors.transparent,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8 * rpx),
                              child: Image.network(
                                  'https://tse1-mm.cn.bing.net/th/id/OIP.60drNS4gbPF8T1r5poePMAAAAA?pid=Api&rs=1',
                                  height: 190 * rpx,
                                  fit: BoxFit.fill),
                            ),
                          ),
                          SizedBox(
                            height: 20 * rpx,
                          ),
                          Text(
                            '无无无',
                            style: TextStyle(
                                fontSize: 36 * rpx,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10 * rpx,
                          ),
                          Text(
                            '无无',
                            style: TextStyle(
                                color: Colors.grey, fontSize: 26 * rpx),
                          ),
                          SizedBox(
                            height: 10 * rpx,
                          ),
                          Text(
                            '测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据',
                            style: TextStyle(
                                color: Colors.black54, fontSize: 26 * rpx),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      )),
                ),
                Container(
                    padding: EdgeInsets.only(right: 20 * rpx),
                    width: 450 * rpx,
                    child: FlatButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      // padding: EdgeInsets.symmetric(horizontal:150*rpx),
                      child: Text('立即阅读'),
                      onPressed: () {
                        print('====== pressed =====');
                      },
                    ))
              ],
            ),
          Positioned(
              top: 0,
              right: 0,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close,
                  color: Colors.grey,
                ),
              ))
        ],
      ),
    );
  }

  /// 今日热榜
  Widget _buildHotChartsWidget() {
    return Container(
        width: Config.width,
        height: 500 * rpx,
        margin: EdgeInsets.all(20 * rpx),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    '今日热榜',
                    style: TextStyle(
                        fontSize: 34 * rpx, fontWeight: FontWeight.bold),
                  ),
                  Container(
                      padding: EdgeInsets.only(right: 20 * rpx),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/topcharts');
                        },
                        child: Row(
                          children: <Widget>[
                            Text(
                              '全部榜单',
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 26 * rpx),
                            ),
                            Icon(
                              Icons.chevron_right,
                              size: 40 * rpx,
                              color: Colors.grey[400],
                            )
                          ],
                        ),
                      ))
                ],
              ),
              SizedBox(
                height: 30 * rpx,
              ),
              _getHotChartsTab()
            ]));
  }

  Widget _getHotChartsTab() {
    return Expanded(
        flex: 1,
        child: Column(children: <Widget>[
          TabBar(
            controller: _tabController,
            unselectedLabelColor: Color(0xff333333),
            labelStyle:
                TextStyle(fontSize: 28 * rpx, fontWeight: FontWeight.w700),
            unselectedLabelStyle: TextStyle(fontSize: 28 * rpx),
            indicatorPadding: EdgeInsets.only(left: 70 * rpx, right: 70 * rpx),
            tabs: <Widget>[
              Text('男生人气'),
              Text('男生新书'),
              Text('女生人气'),
              Text('女生新书'),
            ],
          ),
          SizedBox(height: 30 * rpx),
          Expanded(
            flex: 1,
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                _getTabViewItem(_hotChartsData[0]),
                _getTabViewItem(_hotChartsData[1]),
                _getTabViewItem(_hotChartsData[2]),
                _getTabViewItem(_hotChartsData[3]),
              ],
            ),
          ),
        ]));
  }

  Widget _getTabViewItem(data) {
    return Container(
      width: Config.width,
      padding: EdgeInsets.symmetric(horizontal: 10*rpx),
      child: Wrap(
        verticalDirection: VerticalDirection.down,
        direction: Axis.vertical,
        runSpacing: 30*rpx,
        spacing: 10*rpx,
        children: _getHotChartList(data),
      ),
    );
  }
  List _hotChartsData = todayHotChartsData;

  _getHotChartList(data) {
    List<Widget> wrapList = List<Widget>();

    for (var i=0; i<data.length; i++) {
      wrapList.add(_getHotChartsListItem(i, data[i]));
    }
    return wrapList;
  } 
   
  Widget _getHotChartsListItem(int index, data){
    bool isLeftNum = index <= 2;
    Color bgColor;
    String imgUrl;

    switch (index) {
      case 0:
        bgColor = Colors.orange[50];
        imgUrl = 'images/first.png';
        break;
      case 1:
        bgColor = Colors.grey[200];
        imgUrl = 'images/second.png';
        break;
      case 2:
        bgColor = Colors.deepOrange[50];
        imgUrl = 'images/third.png';
        break;
      default:
      bgColor = Colors.blueGrey[50];
      imgUrl = 'images/first.png';
    }

    return InkWell(
        onTap: () {},
        child: Container(
          width: Config.width / 2 - (50*rpx),
          child: Row(
            children: <Widget>[
              isLeftNum ?
              Image.asset(
                imgUrl,
                width: 38*rpx,
                fit: BoxFit.fitWidth,
              ) :
              Container(
                padding: EdgeInsets.symmetric(horizontal:4*rpx, vertical: 2*rpx),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(4*rpx)
                ),
                child: Container(
                  height: 30*rpx,
                  width: 30*rpx,
                  padding: EdgeInsets.only(top: 1*rpx),
                  child: Text('${index+1}', style: TextStyle(color: Colors.white, fontSize: 22*rpx), textAlign: TextAlign.center,)
                ),
              ),
              SizedBox(width: 10*rpx,),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15*rpx, vertical: 10*rpx),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(6*rpx)
                  ),
                  child: Text(data['book_name'], style: TextStyle(fontSize: 24*rpx, ),overflow: TextOverflow.ellipsis,),
                )
              )
            ],
          ),
        ),
      )
    ;
  }
}

// 书本信息展示
class BookContentWidget extends StatelessWidget {
  final String imageUrl; // 图片
  final String bookName; // 书名
  final String bookDesc; // 介绍
  final int bookActivityCount; // 人气人数
  final List<String> bookCategory; // 分类
  final bool isElevation; // 是否要有阴影
  final bool isInfinity; // 是否是无限列表

  BookContentWidget(
      {this.imageUrl,
      this.bookName,
      this.bookDesc,
      this.bookCategory,
      this.bookActivityCount,
      this.isElevation = false,
      this.isInfinity = false});

  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    return Container(
        width: 750 * rpx,
        height: 190 * rpx,
        margin: EdgeInsets.only(bottom: isInfinity ? 50 * rpx : 0 * rpx),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Material(
              elevation: isElevation ? 2 : 0,
              color: Colors.transparent,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6 * rpx),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              width: 10 * rpx,
            ),
            Expanded(
                flex: 1,
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15 * rpx),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          bookName,
                          style: TextStyle(
                              fontSize: 30 * rpx, color: Colors.black),
                        ),
                        Text(
                          bookDesc,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black38, fontSize: 26 * rpx),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                _getCategoryWidget(
                                    name: bookCategory[0], rpx: rpx),
                                SizedBox(
                                  width: 10 * rpx,
                                ),
                                _getCategoryWidget(
                                    name: bookCategory[1], rpx: rpx),
                              ],
                            ),
                            Text(
                              '连载人气 · ${bookActivityCount}万人气',
                              style: TextStyle(
                                  color: Colors.grey[400], fontSize: 20*rpx),
                            )
                          ],
                        )
                      ],
                    )))
          ],
        ));
  }


  // 分类
  Widget _getCategoryWidget({String name, double rpx}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10 * rpx),
      decoration: BoxDecoration(
          border: Border.all(width: 1 * rpx, color: Colors.lightBlue[200]),
          borderRadius: BorderRadius.circular(2)),
      child: Text(
        name,
        style: TextStyle(color: Colors.lightBlue, fontSize: 20 * rpx),
      ),
    );
  }
}
