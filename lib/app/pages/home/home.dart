/*
 * @author      Yuri Chen <pluto401zz@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 * 
 * @see         书城页面-主页
*/

import 'package:fiction/app/pages/home/home_ad.dart';
import 'package:fiction/app/pages/home/home_random_book_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:fiction/public/public.dart';
import 'package:fiction/app/ad/Tabsad.dart';
import 'package:fiction/app/pages/home/home_build_book.dart';
import 'package:fiction/app/pages/home/home_guess_you_like.dart';
import 'package:fiction/app/pages/home/home_hot_charts.dart';
import 'package:fiction/app/pages/home/home_recommend.dart';
import 'package:fiction/res/guessYouLikeData.dart';

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
            GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: getPixe(5, context)),
                child: Stack(
                  fit: StackFit.passthrough,
                  children: [
                    Image.asset('images/li.png', width: getPixe(70, context), fit:BoxFit.fitWidth),
                    Positioned(
                      top: getPixe(22, context),
                      left: getPixe(35, context),
                      child: Text(
                        '签到',
                        style: TextStyle(
                            fontSize: getPixe(12, context), color: Colors.brown),
                      ),
                    )
                  ]
                )
              ),
              onTap: () {
                print('签到');
              },
            ),
          ],
        ),
        body: Stack(children: [
          SingleChildScrollView(
            child: HomeBody(getCurrenIndex: getCurrenIndex),
          ),
          TabsAd()
        ]));
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
  final List _listData = guessYouLikeData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildSwiperWidget(), // 轮播图
        _buildCustomNavBarWidget(context), // 导航栏
        EditorsRecommend(), // 编辑推荐
        HotChartsWidget(), // 今日热榜
        GuessYouLike(), // 猜你喜欢
        AdWidget(),
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
                            child: RandomBookDialog()
                          );
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
                BookContentWidget(data: _listData[0], isInfinity: true),
                BookContentWidget(data: _listData[2], isInfinity: true),
              ],
            )
          ]),
    );
  }


}