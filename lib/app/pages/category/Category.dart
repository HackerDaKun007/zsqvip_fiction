/*
 * @author      Yuri Chen <pluto401zz@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         分类
*/
import 'package:fiction/app/pages/category/category_content.dart';
import 'package:fiction/res/categoryNameData.dart';
import 'package:flutter/material.dart';

import 'package:fiction/public/public.dart';

class CategoryPage extends StatefulWidget {

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with SingleTickerProviderStateMixin, PixelSize {
  TabController _tabController;

  Object _boyCategoryNameData = categoryNameData[0];
  Object _girlCategoryNameData = categoryNameData[1];

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
          CategoryContent(data:_boyCategoryNameData),
          CategoryContent(data:_girlCategoryNameData),
        ],
      ),
    );
  }
}
