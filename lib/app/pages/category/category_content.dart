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

class _CategoryContentState extends State<CategoryContent> with PixelSize, AutomaticKeepAliveClientMixin {
  List _categoryListData;
  List _booksData;
  @override
  void initState() {
    super.initState();
    _categoryListData = widget.data['category_list'];
    _booksData = widget.data['books'];
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
         _getbtnList(_categoryListData[0]),
         _getbtnList(_categoryListData[1]),
         _getbtnList(_categoryListData[2]),
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
          CategoryBookContent(data:_booksData)
        ],
      ),
    );
  }
}


