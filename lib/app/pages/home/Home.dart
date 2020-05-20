/*
 * @author      Yuri Chen <pluto401zz@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 * 
 * @see         书城页面-主页
*/

import 'package:fiction/app/ad/Tabsad.dart';
import 'package:fiction/app/pages/home/home_build_book.dart';
import 'package:fiction/app/pages/home/home_guess_you_like.dart';
import 'package:fiction/app/pages/home/home_hot_charts.dart';
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


class HomeBody extends StatelessWidget {
  final getCurrenIndex;
  HomeBody({this.getCurrenIndex});

  final List<String> swiperList = [
    'https://images.pexels.com/photos/1667071/pexels-photo-1667071.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/376464/pexels-photo-376464.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
  ];

  final double rpx = Config.width / 750; // 自适应像素


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildSwiperWidget(), // 轮播图
        _buildCustomNavBarWidget(context), // 导航栏
        _buildRecommendWidget(), // 编辑推荐
        HotChartsWidget(), // 今日热榜
        GuessYouLike(), // 猜你喜欢
        _buildInfinityListWidget(), // 无限列表
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
  Widget _buildCustomNavBarWidget(context) {
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
                  getCurrenIndex(2);
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
                              fontSize: 36 * rpx, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10 * rpx,
                        ),
                        Text(
                          '无无',
                          style:
                              TextStyle(color: Colors.grey, fontSize: 26 * rpx),
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

  
}
