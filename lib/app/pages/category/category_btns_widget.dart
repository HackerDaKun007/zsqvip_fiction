/*
 * @author      Yuri Chen <pluto401zz@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         分类界面-分类按钮内容
*/

import 'package:fiction/providers/categoryProvider.dart';
import 'package:fiction/public/public.dart';
import 'package:flutter/material.dart';


class CategoryBtnsWidget extends StatelessWidget with PixelSize {

  final List data;
  final CategoryProvider provider;
  CategoryBtnsWidget({this.data, this.provider});

  /// 分类按钮列表
  Widget _getbtnList({data, BuildContext context, bool isLastOne=false, int index}) {
    return Container(
      width: getWidth(context),
      padding: isLastOne ? 
        EdgeInsets.symmetric(
          vertical: getPixe(5, context), horizontal: getPixe(20, context))
      :EdgeInsets.only(
          bottom: getPixe(10, context),
          right: getPixe(20, context),
          left: getPixe(20, context)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CategoryBtn(
            name: data[0]['name'],
            index: 0,
            parentIndex: index,
            provider: provider,
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
                children: _getbtns(data, index),
              )),
        ],
      ),
    );
  }

  /// 拿到分类按钮
  _getbtns(data, parentIndex) {
    List<Widget> list = List<Widget>();
    for (var i = 1; i < data.length; i++) {
      list.add(CategoryBtn(
        name: data[i]['name'],
        index: i,
        parentIndex: parentIndex,
        provider: provider,
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getWidth(context),
      margin: EdgeInsets.symmetric(vertical: getPixe(10, context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _getbtnList(data: data[0], context: context, index: 0),
          _getbtnList(data: data[1], context:context, index: 1),
          _getbtnList(data: data[2], context:context, index: 2),
          Divider(),
          _getbtnList(data: data[3], context:context, isLastOne: true, index:3),
          Divider(),
        ],
      ),
    );
  }
}

/// 创建分类按钮
class CategoryBtn extends StatelessWidget with PixelSize{
  final String name;
  final int index;
  final int parentIndex;
  final CategoryProvider provider;
  CategoryBtn({this.name, this.index, this.parentIndex, this.provider});

  @override
  Widget build(BuildContext context) {
    bool isActive = provider.statusList[parentIndex][index];
    return InkWell(
      onTap: () {
        provider.setBtnStatus(index, parentIndex);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: getPixe(6, context), vertical: getPixe(2, context)),
        decoration: BoxDecoration(
            color: isActive ? Colors.lightBlue[50] : Colors.transparent,
            borderRadius: BorderRadius.circular(getPixe(4, context))),
        child: Text(
          name,
          style: TextStyle(
              fontSize: getPixe(14, context),
              color: isActive ? Config.color : Colors.black54),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}