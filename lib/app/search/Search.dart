/**
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
import 'dart:math';

import 'package:fiction/public/public.dart';
import 'package:fiction/res/searchData.dart';



class Search extends StatefulWidget {
  Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> with PixelSize, Common {
  //判断是否关闭广告, true开启广告，false关闭广告
  bool _isAd = true;
  //判断是否删除搜索记录, true不删除，false删除
  bool _isReccent = true;

  //new随机类
  var _random = new Random();
  int _randomLength = 0; //随机大家都搜索长度
  List<Widget> _list = new List(); //大家都搜索保留数据

  //搜索框记本
  String _input = '';

  @override

  //初始化数据
  void initState() {
    super.initState();
    //大家都搜索打乱数据
    listData.shuffle();
    //随机大家都搜索长度
    this._randomLength = _random.nextInt(listData.length);
    if (this._randomLength == 0) {
      this._randomLength = _random.nextInt(listData.length);
    }
   
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Iconfont.zuo,
            size: getPixe(30, context),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Container(
          // color: Colors.yellow,
          width: double.infinity,
          height: getPixe(42, context),
          child: Padding(
              padding: EdgeInsets.fromLTRB(
                  getPixe(10, context), 0, getPixe(10, context), 0),
              child: Center(
                child: TextField(
                decoration: InputDecoration(
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
              width: getPixe(50, context),
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
                  if (empty(this._input)) {
                    // setState(() {
                      if (inArray(Path.recen, this._input)) {
                        Path.recen.remove(this._input);
                      }
                      Path.recen.add(this._input);
                      this._isReccent = true;
                      _getResult(this._input);
                    // });
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
                    //大家都在搜索标题
                    this._getEveryoneTitle(),
                    SizedBox(height: getPixe(10, context)),
                    //大家都在搜索内容
                    this._getEveryoneContent(),
                    //最近搜索
                    SizedBox(height: getPixe(10, context)),
                    this._getRecentTitle(),
                    SizedBox(height: getPixe(10, context)),
                    //搜索记录
                    this._getRecentContent(),
                  ],
                ),
              ],
            ),

            //  广告位置
            _getAd(),
          ],
        ),
      ),
    );
  }

  //大家都在搜索标题
  Widget _getEveryoneTitle() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Text(
            '大家都在搜索',
            style: TextStyle(
                fontSize: getPixe(16, context), fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          // width: getPixe(50, context),
          child: GestureDetector(
            child: Row(
              children: <Widget>[
                Text(
                  '换一换',
                  style: TextStyle(
                    fontSize: getPixe(14, context),
                    color: Color(0x993e3e3e),
                  ),
                ),
                SizedBox(
                  width: getPixe(2, context),
                ),
                Icon(
                  Icons.loop,
                  size: getPixe(14, context),
                  color: Color(0x993e3e3e),
                ),
              ],
            ),
            onTap: () {
              setState(() {
                listData.shuffle();
                //随机长度
                this._randomLength = _random.nextInt(listData.length);
                if (this._randomLength == 0) {
                  //如果大家都搜索长度为0重新请求一下
                  this._randomLength = _random.nextInt(listData.length);
                }
              });
            },
          ),
        )
      ],
    );
  }

  //大家都在搜索内容
  Widget _getEveryoneContent() {
    this._list = [];
    for (int i = 0; i < this._randomLength; i++) {
      this
          ._list
          .add(this._myButton(listData[i]['title'], listData[i]['renme']));
    }
    return Container(
      width: double.infinity,
      child: Wrap(
        spacing: getPixe(10, context),
        alignment: WrapAlignment.start,
        children: this._list,
      ),
    );
  }

  //最近搜索标题
  Widget _getRecentTitle() {
    if (this._isReccent && Path.recen.length > 0) {
      return Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Text(
              '最近搜索',
              style: TextStyle(
                  fontSize: getPixe(16, context), fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            // width: getPixe(50, context),
            child: GestureDetector(
              child: Row(
                children: <Widget>[
                  Text(
                    '删除',
                    style: TextStyle(
                      fontSize: getPixe(14, context),
                      color: Color(0x993e3e3e),
                    ),
                  ),
                  SizedBox(
                    width: getPixe(2, context),
                  ),
                  Icon(
                    Iconfont.shanchu1,
                    size: getPixe(13, context),
                    color: Color(0x993e3e3e),
                  ),
                ],
              ),
              onTap: () {
                setState(() {
                  //删除搜索记录
                  this._isReccent = false;
                  Path.recen = [];
                });
              },
            ),
          )
        ],
      );
    } else {
      return Text('');
    }
  }

  //最近搜索标题内容
  Widget _getRecentContent() {
    if (this._isReccent && Path.recen.length > 0) {
      List<Widget> rencentList = new List();
      //倒序输出
      for (int i = (Path.recen.length - 1); i >= 0; i--) {
        rencentList.add(this._myButton(Path.recen[i], 0));
      }
      return Container(
        width: double.infinity,
        child: Wrap(
          spacing: getPixe(10, context),
          alignment: WrapAlignment.start,
          children: rencentList,
        ),
      );
    } else {
      return Text('');
    }
  }

  //公共点击按钮点击事件
  Widget _myButton(String text, int isIcon) {
    _isIconValidata() {
      if (isIcon == 1) {
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

    return FlatButton(
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
      textColor: Colors.black,
      color: Color(0x99e2e2e2),
      onPressed: () {
        // setState(() {
          if (inArray(Path.recen, text)) {
            Path.recen.remove(text);
          }
          Path.recen.add(text);
          this._isReccent = true;
          _getResult(text);
        // });
      },
    );
  }

  //跳转搜索结果
  void _getResult(text) {
    if (empty(text)) {
      Navigator.pushNamed(context, '/result', arguments: {'title':text});
    }
  }
  //广告位置
  Widget _getAd() {
    if (this._isAd) {
      return Positioned(
        bottom: getPixe(15, context),
        left: getPixe(15, context),
        right: getPixe(15, context),
        child: Container(
          height: getPixe(150, context),
          width: double.infinity,
          child: Stack(
            children: <Widget>[
              GestureDetector(
                child: Center(
                  child: Image.network(
                    'https://manhua.qpic.cn/operation/0/16_00_10_88908a9e29068d08f1d7620fc2373cda_1589559004105.jpg/0',
                    fit: BoxFit.cover,
                  ),
                ),
                onTap: () {
                  print('跳转广告');
                },
              ),
              //关闭
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  // color: Colors.grey,
                  child: GestureDetector(
                    child: Icon(
                      Iconfont.shanchu,
                      color: Colors.black,
                      size: getPixe(25, context),
                    ),
                    onTap: () {
                      //关闭广告
                      setState(() {
                        this._isAd = false;
                      });
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  color: Color(0x99e2e2e2),
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          getPixe(5, context),
                          getPixe(2, context),
                          getPixe(5, context),
                          getPixe(2, context)),
                      child: Text(
                        '广告',
                        style: TextStyle(
                          fontSize: getPixe(12, context),
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Text('');
    }
  }
}
