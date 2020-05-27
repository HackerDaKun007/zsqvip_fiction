/*
 * @author      HackerDaKun007 <hackerdakun007@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         搜索页面 - 结果
*/

import 'package:flutter/material.dart';
import 'package:fiction/public/public.dart';

import 'package:fiction/res/listData.dart';

import 'package:fiction/public/widget/internet.dart';

class ResultSearch extends StatefulWidget {
  Map arguments;
  ResultSearch({Key key, this.arguments}) : super(key: key);

  @override
  _ResultSearchState createState() =>
      _ResultSearchState(arguments: this.arguments);
}

class _ResultSearchState extends State<ResultSearch> with PixelSize, Common {
  //定义变量区域
  String title; //
  String _input; //
  Map arguments;

  bool _isData = false; //判断数据是否请求下来
  //构造函数
  _ResultSearchState({this.arguments}) {
    this.title = this.arguments['title'];
    this._input = this.arguments['title'];

    //请求成功下来
    _isData = true;
  }

  @override
  // void initState() {
  //   super.initState();
  //   print(arguments['sr']);
  // }

  Widget build(BuildContext context) {
    return Internet(_init(), this._isData);
  }

  //主体内容
  Widget _init() {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
        // centerTitle: true,
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
        titleSpacing: 0.0,
        title: Container(
          // color: Colors.yellow,
          width: double.infinity,
          height: getPixe(44, context),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                getPixe(10, context), 0, getPixe(10, context), 0),
            child: Center(
              child: TextField(
                controller: TextEditingController(
                  text: this.title,
                ),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: getPixe(11.2, context)),
                  icon: Icon(
                    Iconfont.sousuo,
                    size: getPixe(22, context),
                    color: Color(0x993c3c3c),
                  ),
                  hintText: '搜索书名或作者',
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  this._input = value;
                },
                style: TextStyle(fontSize: getPixe(16.0, context)),
              ),
            ),
          ),
          decoration: BoxDecoration(
            color: Color(0x99ededed),
            borderRadius: BorderRadius.all(
              Radius.circular(getPixe(100, context)),
            ),
          ),
        ),
        // elevation:
        actions: <Widget>[
          Container(
              width: getPixe(70, context),
              // height: 40,
              // color: Colors.red,
              child: GestureDetector(
                child: Center(
                  child: Text(
                    '搜索',
                    style: TextStyle(
                      fontSize: getPixe(16, context),
                    ),
                  ),
                ),
                onTap: () {
                  if (empty(this._input) && this._input != this.title) {
                    setState(() {
                      this.title = this._input;
                      print('搜索 ${this.title}');
                    });
                  }
                },
              )),
        ],
      ),
      body: ListView(
        children: _getData(),
      ),
    );
  }

  //返回搜索结果
  List<Widget> _getData() {
    List<Widget> _data = new List();
    listData.forEach((value) {
      if (value['system'] == null) {
        _data.add(InkWell(
          onTap: () {
            print('跳转页面');
          },
          child: Container(
            width: double.infinity,
            height: getPixe(135, context),
            padding: EdgeInsets.fromLTRB(
                getPixe(10, context),
                getPixe(25, context),
                getPixe(10, context),
                getPixe(10, context)),
            // color: Colors.yellow,
            child: Row(
              children: <Widget>[
                Container(
                  height: getPixe(110, context),
                  width: getPixe(83, context),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(getPixe(3, context)),
                      image: DecorationImage(
                        image: NetworkImage(value['imageUrl']),
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
                      SizedBox(height: getPixe(5, context)),
                      Text(
                        "${value['title']}",
                        style: TextStyle(
                          fontSize: getPixe(18, context),
                        ),
                      ),
                      SizedBox(height: getPixe(5, context)),
                      Row(
                        children: <Widget>[
                          Text("${value['author']}",
                              style: TextStyle(
                                  fontSize: getPixe(14, context),
                                  color: Color(0x997e7e7e))),
                          Row(
                            children: _getCategory(value['category']),
                          ),
                          // _getCategory(value['category']),
                        ],
                      ),
                      SizedBox(height: getPixe(5, context)),
                      Text(
                        "${value['sutitle']}",
                        style: TextStyle(
                            fontSize: getPixe(14, context),
                            color: Color(0x99151515)),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
      }
    });
    return _data;
  }

  //返回类别
  List<Widget> _getCategory(var data) {
    List<Widget> _category = new List();
    int _num = 1; //分类长度最大2
    data.forEach((value) {
      if (_num <= 2) {
        _category.add(Container(
          margin: EdgeInsets.symmetric(horizontal: getPixe(5.0, context)),
          padding: EdgeInsets.symmetric(horizontal: getPixe(5.0, context)),
          decoration: BoxDecoration(
              border:
                  Border.all(width: getPixe(1, context), color: Config.color),
              borderRadius: BorderRadius.circular(2)),
          child: Text(
            value,
            style: TextStyle(
                color: Config.color, fontSize: getPixe(12.0, context)),
          ),
        ));
        _num++;
      } else {
        return false;
      }
    });
    return _category;
  }
}
