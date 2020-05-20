/*
 * @author      Yuri Chen <pluto401zz@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 * 
 * @see         书城页面-今日热榜
*/

import 'package:flutter/material.dart';

import 'package:fiction/public/public.dart';
import 'package:fiction/res/todayHotChartsData.dart';


/// 今日热榜
class HotChartsWidget extends StatefulWidget {
  @override
  _HotChartsWidgetState createState() => _HotChartsWidgetState();
}

class _HotChartsWidgetState extends State<HotChartsWidget> with SingleTickerProviderStateMixin{
  TabController _tabController;
  double rpx = Config.width / 750;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);    
  }

  List _hotChartsData = todayHotChartsData;
  Widget _getHotChartsTab() {
    return Column(children: <Widget>[
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
                HotChartsTabView(data: _hotChartsData[0]),
                HotChartsTabView(data: _hotChartsData[1]),
                HotChartsTabView(data: _hotChartsData[2]),
                HotChartsTabView(data: _hotChartsData[3]),
              ],
            ),
          ),
        ]);
  }
  
  @override
  Widget build(BuildContext context) {
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
              Expanded(
                flex: 1,
                child:  _getHotChartsTab()
              ) 
            ]));
  }
}

/// 今日热榜列表内容
class HotChartsTabView extends StatefulWidget {

  final List data;

  HotChartsTabView({this.data});  
  @override
  _HotChartsTabViewState createState() => _HotChartsTabViewState();
}

class _HotChartsTabViewState extends State<HotChartsTabView>
    with AutomaticKeepAliveClientMixin {
  double rpx = Config.width /750;

  @override
  bool get wantKeepAlive => true;

  _getHotChartList(data) {
    List<Widget> wrapList = List<Widget>();
    for (var i = 0; i < data.length; i++) {
      wrapList.add(_getHotChartsListItem(i, data[i]));
    }
    return wrapList;
  }

  Widget _getHotChartsListItem(int index, data) {
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
        width: Config.width / 2 - (50 * rpx),
        child: Row(
          children: <Widget>[
            isLeftNum
                ? Image.asset(
                    imgUrl,
                    width: 38 * rpx,
                    fit: BoxFit.fitWidth,
                  )
                : Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 4 * rpx, vertical: 2 * rpx),
                    decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(4 * rpx)),
                    child: Container(
                        height: 30 * rpx,
                        width: 30 * rpx,
                        padding: EdgeInsets.only(top: 1 * rpx),
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                              color: Colors.white, fontSize: 22 * rpx),
                          textAlign: TextAlign.center,
                        )),
                  ),
            SizedBox(
              width: 10 * rpx,
            ),
            Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 15 * rpx, vertical: 10 * rpx),
                  decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(6 * rpx)),
                  child: Text(
                    data['book_name'],
                    style: TextStyle(
                      fontSize: 24 * rpx,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Config.width,
      padding: EdgeInsets.symmetric(horizontal: 10 * rpx),
      child: Wrap(
        verticalDirection: VerticalDirection.down,
        direction: Axis.vertical,
        runSpacing: 30 * rpx,
        spacing: 10 * rpx,
        children: _getHotChartList(widget.data),
      ),
    );
  }
}
