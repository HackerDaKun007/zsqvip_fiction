/*
 * @author      HackerDaKun007 <hackerdakun007@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         搜索页面
*/
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:fiction/public/public.dart';
import 'package:fiction/public/utils/shared.dart';

import 'package:fiction/app/ad/footerAd.dart'; //广告组件
import 'child/everyoneTitle.dart'; //大家都在搜索
import 'child/recent.dart'; //最近搜索

import 'package:fiction/public/widget/internet.dart';

// import 'package:shared_preferences/shared_preferences.dart';

class Search extends StatefulWidget {
  Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> with PixelSize, Common {

  //搜索框记本
  String _input = '';

  @override

  Widget build(BuildContext context) {

    return Internet(_init(), true);
  }

  //主体内容
  Widget _init() {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  if (empty(_input)) {
                    _filterList(_input);
                  }
                },
              )),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(getPixe(10, context), getPixe(20, context),
            getPixe(10, context), getPixe(10, context)),
        child: Stack(
          children: <Widget>[
            //主体内容
            ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    EveryoneTitle(myButton: (text, isIcon) => _myButton(text, isIcon),),
                    Recent(myButton: (text, isIcon) => _myButton(text, isIcon),),
                  ],
                ),
              ],
            ),

            //  广告位置
            FooterAd(),
          ],
        ),
      ),
    );
  }
  

  //公共点击按钮点击事件
  Widget _myButton(String text, String isIcon) {
    _isIconValidata() {
      if (isIcon == "1") {
        return Padding(
          padding: EdgeInsets.fromLTRB(getPixe(3, context), 0, 0, 0),
          child: Icon(
            Iconfont.remen,
            size: getPixe(16, context),
            color: Colors.red,
          ),
        );
      } else {
        return Text('');
      }
    }
    return GestureDetector(
      child: Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              text,
              style: TextStyle(
                fontSize: getPixe(14, context),
              ),
            ),
            _isIconValidata(),
          ],
        ),
        padding: EdgeInsets.fromLTRB(getPixe(10, context), getPixe(5, context),
            getPixe(10, context), getPixe(5, context)),
        margin: EdgeInsets.fromLTRB(0, 0, 0, getPixe(10, context)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(getPixe(3, context)),
          color: Color(0x99e2e2e2),
        ),
      ),
      onTap: () {
        _filterList(text);
      },
    );
  }

  //跳转搜索结果
  void _getResult(text) {
    if (empty(text)) {
      Navigator.pushNamed(context, '/result', arguments: {'title': text});
    }
  }

  //点击按钮过滤数据事件
  void _filterList(text) {
    Storage.getList(Path.path['recen']).then((List value) {
      if (value != null) {
        if (inArray(value, text)) {
          value.remove(text);
        }
        value.add(text);
        Storage.setList(Path.path['recen'], value);
      } else {
        List<String> arr = [];
        arr.add(text);
        Storage.setList(Path.path['recen'], arr);
      }
      _getResult(text);
    });
  }

}


