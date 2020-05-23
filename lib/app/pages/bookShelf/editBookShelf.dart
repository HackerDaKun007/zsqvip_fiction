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

import 'package:fiction/public/widget/prompt.dart';
import 'package:fiction/public/utils/bounced.dart';

import 'package:fiction/providers/bookShelf.dart'; //书架数据
import 'package:provider/provider.dart';

class EditBookShelf extends StatefulWidget {
  EditBookShelf({Key key}) : super(key: key);

  @override
  _EditBookShelfState createState() => _EditBookShelfState();
}

class _EditBookShelfState extends State<EditBookShelf> with PixelSize {
  var bounced = Bounced(); //配置弹出层

  // List _data = new List(); //数据
  // List _dataAction = new List(); //保存选中数据坐标key
  // List _dataActionData = new List(); //备份存储保存选中数据坐标key

  // List _dataColor = new List(); //颜色
  // List _dataColorBack = new List(); //备份未选中颜色 - 取消
  // List _dataColorBackAction = new List(); //备份选中颜色 - 全部

  //广告
  List _adData = List();
  var providerListData;
  // var _deleteColos = Colors.blue[100]; //删除默认颜色
  // var _deleteColos = Config.color;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    this.providerListData = Provider.of<BookShelfProviders>(context);

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
                  providerListData.editSelectAll();
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
                          fontSize: getPixe(16, context),
                          color: providerListData.deleteColos),
                    ),
                  ),
                ),
                onTap: () {
                  providerListData.editDel();
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


  //是否展示取消按钮
  Widget _getCancel() {
    // print(this._dataAction.length);
    // if (this._dataAction.length > 0) {
    return Container(
        width: getPixe(70, context),
        // height: 40,
        // color: Colors.red,
        child: GestureDetector(
          child: Center(
            child: Text(
              '取消',
              style:
                  TextStyle(fontSize: getPixe(18, context), color: Colors.grey),
            ),
          ),
          onTap: () {
            providerListData.editCancel();
          },
        ));
    // } else {
    //   return Text('');
    // }
  }

  //是否展示内容
  Widget _getData() {
    if (providerListData.editData.length > 0) {
    var gridView = GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, //控制一行多个
        crossAxisSpacing: 10.0, //左右距离
        mainAxisSpacing: 10.0, //上下距离
        childAspectRatio: 0.63, //子级的高度、宽度的比例
      ),
      itemCount: providerListData.editData.length,
      itemBuilder: _getListData,
      // itemBuilder: 
    );
    return Padding(
      padding: EdgeInsets.all(10),
      child: gridView,
    );
    } else {
      return Prompt('暂无任何书架可编辑');
    }
  }
  Widget _getListData(context, index) {
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
                    providerListData.editData[index]['imageUrl'],
                  ),
                  Positioned(
                    top: getPixe(7, context),
                    right: getPixe(7, context),
                    child: Icon(
                      Icons.check_circle,
                      size: getPixe(22, context),
                      color: Color(providerListData.dataColor[index]['color']),
                    ),
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
                      providerListData.editData[index]['title'],
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
          providerListData.editAction(index);
        },
      ),
    );
    // }
  }
}
