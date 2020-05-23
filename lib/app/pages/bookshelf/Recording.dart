/*
 * @author      HackerDaKun007 <hackerdakun007@gmail.com> 
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         书架页面 -阅读记录
*/
import 'package:flutter/material.dart';

import 'package:fiction/public/public.dart';

import 'package:fiction/public/utils/bounced.dart';
import 'package:fiction/public/widget/prompt.dart';


import 'package:fiction/providers/recordingData.dart'; //阅读记录数据
import 'package:fiction/providers/bookShelf.dart'; //书架数据

import 'package:provider/provider.dart';

class Recording extends StatefulWidget {
  Recording({Key key}) : super(key: key);

  @override
  _RecordingState createState() => _RecordingState();
}

class _RecordingState extends State<Recording> with PixelSize {

  var bounced  = Bounced(); //配置弹出层
  var dataProvider;
  var providerListData;
  @override

  Widget build(BuildContext context) {
    this.dataProvider = Provider.of<RecordingDataProviders>(context);
    this.providerListData = Provider.of<BookShelfProviders>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Iconfont.zuo,
            size: getPixe(28, context),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('阅读记录'),
        actions: <Widget>[
          _getColumnEmpty(),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Column(
            // children: this._getData(),
            children: this._getData(),
          ),
        ],
      ),
    );
  }

  //顶部清空按钮
  Widget _getColumnEmpty() {
    if (dataProvider.data.length > 0) {
      return Container(
            child: GestureDetector(
              child: Center(
                child: Text(
                  '清空',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: getPixe(18, context),
                  ),
                ),
              ),
              onTap: () {
                // print('清空');
                // confirm().then((value) {
                //   print(value);
                // });
                bounced.confirm('提示', '确定要清空么？', context).then((value) {
                  if (value) {
                    // setState(() {
                    //   dataProvider.data = new List();
                    // });
                    dataProvider.remove();
                  }
                });
              },
            ),
            width: getPixe(70, context),
          );
    } else {
      return Text('');
    }
  }

  //内容区域
  List<Widget> _getData() {
    List<Widget> data = new List();
    if (dataProvider.data.length > 0) {
        RaisedButton _button(int isBookShelf, int key) {
        if(isBookShelf == 1) { //已加入
          return RaisedButton(
            child: Text(
              '已在书架',
              style: TextStyle(
                  fontSize: getPixe(14, context), color: Colors.white),
            ),
            onPressed: () {

            },
            color: Colors.grey[300],
          );
        } else { //为加入书架
          return RaisedButton(
            child: Text(
              '加入书架',
              style: TextStyle(
                  fontSize: getPixe(14, context), color: Colors.white),
            ),
            onPressed: () {
              // print(key);
              providerListData.addData(dataProvider.data[key]);
              dataProvider.addBookshle(key);
              bounced.toast('已加入书架', context);
            },
            color: Config.color,
          );
        }
      }
      for (int i=0; i < dataProvider.data.length; i++) {
        data.add(InkWell(
            child: Container(
              height: getPixe(135, context),
              padding: EdgeInsets.all(getPixe(10, context)),
              child: Row(
                children: <Widget>[
                  Container(
                    height: getPixe(110, context),
                    width: getPixe(83, context),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(getPixe(3, context)),
                        image: DecorationImage(
                          image: NetworkImage(dataProvider.data[i]['imageUrl']),
                          fit: BoxFit.cover,
                        )),
                  ),
                  SizedBox(
                    width: getPixe(10, context),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: getPixe(5, context),
                        ),
                        Text(dataProvider.data[i]['title'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: getPixe(18, context),
                          ),
                        ),
                        SizedBox(
                          height: getPixe(25, context),
                        ),
                        Text("${dataProvider.data[i]['category'][0]} · ${dataProvider.data[i]['update_status']}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: getPixe(12, context),
                                color: Color(0x99151515))),
                        SizedBox(
                          height: getPixe(3, context),
                        ),
                        Text("读到第${dataProvider.data[i]['read_chapter']}章: ${dataProvider.data[i]['read_chapter_title']}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: getPixe(12, context),
                                color: Color(0x99151515))),
                        SizedBox(
                          height: getPixe(3, context),
                        ),
                        Text(dataProvider.data[i]['read_time'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: getPixe(12, context),
                                color: Color(0x99151515))),
                      ],
                    ),
                  ),
                  _button(dataProvider.data[i]['book_shelf'], i),
                ],
              ),
            ),
            onTap: () {
              print('跳转阅读页面');
            },
            onLongPress: () {
              bounced.confirm('提示', '确定删除么？', context).then((value) {
                if (value) {
                  dataProvider.removeIndex(i);
                }
              });
            },
          ));
      }
      
    } else {
      data.add(Prompt('暂无阅读记录'));
    }
    return data;
  }


}
