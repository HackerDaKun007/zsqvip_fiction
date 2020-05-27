/*
 * @author      Yuri Chen <pluto401zz@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 * 
 * @see         排行榜页面
*/


import 'package:flutter/material.dart';

import 'package:fiction/public/public.dart';
import 'package:fiction/res/topChartsData.dart';

class TopChartsPage extends StatefulWidget {
  @override
  _TopChartsPageState createState() => _TopChartsPageState();
}

class _TopChartsPageState extends State<TopChartsPage>
    with SingleTickerProviderStateMixin, PixelSize {
  TabController _controller;
  double rpx;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this); 
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    rpx = getWidth(context) / 750;
    double indicatorWidth = getWidth(context) / 2 - 30;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '排行榜',
          style: TextStyle(fontSize: 36 * rpx),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Iconfont.zuo),
          iconSize: getPixe(26, context),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        bottom: TabBar(
          controller: _controller,
          labelPadding: EdgeInsets.only(bottom: 10 * rpx),
          labelColor: Colors.lightBlue,
          unselectedLabelColor: Colors.black54,
          labelStyle:
              TextStyle(fontSize: 28 * rpx, fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
          indicatorPadding: EdgeInsets.only(
              left: indicatorWidth * rpx, right: indicatorWidth * rpx),
          tabs: <Widget>[
            const Text('男生频道'),
            const Text('女生频道'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: <Widget>[
          TabViewContentWidget(data: topChartsData[0],),
          TabViewContentWidget(data: topChartsData[1],),
        ],
      ),
    );
  }
}

class TabViewContentWidget extends StatefulWidget {
  final List data;
  TabViewContentWidget({Key key, @required this.data}):super(key: key);

  @override
  _TabViewContentWidgetState createState() => _TabViewContentWidgetState();
}

class _TabViewContentWidgetState extends State<TabViewContentWidget> with AutomaticKeepAliveClientMixin, PixelSize{
  double rpx;
  int indexItem;
  List _chartsData;

  // 保持tabbar切换时不重载
  @override
  bool get wantKeepAlive => true;
 
  @override
  void initState() {
    super.initState();
    indexItem = 0;
    _chartsData = widget.data;
  }

  /// 更新排行榜列表
  _updateListData(int index) {
    List list;
    setState(() {
      if (topChartsData.length != 0) {
        list = _chartsData[index]['sort_list'];
      }
    });
    return list;
  }

  Widget _getListWidget(int index) {
    List data = _updateListData(index);
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return _getListItem(index, data);
        });
  }

  /// 排行榜分类菜单列表
  Widget _getNavListItem(int index) {
    Color bgColor = Color(0xfff4f4f4); // 默认背景颜色
    Color textColor = Colors.black54; // 默认文字颜色
    Color borderColor = Colors.transparent; // 默认左边框颜色

    if (index == indexItem) {
      bgColor = Colors.white;
      textColor = Colors.lightBlue;
      borderColor = Colors.lightBlue[600];
    }
    return GestureDetector(
      onTap: () {
        setState(() {
          indexItem = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20 * rpx),
        color: bgColor,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 25 * rpx),
          decoration: BoxDecoration(
            border:
                Border(left: BorderSide(color: borderColor, width: 6 * rpx)),
          ),
          child: Text(
            _chartsData[index]['name'],
            style: TextStyle(fontSize: 28 * rpx, color: textColor),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  /// 排行榜分类列表
  Widget _getListItem(int index, List data) {
    int topNum = 0;
    List<Color> flagColors = []; // 渐变颜色
    switch (index) {
      case 0:
        topNum = 1;
        flagColors = [Color(0xffff0844), Color(0xffffb199)];
        break;
      case 1:
        topNum = 2;
        flagColors = [Color(0xfffc6076), Color(0xffff9a44)];
        break;
      case 2:
        topNum = 3;
        flagColors = [Color(0xff2580B3), Color(0xffCBBACC)];
        break;
      default:
      topNum = 0;
      flagColors=[Colors.transparent, Colors.transparent];
    }
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 210 * rpx,
        padding: EdgeInsets.symmetric(horizontal: 20 * rpx),
        margin: EdgeInsets.only(bottom: 30 * rpx),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Stack(
                children: <Widget>[
                  Material(
                    elevation: 5,
                    color: Colors.transparent,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4 * rpx),
                      child: Image.network(
                        data[index]['image'],
                        height: 190 * rpx,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  topNum > 0 ?
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: 35 * rpx,
                      padding: EdgeInsets.symmetric(vertical: 10 * rpx),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: flagColors,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight)),
                      child: Text(
                        '$topNum',
                        style: const TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ) : SizedBox(width: 0,)
                ],
              ),
            ),
            SizedBox(
              width: 20 * rpx,
            ),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    data[index]['bookname'],
                    style: TextStyle(fontSize: 30 * rpx),
                  ),
                  Text(
                    data[index]['desc'],
                    style: TextStyle(fontSize: 26 * rpx, color: Colors.grey),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10 * rpx),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1 * rpx, color: Colors.lightBlue[200]),
                            borderRadius: BorderRadius.circular(2)),
                        child: Text(
                          data[index]['category'][0],
                          style: TextStyle(
                              color: Colors.lightBlue, fontSize: 20 * rpx),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 10 * rpx),
                        child: Text(
                          '${data[index]['activity_count']}万人气',
                          style: TextStyle(
                              color: Colors.deepOrange, fontSize: 20 * rpx),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    rpx = getWidth(context) / 750;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Container(
            color: const Color(0xfff4f4f4),
            child: ListView.builder(
              itemCount: _chartsData.length,
              itemBuilder: (BuildContext context, int index) {
                return _getNavListItem(index);
              },
            ),
          ),
        ),
        Expanded(
          flex: 7,
          child: Container(
              alignment: Alignment.topCenter, child: _getListWidget(indexItem)),
        )
      ],
    );
  }
}
