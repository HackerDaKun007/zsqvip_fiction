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

class _ResultSearchState extends State<ResultSearch> with Common {
  PixelSize pixel = PixelSize();

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
      backgroundColor: Colors.white,
      appBar: _appber(),
      body: ListView(
        children: _getData(),
      ),
    );
  }

  //头部
  Widget _appber() {
    return AppBar(
      centerTitle: true,
      elevation: 1,
      automaticallyImplyLeading: false,
      titleSpacing: 0.0,
      title: Row(
        children: <Widget>[
          Container(
            width: pixel.setWidth(115, context),
            height: pixel.setHeight(85.0, context),
            child: IconButton(
              icon: Icon(
                Iconfont.zuo,
                size: pixel.setFontSize(26, context),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: pixel.setHeight(85.0, context),
                  maxWidth: double.infinity),
              child: TextField(
                controller: TextEditingController(text: this.title),
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                      vertical: pixel.setHeight(4.0, context)),
                  hintText: '搜索书名或作者',
                  prefixIcon: Icon(
                    Iconfont.sousuo,
                    size: pixel.setFontSize(24, context),
                    color: Color(0x993c3c3c),
                  ),
                  // contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Color(0x99ededed),
                ),
                style: TextStyle(fontSize: pixel.setFontSize(18.0, context)),
                onChanged: (value) {
                  this._input = value;
                },
                onSubmitted: (value) {
                  if (empty(value) && value != this.title) {
                    setState(() {
                      this.title = value;
                      print('搜索 ${this.title}');
                    });
                  }
                },
              ),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        Container(
            width: pixel.setWidth(115, context),
            // height: 40,
            // color: Colors.red,
            child: GestureDetector(
              child: Center(
                child: Text(
                  '搜索',
                  style: TextStyle(
                    fontSize: pixel.setFontSize(16, context),
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
            // height: pixel.setHeight(210, context),
            padding: EdgeInsets.fromLTRB(
                pixel.setWidth(20, context),
                pixel.setHeight(25, context),
                pixel.setWidth(20, context),
                pixel.setHeight(20, context)),
            // color: Colors.yellow,
            child: Row(
              children: <Widget>[
                Container(
                  height: pixel.setHeight(200, context),
                  width: pixel.setWidth(160, context),
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(pixel.setWidth(3, context)),
                      image: DecorationImage(
                        image: NetworkImage(value['imageUrl']),
                        fit: BoxFit.cover,
                      )),
                ),
                SizedBox(
                  width: pixel.setWidth(20, context),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: pixel.setHeight(5, context)),
                      Text(
                        "${value['title']}",
                        style: TextStyle(
                          fontSize: pixel.setFontSize(16, context),
                        ),
                      ),
                      SizedBox(height: pixel.setFontSize(5, context)),
                      Row(
                        children: <Widget>[
                          Text("${value['author']}",
                              style: TextStyle(
                                  fontSize: pixel.setFontSize(12, context),
                                  color: Color(0x997e7e7e))),
                          Row(
                            children: _getCategory(value['category']),
                          ),
                          // _getCategory(value['category']),
                        ],
                      ),
                      SizedBox(height: pixel.setHeight(5, context)),
                      Text(
                        "${value['sutitle']}",
                        style: TextStyle(
                            fontSize: pixel.setFontSize(14, context),
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
          margin:
              EdgeInsets.symmetric(horizontal: pixel.setWidth(5.0, context)),
          padding:
              EdgeInsets.symmetric(horizontal: pixel.setWidth(5.0, context)),
          decoration: BoxDecoration(
              border: Border.all(
                  width: pixel.setWidth(1, context), color: Config.color),
              borderRadius: BorderRadius.circular(2)),
          child: Text(
            value,
            style: TextStyle(
                color: Config.color,
                fontSize: pixel.setFontSize(10.0, context)),
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
