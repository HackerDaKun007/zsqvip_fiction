/*
 * @author      Yuri Chen <pluto401zz@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         分类界面-分类按钮内容
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

  List _tempBooksList;
  List<int> _categoryIndex = List(4);

  int _firstSelectedIndex; // 第一组筛选
  int _secondSelectedIndex; // 第二组筛选
  int _thirdSelectedIndex; // 第三组筛选
  int _featureSelectedIndex; // 第四组筛选

  /// 第一组筛选控制
  hanldeFirstSelect(id) {
    List _tempData = List();

    if (id == 0) {
      _tempData = _tempBooksList;
    } else {
      for (var i = 0; i < _booksData.length; i++) {
        if (_booksData[i]['category_id'] == id) {
          _tempData.add(_booksData);
        }
      }
    }

    _tempBooksList = _tempData;
  }

  /// 第二组筛选控制
  hanldeSecondSelect(index) {
    
  }

  /// 第三组筛选控制
  hanldeThirdSelect(index) {
    List _tempData = List();
    if (index == 0) {

    }
  }

  handlerSelect() {
    bool isNotSelect = _categoryIndex.every((item)=> item == 0);
    _tempBooksList = isNotSelect ? _booksData : _tempBooksList;
  }

  @override
  void initState() {
    super.initState();
    _categoryListData = widget.data['category_list'];
    _booksData = widget.data['books'];
    _tempBooksList = _booksData;

    _categoryIndex[0] = 0;
    _categoryIndex[1] = 0;
    _categoryIndex[2] = 0;
    _categoryIndex[3] = 0;

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
      list.add(CategoryBtn(
        callback: () => hanldeFirstSelect(i),
        name: data[i]['name'],
      ));
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
          CategoryBtn(
            callback: hanldeFirstSelect(0),
            name: data[0]['name'],
          ),
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
          CategoryBtn(
            callback: null,
            name: '热门',
            isActive: true,
          ),
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
                  CategoryBtn(
                    callback: null,
                    name: '最新',
                  ),
                  CategoryBtn(
                    callback: null,
                    name: '评分',
                  ),
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
    return Container();
  }
}

class CategoryBtn extends StatefulWidget {
  final String name;
  final bool isActive;
  final Function callback;

  CategoryBtn({this.name, this.isActive, this.callback});

  @override
  _CategoryBtnState createState() => _CategoryBtnState();
}

class _CategoryBtnState extends State<CategoryBtn> with PixelSize {
  bool isActive;

  @override
  void initState() {
    super.initState();
    isActive = widget.isActive != null ? widget.isActive : false;
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
