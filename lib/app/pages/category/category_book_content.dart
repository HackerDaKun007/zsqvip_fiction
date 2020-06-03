/*
 * @author      Yuri Chen <pluto401zz@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         分类-书本列表
*/
import 'package:flutter/material.dart';

import 'package:fiction/public/public.dart';



class CategoryBookContent extends StatefulWidget {
  final List data;
  CategoryBookContent({this.data, Key key}):super(key:key);

  @override
  _CategoryBookContentState createState() => _CategoryBookContentState();
}

class _CategoryBookContentState extends State<CategoryBookContent> {

  final PixelSize pixel = PixelSize();

  Widget _buildBookWidget(data) {
    num totalNum = (data['total_num'] / 10000).round();
    return Container(
        width: pixel.screenWidthDp(context),
        height: pixel.setFontSize(90, context),
        margin: EdgeInsets.only(bottom: pixel.setFontSize(20, context)),
        padding: EdgeInsets.only(left: pixel.setFontSize(10, context)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(pixel.setFontSize(4, context)),
                child: Image.network(
                  data['image'],
                  height: pixel.setFontSize(90, context),
                  fit: BoxFit.fill,
                ),
              ),
            SizedBox(
              width: pixel.setFontSize(5, context),
            ),
            Expanded(
                flex: 1,
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: pixel.setFontSize(8, context)),
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
                                  fontSize: pixel.setFontSize(16, context), color: Colors.black),
                            ),
                            Text('${data['score']}分',style: TextStyle(color: Colors.red, fontSize: pixel.setFontSize(13, context)),)
                          ]
                        ),
                        Text(
                          data['desc'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black38, fontSize: pixel.setFontSize(13, context)),
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
                                  width: pixel.setFontSize(5, context),
                                ),
                                _getCategoryWidget(
                                    name: data['category_name'][1],),
                              ],
                            ),
                            Text(
                              '${data['status'] == 1 ? '连载' : '完结'} · ${totalNum}万人气',
                              style: TextStyle(
                                  color: Colors.black38, fontSize: pixel.setFontSize(10, context)),
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
      padding: EdgeInsets.symmetric(horizontal: pixel.setFontSize(5, context),vertical: pixel.setFontSize(1, context)),
      decoration: BoxDecoration(
          border: Border.all(width: pixel.setFontSize(0.5, context), color: Colors.grey[400]),
          borderRadius: BorderRadius.circular(2)),
      child: Text(
        name,
        style: TextStyle(color: Colors.black38, fontSize:  pixel.setFontSize(10, context)),
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
      width: pixel.screenWidthDp(context),
      padding: EdgeInsets.all(pixel.setFontSize(10, context)),
      child: widget.data.isNotEmpty
       ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _getListItem(widget.data)
      )
      : Prompt('此分类暂无您想看的书籍', topMargin: 10,),  // 当分类无内容时
    );
  }
}