/**
 * @author      HackerDaKun007 <hackerdakun007@gmail.com> 
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         书架页面 - 内容模块
*/

import 'package:flutter/material.dart';
import 'package:fiction/public/public.dart';
import 'package:fiction/res/listData.dart';

class Content extends StatefulWidget {
  final getOut;
  Content({Key key, this.getOut}) : super(key: key);

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> with PixelSize {

  //添加书架
  void getAddListData() {
    listData.add({
      "title": '',
      "author": '',
      "imageUrl": 'images/jia.png',
      "system": 1,
    });
  }
  
  @override
  void initState() {
    super.initState();

  }
  Widget build(BuildContext context) {
    //过滤数据第一个,删除系统追加
    if (listData.length > 1 && listData[0]['system'] == 1) {
      listData.removeAt(0);
    }
    //添加一项追加数据
    if (listData.length == 0) {
      this.getAddListData();
    } else if (listData[(listData.length - 1)]['system'] == null) {
      this.getAddListData();
    }

    return Padding(
      padding: EdgeInsets.all(10),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, //控制一行多个
          crossAxisSpacing: 10.0, //左右距离
          mainAxisSpacing: 10.0, //上下距离
          childAspectRatio: 0.63, //子级的高度、宽度的比例
        ),
        itemCount: listData.length,
        itemBuilder: this._getListData,
      ),
    );
  }


   Widget _getListData(context, index) {
    int dataLength = (listData.length - 1);
    if (index == dataLength) {
      return Container(
        child: GestureDetector(
          child: Column(
            children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(5),
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.asset(
                  listData[index]['imageUrl'],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Text(
                  listData[index]['title'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black, fontSize: getPixe(12, context)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          onTap: () {
            //修改父级组件
            widget.getOut(1);
          },
        ),
      );
    } else {
      //验证是否更新，并且是否点击查看过
      _isUpdate() {
        if (listData[index]['click'] == 0 &&
            listData[index]['chapter'] > listData[index]['watched_chapter'] && listData[index]['ad'] == 0) {
          return Positioned(
            top: getPixe(10, context),
            left: 0,
            child: Container(
              width: getPixe(40, context),
              height: getPixe(20, context),
              color: Config.color,
              child: Center(
                child: Text(
                  '更新',
                  style: TextStyle(
                      fontSize: getPixe(12, context), color: Colors.white),
                ),
              ),
            ),
          );
        } else {
          return Text('');
        }
      }

      return Container(
        child: GestureDetector(
          child: Column(
            children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(5),
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  children: <Widget>[
                    Image.network(
                      listData[index]['imageUrl'],
                    ),
                    _isUpdate(),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Row(
                  children: <Widget>[
                    Text(
                      listData[index]['ad'] == 1 ? "[广告]" : "",
                      style: TextStyle(
                        color: Color(0x99C9C9C9),
                        fontSize: getPixe(9, context),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        listData[index]['title'],
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: getPixe(12, context)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          onTap: () {
            if (listData[index]['ad'] == 1) {
              print('广告');
            } else {
              print(listData[index]['title']);
              print(123);
              setState(() {
                listData[index]['click'] = 1;
              });
            }
          },
        ),
      );
    }
  }
}