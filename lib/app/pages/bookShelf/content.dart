/*
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

import 'package:fiction/providers/bookShelf.dart'; //书架数据
import 'package:fiction/providers/tabIndexProvider.dart';
import 'package:provider/provider.dart';

class Content extends StatefulWidget {
  Content({Key key}) : super(key: key);

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> with Common {

  PixelSize pixel = PixelSize();

  // List<Map> listData = [{
  //     "title": '',
  //     "author": '',
  //     "imageUrl": 'images/jia.png',
  //     "system": 1,
  //   }];
  var providerListData;
  var tabProvider;
  
  @override
  void initState() {
    super.initState();
    //更新父级方法
    // widget.updateIsDate(123);
  }
  Widget build(BuildContext context) {

    //数据管理状态
    this.providerListData = Provider.of<BookShelfProviders>(context);
    this.tabProvider = Provider.of<TabIndexProvider>(context);

    return Padding(
      padding: EdgeInsets.all(10),
      child: GridView.count(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 3, //控制一行多个
        crossAxisSpacing: 10.0, //左右距离
        mainAxisSpacing: 10.0, //上下距离
        childAspectRatio: 0.63, //子级的高度、宽度的比例
        children: _getListData(),
      ),
    );
  }


  List<Widget> _getListData() {
   List<Widget> dataList = [];
   int let = (providerListData.data.length-1);
   
   for (int i=let; i >= 0; i--) {
     
     if (i == 0) {
       dataList.add(Container(
        child: GestureDetector(
          child: Column(
            children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(5),
                ),
                clipBehavior: Clip.antiAlias,
                // child: Image.asset(
                //   providerListData.data[i]['imageUrl'],
                // ),
                child: Image.asset(
                  providerListData.data[i]['imageUrl'],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Text(
                  providerListData.data[i]['title'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black, fontSize: pixel.setFontSize(12, context)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          onTap: () {
            //修改父级组件
            tabProvider.changeCurrentIndex(1);
          },
        ),
      ));
      
     } else {
       _isUpdate() {
        if (providerListData.data[i]['click'] == 0 &&
            providerListData.data[i]['chapter'] > providerListData.data[i]['watched_chapter'] && providerListData.data[i]['ad'] == 0) {
          return Positioned(
            top: pixel.setHeight(10, context),
            left: 0,
            child: Container(
              width: pixel.setWidth(65, context),
              height: pixel.setHeight(45, context),
              color: Config.color,
              child: Center(
                child: Text(
                  '更新',
                  style: TextStyle(
                      fontSize: pixel.setFontSize(12, context), color: Colors.white),
                ),
              ),
            ),
          );
        } else {
          return Text('');
        }
      }
      dataList.add(Container(
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
                     cacheImages(providerListData.data[i]['imageUrl']),
                    _isUpdate(),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Row(
                  children: <Widget>[
                    Text(
                      providerListData.data[i]['ad'] == 1 ? "[广告]" : "",
                      style: TextStyle(
                        color: Color(0x99C9C9C9),
                        fontSize: pixel.setFontSize(9, context),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        providerListData.data[i]['title'],
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: pixel.setFontSize(14, context)),
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
            if (providerListData.data[i]['ad'] == 1) {
               Navigator.pushNamed(context, '/h5ad', arguments: {"id":1});
            } else {
              // print(listData[index]['title']);
              // print(123);
              // setState(() {
              //   listData[index]['click'] = 1;
              // });
              providerListData.data.displayUpdate(i);
              Navigator.pushNamed(context, '/present');
            }
          },
        ),
      ));
     }
   }
   return dataList;
  }
}