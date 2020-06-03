/*
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

import 'package:fiction/public/widget/internet.dart';

class EditBookShelf extends StatefulWidget {
  EditBookShelf({Key key}) : super(key: key);

  @override
  _EditBookShelfState createState() => _EditBookShelfState();
}

class _EditBookShelfState extends State<EditBookShelf>  {

  PixelSize pixel = PixelSize();
  var bounced = Bounced(); //配置弹出层

  var providerListData;
  int number = 0;

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
        centerTitle: true,
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
      body: Internet(_init(), providerListData.isData),
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
                  setState(() {
                    providerListData.editSelectAll();
                  });
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
                  bounced.confirm('提示', '确定要删除么？', context).then((value) {
                    if (value) {
                      providerListData.editDel();
                    }
                  });
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

  //主体内容
  Widget _init() {
    return ListView(
        children: <Widget>[
          _getData(),
        ],
      );
  }

  //是否展示取消按钮
  Widget _getCancel() {
    // print(this._dataAction.length);
    // if (this._dataAction.length > 0) {
    return Container(
        width: pixel.setWidth(70, context),
        // height: 40,
        // color: Colors.red,
        child: GestureDetector(
          child: Center(
            child: Text(
              '取消',
              style:
                  TextStyle(fontSize: pixel.setFontSize(18, context), color: Colors.grey),
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
    var gridView = GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 3, //控制一行多个
      crossAxisSpacing: 10.0, //左右距离
      mainAxisSpacing: 10.0, //上下距离
      childAspectRatio: 0.63, //子级的高度、宽度的比例
      children: _getListData(),
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
  List<Widget> _getListData() {
    List<Widget> listData = [];
    int let = (providerListData.editData.length-1);
    // print(providerListData.dataColor);
    for (int i=let; i >= 0; i--) {
      listData.add(Container(
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
                    providerListData.editData[i]['imageUrl'],
                  ),
                  Positioned(
                    top: pixel.setHeight(7, context),
                    right: pixel.setWidth(7, context),
                    child: Icon(
                      Icons.check_circle,
                      size: pixel.setFontSize(22, context),
                      color: Color(providerListData.dataColor[i]['color']),
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
                      providerListData.editData[i]['title'],
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black, fontSize: pixel.setFontSize(14, context)),
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
          providerListData.editAction(i);
        },
      ),
    ));
    }
    return listData;
  }
}
