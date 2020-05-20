/*
 * @author      Yuri Chen <pluto401zz@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         分类-内容
*/
import 'package:fiction/app/pages/category/category_book_content.dart';
import 'package:flutter/material.dart';

import 'package:fiction/public/public.dart';

/// 页面内容
class CategoryContent extends StatefulWidget {
  final Map data;
  CategoryContent({Key key, this.data});

  @override
  _CategoryContentState createState() => _CategoryContentState();
}

class _CategoryContentState extends State<CategoryContent>
    with PixelSize, AutomaticKeepAliveClientMixin {
  List _categoryListData;
  List _booksData;

  int _firstSelectedIndex;  // 第一组筛选
  int _secondSelectedIndex; // 第二组筛选
  int _thirdSelectedIndex; // 第三组筛选
  int _featureSelectedIndex; // 第四组筛选

  /// 第一组筛选控制
  hanldeFirstSelect(index) {
    print('$index  -- $_firstSelectedIndex');
    if (index == _firstSelectedIndex) return;
    
    setState(() {
      _firstSelectedIndex = index;
    });

  }

  /// 第二组筛选控制
  hanldeSecondSelect(index) {
    if (index == _secondSelectedIndex) return;
    
    setState(() {
      _secondSelectedIndex = index;
    });

  }

  @override
  void initState() {
    super.initState();
    _categoryListData = widget.data['category_list'];
    _booksData = widget.data['books'];
    _firstSelectedIndex = 0;
    _secondSelectedIndex = 0;
    _thirdSelectedIndex = 0;
    _featureSelectedIndex = 0;
  }

  // 控制tabbar切换时不重载
  @override
  bool get wantKeepAlive => true;

  /// 拿到分类按钮
  _getbtns(data) {
    List<Widget> list = List<Widget>();
    for (var i = 1; i < data.length; i++) {
      list.add(CategoryBtn(callback: ()=>hanldeFirstSelect(i), name: data[i]['name'], index: i, selectIndex: _firstSelectedIndex));
    }
    return list;
  }

  /// 分类按钮列表
  Widget _getbtnList(data, index) {
    return Container(
      width: Config.width,
      padding: EdgeInsets.only(
          bottom: getPixe(10, context),
          right: getPixe(20, context),
          left: getPixe(20, context)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CategoryBtn(callback: hanldeFirstSelect(0), name: data[0]['name'], index: 0, selectIndex: index,),
          SizedBox(
            width: getPixe(20, context),
          ),
          Expanded(
              flex: 1,
              child: Wrap(
                direction: Axis.horizontal,
                spacing: getPixe(20, context),
                runSpacing: getPixe(10, context),
                children: _getbtns(data),
              )),
        ],
      ),
    );
  }

  /// 热门分类按钮列表
  Widget _getFeaturebtns() {
    return Container(
      width: Config.width,
      padding: EdgeInsets.symmetric(
          vertical: getPixe(5, context), horizontal: getPixe(20, context)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CategoryBtn(callback: null, name: '热门', index: 0, selectIndex: _featureSelectedIndex,),
          SizedBox(
            width: getPixe(20, context),
          ),
          Expanded(
              flex: 1,
              child: Wrap(
                direction: Axis.horizontal,
                spacing: getPixe(20, context),
                runSpacing: getPixe(10, context),
                children: <Widget>[
                  CategoryBtn(callback: null, name: '最新', index: 1, selectIndex: _featureSelectedIndex),
                  CategoryBtn(callback: null, name: '评分', index: 2, selectIndex: _featureSelectedIndex,),
                ],
              )),
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
          _getbtnList(_categoryListData[0], _firstSelectedIndex),
          _getbtnList(_categoryListData[1], _secondSelectedIndex),
          _getbtnList(_categoryListData[2], _thirdSelectedIndex),
          Divider(),
          _getFeaturebtns(),
          Divider(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _buildCategoryBtnsWidget(),
          CategoryBookContent(data: _booksData)
        ],
      ),
    );
  }
}


class CategoryBtnListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}


class CategoryBtn extends StatefulWidget {
  final String name;
  final int index; 
  final int selectIndex;
  final Function callback;

  CategoryBtn({this.name, this.index, this.selectIndex, this.callback});

  @override
  _CategoryBtnState createState() => _CategoryBtnState();
}

class _CategoryBtnState extends State<CategoryBtn> with PixelSize{
  bool isActive;

  @override
  void initState() {
    super.initState();
    isActive = widget.index == widget.selectIndex ? true : false;
  }


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isActive = !isActive;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: getPixe(6, context), vertical: getPixe(2, context)),
        decoration: BoxDecoration(
            color: isActive ? Colors.lightBlue[50] : Colors.transparent,
            borderRadius: BorderRadius.circular(getPixe(4, context))),
        child: Text(
          widget.name,
          style: TextStyle(
              fontSize: getPixe(14, context),
              color: isActive ? Config.color : Colors.black54),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
