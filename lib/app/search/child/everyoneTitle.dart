/*
 * @author      HackerDaKun007 <hackerdakun007@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         搜索页面 - 大家都在搜索
*/

import "package:flutter/material.dart";
import 'dart:math';

import 'package:fiction/public/public.dart';
import 'package:fiction/res/searchData.dart';
// import 'package:fiction/public/utils/shared.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EveryoneTitle extends StatefulWidget {
  final myButton;
  EveryoneTitle({Key key, this.myButton}) : super(key: key);

  @override
  _EveryoneTitleState createState() => _EveryoneTitleState();
}

class _EveryoneTitleState extends State<EveryoneTitle> with PixelSize {

  static List _listData = []; //保存网络请求下来数据

  //new随机类
  var _random = Random();
  int _randomLength = 0; //随机大家都搜索长度
  List<Widget> _list = []; //大家都搜索保留数据
  List<String> _listName = []; //大家都搜索保留数据-名称
  List<String> _listRen = []; //大家都搜索保留数据-热门

  //是否请求成功
  bool _request = false;

  @override
  //初始化数据
  void initState() {
    super.initState();
    if(_listData.length == 0) {
      _listData = listData;
    }
    _getDataList();
  }

  //初始化获取本地数据
  _getDataList() async {
    SharedPreferences data = await SharedPreferences.getInstance();
    var listName = data.getStringList(Path.path['everyoneUser']);
    var listRen = data.getStringList(Path.path['everyoneRen']);
    var randomLength = data.getInt(Path.path['everyoneCount']);

    if(listName == null || listRen == null || randomLength == null ) {
      _updateData();
    } else {
        _randomLength = randomLength;
        _listName = listName;
        _listRen = listRen;
        setState(() {
          _request = true;
        });
    }

    
  }

  void _updateData() async{
    _listData.shuffle();
    _listName = [];
    _listRen = [];
    _randomLength = 0;
    _randomLength = _random.nextInt(_listData.length);
    if (_randomLength == 0) {
        _randomLength = _random.nextInt(_listData.length);
    }
    for (int i = 0; i < _randomLength; i++) {
      _listName.add(_listData[i]['title']);
      _listRen.add(_listData[i]['renme']);
    }
    SharedPreferences data = await SharedPreferences.getInstance();
    data.setStringList(Path.path['everyoneUser'], _listName);
    data.setStringList(Path.path['everyoneRen'], _listRen);
    data.setInt(Path.path['everyoneCount'], _randomLength);
    setState(() {
      _request = true;
    });
  }

  Widget build(BuildContext context) {
    // print(_randomLength);
    return _request ? Column(
      children: <Widget>[
        this._getEveryoneTitle(),
        SizedBox(height: getPixe(10, context)),
        this._getEveryoneContent(),
      ],
    ) : Text('');
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
              _updateData();
            },
          ),
        )
      ],
    );
  }

  //大家都在搜索内容
  Widget _getEveryoneContent() {
    _list = [];
    for (int i = 0; i < _randomLength; i++) {
      _list.add(widget.myButton(_listName[i], _listRen[i]));
    }
    return Container(
      width: double.infinity,
      child: Wrap(
        spacing: getPixe(10, context),
        alignment: WrapAlignment.start,
        children: _list,
      ),
    );
  }
}