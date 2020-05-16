/*
 * @author      Yuri Chen <pluto401zz@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 * 
 * @see         书城页面
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../fonts/Iconfont.dart';
// import 'package:novel_flutter/pages/search_page/search_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Container(
            decoration: BoxDecoration(
              color: Color(0xfff9f9f9),
            ),
            child: Container(
              padding: EdgeInsets.only(left: 10),
              child: TextField(
                readOnly: true,
                decoration: InputDecoration(
                    icon: Icon(
                      Iconfont.sousuo,
                      color: Color(0xffb5b5b5),
                    ),
                    hintText: '搜索书名或作者',
                    hintStyle:
                        TextStyle(fontSize: 14, color: Color(0xffb5b5b5)),
                    border: InputBorder.none),
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return SearchPage();
                  // }));
                },
              ),
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () {},
            )
          ],
        ),
        body: SingleChildScrollView(
          child: HomeBody(),
        ));
  }
}

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  List<String> swiperList = [
    'https://images.pexels.com/photos/1667071/pexels-photo-1667071.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/376464/pexels-photo-376464.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
  ];

  double rpx = 0; // 自适应像素

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    rpx = screenWidth / 750;
    return Column(
      children: <Widget>[
        _swiperWidget(screenWidth: screenWidth), // 轮播图
        _customNavBarWidget(), // 导航栏
        _recommendWidget(), // 编辑推荐
        _guessYouLikeWidget(), // 猜你喜欢
        _infinityListWidget() // 无限列表
      ],
    );
  }

  /// 轮播图
  Widget _swiperWidget({double screenWidth}) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(26 * rpx)),
      padding: EdgeInsets.symmetric(horizontal: 30 * rpx, vertical: 20 * rpx),
      width: screenWidth,
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
  Widget _customNavBarWidget() {
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
            ),
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
              imageUrl: 'images/booklist.png',
              title: '书单',
              // route: BookListPage(),
            ),
          ],
        ));
  }

  // 导航栏单按钮
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
                height: 58 * rpx,
                width: 58 * rpx,
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
  Widget _recommendWidget() {
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

  // 其余推荐
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
  Widget _guessYouLikeWidget() {
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
              height: 50 * rpx,
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
  Widget _infinityListWidget() {
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
              height: 50 * rpx,
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
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                      padding:
                          EdgeInsets.fromLTRB(0, 20 * rpx, 20 * rpx, 20 * rpx),
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
              elevation: isElevation ? 5 : 0,
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
                                  color: Colors.grey[400], fontSize: 20 * rpx),
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
