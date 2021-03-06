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


class CategoryBtnsWidget extends StatelessWidget {
  final PixelSize pixel = PixelSize();

  final List data;
  final CategoryProvider provider;
  CategoryBtnsWidget({Key key, this.data, this.provider}):super(key: key);

  /// 分类按钮列表
  Widget _getbtnList({data, BuildContext context, bool isLastOne=false, int index}) {
    return Container(
      width: pixel.screenWidthDp(context),
      padding: isLastOne ? 
        EdgeInsets.symmetric(
          vertical: pixel.setFontSize(5, context), horizontal: pixel.setFontSize(20, context))
      :EdgeInsets.only(
          bottom: pixel.setFontSize(10, context),
          right: pixel.setFontSize(20, context),
          left: pixel.setFontSize(20, context)),
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
            width: pixel.setFontSize(20, context),
          ),
          Expanded(
              flex: 1,
              child: Wrap(
                direction: Axis.horizontal,
                spacing: pixel.setFontSize(20, context),
                runSpacing: pixel.setFontSize(10, context),
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
      width: pixel.screenWidthDp(context),
      margin: EdgeInsets.symmetric(vertical: pixel.setFontSize(10, context)),
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
class CategoryBtn extends StatelessWidget {
  final PixelSize pixel = PixelSize();

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
            horizontal: pixel.setFontSize(6, context), vertical: pixel.setFontSize(2, context)),
        decoration: BoxDecoration(
            color: isActive ? Colors.lightBlue[50] : Colors.transparent,
            borderRadius: BorderRadius.circular(pixel.setFontSize(4, context))),
        child: Text(
          name,
          style: TextStyle(
              fontSize: pixel.setFontSize(14, context),
              color: isActive ? Config.color : Colors.black54),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}