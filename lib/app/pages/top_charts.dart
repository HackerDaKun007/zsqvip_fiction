import 'package:flutter/material.dart';

class TopChartsPage extends StatefulWidget {
  @override
  _TopChartsPageState createState() => _TopChartsPageState();
}

class _TopChartsPageState extends State<TopChartsPage>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    double indicatorWidth = MediaQuery.of(context).size.width / 2 - 30;
    return Scaffold(
      appBar: AppBar(
        title: Text('排行榜', style: TextStyle(fontSize: 36*rpx),),
        centerTitle: true,
        elevation: 0,
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
            Text('男生频道'),
            Text('女生频道'),
          ],
        ),
      ),
      body: SortPageBody(_controller),
    );
  }
}

class SortPageBody extends StatelessWidget {
  TabController controller;

  SortPageBody(this.controller);

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: controller,
      children: <Widget>[
        SortPageContainer(),
        SortPageContainer(),
      ],
    );
  }
}

class SortData {
  String sortName;
  List sortList = [];

  SortData({this.sortName, this.sortList});
}

class BookDetail {
  int bookId = 1;
  String bookImg = 'images/OIP.jpg';
  String bookTitle = '无题';
  String author = '佚名';
  String categoryName = '传说';
  String bookDesc =
      '是十九世纪和手机号就是时间合适就合适是十九世纪和手机号就是时间合适就合适是十九世纪和手机号就是时间合适就合适是十九世纪和手机号就是时间合适就合适';
}

class SortListData extends SortData {
  BookDetail data = BookDetail();

  @override
  List get sortList => List.generate(5, (index) => sortList..add(data));
  @override
  String get sortName => sortName = '人气榜';
}

class SortPageContainer extends StatefulWidget {
  @override
  _SortPageContainerState createState() => _SortPageContainerState();
}

class _SortPageContainerState extends State<SortPageContainer> {
  int indexItem; 
  List<SortListData> sortLists = [];
  SortListData data = SortListData();

  @override
  void initState() {
    super.initState();
    indexItem = 0;
    List.generate(3, (index) => sortLists.add(data));
  }

  Widget _getNavListItem(int index, rpx) {
    Color bgColor = Color(0xfff4f4f4);  // 默认背景颜色
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
            sortLists[index].sortName,
            style: TextStyle(fontSize: 28 * rpx, color: textColor),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Container(
            color: Color(0xfff4f4f4),
            child: ListView.builder(
              itemCount: sortLists.length,
              itemBuilder: (BuildContext context, int index) {
                return _getNavListItem(index, rpx);
              },
            ),
          ),
        ),
        Expanded(
          flex: 7,
          child: Container(
            // margin: EdgeInsets.symmetric(horizontal:15*rpx),
            alignment: Alignment.topCenter,
            child: ListView.builder(
                itemCount: 8,
                itemBuilder: (BuildContext context, int index) {
                  return _getListItem(index, rpx);
                }),
          ),
        )
      ],
    );
  }

  Widget _getListItem(index, rpx) {
    int topNum = 0;
    List<Color> flagColors = [];
    switch (index) {
      case 0:
        topNum = 1;
        flagColors = [Color(0xffff1055), Color(0xfff99185)];
        break;
      case 1:
        topNum = 2;
        flagColors = [Color(0xffff5858), Color(0xfff9d423)];
        break;
      case 2:
        topNum = 3;
        flagColors = [Color(0xfffda085), Color(0xfff6d365)];
        break;
      default:
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
                        'https://tse1-mm.cn.bing.net/th/id/OIP.60drNS4gbPF8T1r5poePMAAAAA?pid=Api&rs=1',
                        height: 190 * rpx,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
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
                          end: Alignment.bottomRight
                        )
                      ),
                      child: Text(
                        '$topNum',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(width: 20*rpx,),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    '无无无',
                    style: TextStyle(fontSize: 30 * rpx),
                  ),
                  Text(
                    '只是介绍，不超过2两行只是介绍，不超过2两行只是介绍，不超过2两行',
                    style: TextStyle(fontSize: 26*rpx, color: Colors.grey),
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
                          '仙侠',
                          style: TextStyle(
                              color: Colors.lightBlue, fontSize: 20 * rpx),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right:10*rpx),
                        child: Text('210万人气', style: TextStyle(color: Colors.deepOrange, fontSize: 20*rpx),),
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
}
