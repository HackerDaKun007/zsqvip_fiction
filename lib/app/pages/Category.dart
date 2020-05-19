/**
 * @author      Yuri Chen <pluto401zz@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         分类
*/
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  /// 分类内容容器
  Widget _buildTabViewWidget() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _buildCategoryBtnsWidget(),
          _buildCategoryListWidget()
        ],
      ),
    );
  }

  /// 分类按钮
  Widget _buildCategoryBtnsWidget() {
    return Container(
      width: Config.width,
      height: getPixe(250, context),
      color: Colors.grey,
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
    double indicatorWidth = Config.width / 4;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          elevation: 1,
          titleSpacing: 0,
          actions: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: getPixe(6, context), right: getPixe(5, context)),
              child: IconButton(
                icon: Icon(Iconfont.sousuo),
                onPressed: () { Navigator.pushNamed(context, '/search');},
              )
            )
          ],
          title: TabBar(
              controller: _tabController,
              labelPadding: EdgeInsets.only(bottom: getPixe(5, context)),
              labelColor: Colors.lightBlue,
              unselectedLabelColor: Colors.black,
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
          _buildTabViewWidget(),
          _buildTabViewWidget()
        ],
      ),
    );
  }
}
