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
            labelColor: Colors.lightBlue,
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

class CategoryContent extends StatefulWidget {
  final List categoryData;

  CategoryContent({this.categoryData});

  @override
  _CategoryContentState createState() => _CategoryContentState();
}

class _CategoryContentState extends State<CategoryContent> with PixelSize, AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  _getbtns(data) {
    print(data);
    List<Widget> list = List<Widget>();
    for (var i=0; i<data.length; i++) {
      list.add(_getCategoryBtn(callback: null, name: data[i]['name']));
    }
    return list;
  }

  Widget _getbtnList(data) {
    return Container(
           width: Config.width,
           padding: EdgeInsets.only(bottom: getPixe(10, context)),
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

  Widget _getFeaturebtns() {
     return Container(
           width: Config.width,
           padding: EdgeInsets.symmetric(vertical: getPixe(5, context)),
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
      height: getPixe(300, context),
      // margin: EdgeInsets.symmetric(vertical: getPixe(10, context)),
      padding: EdgeInsets.all(getPixe(20, context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
         _getbtnList(widget.categoryData[0]),
         _getbtnList(widget.categoryData[1]),
         _getbtnList(widget.categoryData[2]),
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

  /// 分类详情列表
  Widget _buildCategoryListWidget() {
    return Container(
      width: Config.width,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _buildCategoryBtnsWidget(),
          _buildCategoryListWidget()
        ],
      ),
    );
  }
}
