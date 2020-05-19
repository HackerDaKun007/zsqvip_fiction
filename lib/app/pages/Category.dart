/*
 * @author      Yuri Chen <pluto401zz@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         分类
*/
import 'package:fiction/res/categoryNameData.dart';
import 'package:flutter/material.dart';

import 'package:fiction/public/public.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with SingleTickerProviderStateMixin, PixelSize {
  TabController _tabController;

  List _boyCategoryNameData = categoryNameData[0];
  List _girlCategoryNameData = categoryNameData[1];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    double indicatorWidth = Config.width / 5 + 10;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          leading: SizedBox(width: 0),
          elevation: 0,
          titleSpacing: 0,
          actions: <Widget>[
            Container(
                padding: EdgeInsets.only(
                    bottom: getPixe(6, context), right: getPixe(6, context)),
                child: IconButton(
                  icon: Icon(Iconfont.sousuo),
                  onPressed: () {
                    Navigator.pushNamed(context, '/search');
                  },
                ))
          ],
          title: TabBar(
            controller: _tabController,
            labelPadding: EdgeInsets.only(bottom: getPixe(5, context)),
            labelColor: Config.color,
            unselectedLabelColor: Colors.black54,
            labelStyle: TextStyle(
                fontSize: getPixe(16, context), fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
            indicatorPadding: EdgeInsets.symmetric(
                horizontal: getPixe(indicatorWidth, context)),
            tabs: <Widget>[
              Text('男生频道'),
              Text('女生频道'),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          CategoryContent(
            categoryData: _boyCategoryNameData,
          ),
          CategoryContent(categoryData: _girlCategoryNameData,)
        ],
      ),
    );
  }
}


/// 页面内容
class CategoryContent extends StatefulWidget {
  final List categoryData;

  CategoryContent({this.categoryData});

  @override
  _CategoryContentState createState() => _CategoryContentState();
}

class _CategoryContentState extends State<CategoryContent> with PixelSize, AutomaticKeepAliveClientMixin {
  List categoryListData;
  List booksData;
  @override
  void initState() {
    super.initState();
    categoryListData = widget.categoryData[0]['category_name'];
    booksData = widget.categoryData[0]['books'];
  }

  // 控制tabbar切换时不重载
  @override
  bool get wantKeepAlive => true;

  /// 拿到分类按钮
  _getbtns(data) {
    List<Widget> list = List<Widget>();
    for (var i=0; i<data.length; i++) {
      list.add(_getCategoryBtn(callback: null, name: data[i]['name']));
    }
    return list;
  }
  /// 分类按钮列表
  Widget _getbtnList(data) {
    return Container(
           width: Config.width,
           padding: EdgeInsets.only(bottom: getPixe(10, context), right: getPixe(20, context), left: getPixe(20, context)),
           child: Row(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               _getCategoryBtn(callback: null, name: '全部', isActive: true),
               SizedBox(width: getPixe(20, context),),
               Expanded(
                 flex: 1,
                 child: Wrap(
                   direction: Axis.horizontal,
                   spacing: getPixe(20, context),
                   runSpacing: getPixe(10, context),
                   children: _getbtns(data),
                 )
               ),
             ],
           ),
         );
  }
  /// 热门分类按钮列表
  Widget _getFeaturebtns() {
     return Container(
           width: Config.width,
           padding: EdgeInsets.symmetric(vertical: getPixe(5, context), horizontal: getPixe(20, context)),
           child: Row(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               _getCategoryBtn(callback: null, name: '热门', isActive: true),
               SizedBox(width: getPixe(20, context),),
               Expanded(
                 flex: 1,
                 child: Wrap(
                   direction: Axis.horizontal,
                   spacing: getPixe(20, context),
                   runSpacing: getPixe(10, context),
                   children: <Widget>[
                     _getCategoryBtn(callback: null, name: '最新'),
                     _getCategoryBtn(callback: null, name: '评分'),
                   ],
                 )
               ),
             ],
           ),
         );
  }

  /// 分类按钮
  Widget _buildCategoryBtnsWidget() {
    return Container(
      width: Config.width,
      margin: EdgeInsets.symmetric(vertical: getPixe(10, context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
         _getbtnList(categoryListData[0]),
         _getbtnList(categoryListData[1]),
         _getbtnList(categoryListData[2]),
         Divider(),
         _getFeaturebtns(),
         Divider(),
        ],
      ),
    );
  }

  Widget _getCategoryBtn({VoidCallback callback, bool isActive = false, String name}) {
    return InkWell(
      onTap: callback,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: getPixe(6, context), vertical: getPixe(2, context)),
        decoration: BoxDecoration(
            color: isActive ? Colors.lightBlue[50] : Colors.transparent,
            borderRadius: BorderRadius.circular(getPixe(4, context))),
        child: Text(
          name,
          style: TextStyle(fontSize: getPixe(14, context), color: isActive ? Config.color : Colors.black54),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _buildCategoryBtnsWidget(),
          CategoryBookContent(data:booksData)
        ],
      ),
    );
  }
}


class CategoryBookContent extends StatefulWidget {
  final List data;
  CategoryBookContent({this.data});

  @override
  _CategoryBookContentState createState() => _CategoryBookContentState();
}

class _CategoryBookContentState extends State<CategoryBookContent> with PixelSize{
  List _data;
  @override
  initState() {
    super.initState();
    _data = widget.data;
  }
  
  Widget _buildBookWidget(data) {
    return Container(
        width: Config.width,
        height: getPixe(90, context),
        margin: EdgeInsets.only(bottom: getPixe(20, context)),
        padding: EdgeInsets.only(left: getPixe(10, context)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
           ClipRRect(
                borderRadius: BorderRadius.circular(getPixe(4, context)),
                child: Image.network(
                  data['image'],
                  height: getPixe(90, context),
                  fit: BoxFit.fill,
                ),
              ),
            SizedBox(
              width: getPixe(5, context),
            ),
            Expanded(
                flex: 1,
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: getPixe(8, context)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              data['bookname'],
                              style: TextStyle(
                                  fontSize: getPixe(16, context), color: Colors.black),
                            ),
                            Text('${data['score']}分',style: TextStyle(color: Colors.red, fontSize: getPixe(13, context)),)
                          ]
                        ),
                        Text(
                          data['desc'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black38, fontSize: getPixe(13, context)),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                _getCategoryWidget(
                                    name: data['category_name'][0]),
                                SizedBox(
                                  width: getPixe(5, context),
                                ),
                                _getCategoryWidget(
                                    name: data['category_name'][1]),
                              ],
                            ),
                            Text(
                              '连载人气 · 100万人气',
                              style: TextStyle(
                                  color: Colors.black38, fontSize: getPixe(10, context)),
                            )
                          ],
                        )
                      ],
                    )))
          ],
        ));
  }

  Widget _getCategoryWidget({String name}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: getPixe(5, context)),
      decoration: BoxDecoration(
          border: Border.all(width: getPixe(0.5, context), color: Colors.grey[400]),
          borderRadius: BorderRadius.circular(2)),
      child: Text(
        name,
        style: TextStyle(color: Colors.black38, fontSize:  getPixe(10, context)),
      ),
    );
  }

  _getListItem(data) {
    List<Widget> _list = List();

    for (var i=0; i<data.length; i++) {
      _list.add(_buildBookWidget(data[i]));
    }
    return _list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Config.width,
      padding: EdgeInsets.all(getPixe(10, context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _getListItem(_data)
      ),
    );
  }
}