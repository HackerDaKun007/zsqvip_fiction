/*
 * @author      HackerDaKun007 <hackerdakun007@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         搜索页面
*/
import 'package:fiction/app/pages/bookShelf/content.dart';
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

class _SearchState extends State<Search> with Common {
  PixelSize pixel = PixelSize();
  Path path = Path();

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
      appBar: _appber(),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
            pixel.setWidth(10, context),
            pixel.setHeight(20, context),
            pixel.setWidth(10, context),
            pixel.setHeight(10, context)),
        child: Stack(
          children: <Widget>[
            //主体内容
            ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    EveryoneTitle(
                      myButton: (text, isIcon) => _myButton(text, isIcon),
                    ),
                    SizedBox(
                      height: pixel.setWidth(20, context),
                    ),
                    Recent(
                      myButton: (text, isIcon) => _myButton(text, isIcon),
                    ),
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
                  if (empty(value)) {
                    _filterList(value);
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
                if (empty(_input)) {
                  _filterList(_input);
                }
              },
            )),
      ],
    );
  }

  //公共点击按钮点击事件
  Widget _myButton(String text, String isIcon) {
    _isIconValidata() {
      if (isIcon == "1") {
        return Padding(
          padding: EdgeInsets.fromLTRB(pixel.setWidth(3, context), 0, 0, 0),
          child: Icon(
            Iconfont.remen,
            size: pixel.setFontSize(16, context),
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
                fontSize: pixel.setFontSize(16, context),
              ),
            ),
            _isIconValidata(),
          ],
        ),
        padding: EdgeInsets.fromLTRB(
            pixel.setWidth(15, context),
            pixel.setHeight(10, context),
            pixel.setWidth(15, context),
            pixel.setHeight(10, context)),
        margin: EdgeInsets.fromLTRB(0, 0, 0, pixel.setHeight(15, context)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(pixel.setWidth(3, context)),
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
    Storage.getList(path.search['recen']).then((List value) {
      if (value != null) {
        if (inArray(value, text)) {
          value.remove(text);
        }
        value.add(text);
        Storage.setList(path.search['recen'], value);
      } else {
        List<String> arr = [];
        arr.add(text);
        Storage.setList(path.search['recen'], arr);
      }
      _getResult(text);
    });
  }
}
