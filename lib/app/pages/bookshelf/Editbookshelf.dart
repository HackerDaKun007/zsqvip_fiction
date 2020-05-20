/**
 * @author      HackerDaKun007 <hackerdakun007@gmail.com> 
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         书架页面 - 编辑书架
*/

import 'package:flutter/material.dart';

import 'package:fiction/public/public.dart';
import 'package:fiction/res/listData.dart';
import 'package:fiction/public/widget/Prompt.dart';

class EditBookShelf extends StatefulWidget {
  EditBookShelf({Key key}) : super(key: key);

  @override
  _EditBookShelfState createState() => _EditBookShelfState();
}

class _EditBookShelfState extends State<EditBookShelf> with PixelSize {
  List _data = new List(); //数据
  List _dataAction = new List(); //保存选中数据坐标key
  List _dataActionData = new List(); //备份存储保存选中数据坐标key

  List _dataColor = new List(); //颜色
  List _dataColorBack = new List(); //备份未选中颜色 - 取消
  List _dataColorBackAction = new List(); //备份选中颜色 - 全部

  //广告
  List _adData = List();

  var _deleteColos = Colors.blue[100]; //删除默认颜色
  // var _deleteColos = Config.color;
  void initState() {
    super.initState();
    listData.forEach((value) {
      if (value['ad'] == 0 && value['system'] == null) {
        this._data.add(value);
        this._dataActionData.add(value['id']);
        //存储颜色
        this._dataColor.add({'id':value['id'],'color':Color(0xff9e9e9e)});
        this._dataColorBack.add({'id':value['id'],'color':Color(0xff9e9e9e)});
        this._dataColorBackAction.add({'id':value['id'],'color':Config.color});
      }

      //广告
      if (value['ad'] == 1) {
        this._adData.add(value);
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        leading: Container(
          width: getPixe(70, context),
          child: IconButton(
            icon: Icon(
              Iconfont.zuo,
              size: getPixe(28, context),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text('编辑书架'),
        actions: <Widget>[
          _getCancel(),
        ],
      ),
      body: ListView(
        children: <Widget>[
          _getData(),
        ],
      ),
      bottomNavigationBar: Container(
        height: getPixe(80, context),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: GestureDetector(
                child: Container(
                  color: Colors.white,
                  child: Center(
                    child: Text('全选',
                        style: TextStyle(
                          fontSize: getPixe(16, context),
                        )),
                  ),
                ),
                onTap: () {
                  // print(123);
                  if (this._data.length > 0) {
                    setState(() {
                      this._dataColor = this._dataColorBackAction;
                      this._dataAction = this._dataActionData;
                      this._updateDelteColors();
                    });
                  }
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                child: Container(
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      '删除',
                      style: TextStyle(
                          fontSize: getPixe(16, context), color: this._deleteColos),
                    ),
                  ),
                ),
                onTap: () {
                  if (this._dataAction.length > 0) {
                     
                     setState(() {
                       //如全选,不需要经过循环
                       if (this._dataAction.length == this._data.length) {
                         listData = List();
                         this._data = List();
                       } else {
                         this._dataAction.forEach((value) {
                          listData.removeWhere((v) => v['id'] == value);
                          this._data.removeWhere((v) => v['id'] == value);
                          this._dataColor.removeWhere((v) => v['id'] == value);
                          this._dataColorBack.removeWhere((v) => v['id'] == value);
                          this._dataColorBackAction.removeWhere((v) => v['id'] == value);
                         });
                       }
                      this._dataAction = List();
                      this._updateDelteColors();
                     });


                    //删除广告
                    if (this._data.length > 0) {
                      //判断广告数量 - 10 = 2， 5 = 1
                      int adNum = ((this._data.length) / 5).floor();
                      int number = this._adData.length;
                      this._adData.forEach((value) {
                        if (number > adNum || adNum == 0) {
                          print(number);
                          print(adNum);
                          listData.removeWhere((v) => v['id'] == value['id']);
                          number --;
                        }
                      });
                    }
                    
                    // if (this._data.length < 5) {
                      
                    // } else {
                    //   int adNum = this._data.length / 2;
                    // }
                  }
                },
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black54,
                offset: Offset(0.0, 15.0),
                blurRadius: 15.0,
                spreadRadius: 1.0),
          ],
        ),
      ),
      // controller: ,
    );
  }

  Widget _getListData(context, index) {
    // if (listData[index]['system'] == null && listData[index]['ad'] == 0 ) {
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
                    this._data[index]['imageUrl'],
                  ),
                  Positioned(
                    top: getPixe(7, context),
                    right: getPixe(7, context),
                    child: Icon(Icons.check_circle, size: getPixe(22, context), color:this._dataColor[index]['color'], ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text(
                      this._data[index]['title'],
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black, fontSize: getPixe(12, context)),
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
          // print(this._data[index]['title']);
          setState(() {
            //切换选中按钮
            if (this._dataColor[index]['color'] == Config.color) { //选中状态
              this._dataColor[index]['color'] = Color(0xff9e9e9e);
              this._dataAction.remove(this._data[index]['id']);
            } else { //未选中状态
              this._dataColor[index]['color'] = Config.color;
              this._dataAction.add(this._data[index]['id']);
            }
            this._updateDelteColors();
            // this._data.removeAt(index);
            // print(this._dataAction);
            // listData[index]['click'] = 1;
          });
        },
      ),
    );
    // }
  }

  void _updateDelteColors() {
    if (this._dataAction.length > 0) {
        _deleteColos = Config.color;
    } else {
      _deleteColos = Colors.blue[100];
    }
  }

  //是否展示取消按钮
  Widget _getCancel() {
    // print(this._dataAction.length);
    if (this._dataAction.length > 0) {
      return Container(
              width: getPixe(70, context),
              // height: 40,
              // color: Colors.red,
              child: GestureDetector(
                child: Center(
                  child: Text(
                    '取消',
                    style: TextStyle(
                        fontSize: getPixe(18, context), color: Colors.grey),
                  ),
                ),
                onTap: () {
                  setState(() {
                    this._dataColor = this._dataColorBack;
                    this._dataAction = List();
                    this._updateDelteColors();
                  });
                },
              ));
    } else {
      return Text('');
    }
  }

  //是否展示内容
  Widget _getData() {
    if (this._data.length > 0) {
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
              itemCount: _data.length,
              itemBuilder: this._getListData,
            ),
          );
    } else {
      return Prompt('暂无任何书架可编辑');
    }
  }

}
