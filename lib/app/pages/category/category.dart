/*
 * @author      Yuri Chen <pluto401zz@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         分类-主页
*/

import 'package:fiction/app/pages/category/category_btns_widget.dart';
import 'package:fiction/providers/categoryProvider.dart';
import 'package:fiction/res/categoryNameData.dart';
import 'package:flutter/material.dart';

import 'package:fiction/public/public.dart';

import 'package:fiction/app/ad/Tabsad.dart';
import 'package:provider/provider.dart';

import 'category_book_content.dart';

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
  void dispose() {
    super.dispose();
    _tabController.dispose();    
  }

  @override
  Widget build(BuildContext context) {
    double indicatorWidth = getWidth(context) / 5 + 10;
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
                  icon: const Icon(Iconfont.sousuo),
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
              const Text('男生频道'),
              const Text('女生频道'),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          TabBarView(
            controller: _tabController,
            children: <Widget>[
              ChangeNotifierProvider<CategoryProvider>(
                create: (context) => CategoryProvider(_boyCategoryNameData),
                child: CategoryContent(data:_boyCategoryNameData),
              ),
              ChangeNotifierProvider<CategoryProvider>(
                create: (context) => CategoryProvider(_girlCategoryNameData),
                child: CategoryContent(data:_girlCategoryNameData),
              ),
            ],
          ),
          TabsAd()
        ]
      ),
    );
  }
}

class CategoryContent extends StatefulWidget {
  final Map data;
  CategoryContent({Key key, this.data});

  @override
  _CategoryContentState createState() => _CategoryContentState();
}

class _CategoryContentState extends State<CategoryContent>
    with PixelSize, AutomaticKeepAliveClientMixin {
    List _booksData = List();
    List _categoryNameData = List();


  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _categoryNameData = widget.data['category_list'];
  }

  @override
  Widget build(BuildContext context) {
    CategoryProvider provider = Provider.of<CategoryProvider>(context);
    _booksData = provider.booksList;
    return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CategoryBtnsWidget(data: _categoryNameData, provider: provider,),
            CategoryBookContent(data: _booksData)
          ],
        )
    );
  }
}
