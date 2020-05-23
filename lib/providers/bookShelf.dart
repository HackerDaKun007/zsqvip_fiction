/*
 * @author      HackerDaKun007 <hackerdakun007@gmail.com> 
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         书架页面 - 状态管理
*/
import 'dart:convert' as JSON;
import 'package:fiction/public/configs/config.dart';
import 'package:flutter/material.dart';
import 'package:fiction/res/listData.dart';
class BookShelfProviders with ChangeNotifier{

  List<Map> _listData = [{
      "title": '',
      "author": '',
      "imageUrl": 'images/jia.png',
      "system": 1,
    }]; //数据

  //编辑书架数据
  List<Map> _data = []; //数据
  List _dataAction = []; //保存选中数据坐标key
  List _dataActionData = []; //备份存储保存选中数据坐标key
  List<Map> _dataColor = []; //颜色
  List<Map> _dataColorBack = []; //备份未选中颜色 - 取消
  List<Map> _dataColorBackAction = []; //备份选中颜色 - 全部
  List<Map> _adData = [];      //广告
  Color _deleteColos = Colors.blue[100]; //删除默认颜色


  BookShelfProviders() {
    this._listData.addAll(listData);
    initEdit();
  }

  //编辑书架数据
  initEdit() {
    this._listData.forEach((value) {
      if (value['ad'] == 0 && value['system'] == null) {
        this._data.add(value);
        this._dataActionData.add(value['id']);
        //存储颜色
        this._dataColor.add({'id': value['id'], 'color': 0xff9e9e9e});
        this
            ._dataColorBack
            .add({'id': value['id'], 'color': 0xff9e9e9e});
        this
            ._dataColorBackAction
            .add({'id': value['id'], 'color': 0xff42a5f5});
      }
      //广告
      if (value['ad'] == 1) {
        this._adData.add(value);
      }
    });
  }

  List get data => this._listData; //数据

  List get editData => this._data;
  Color get deleteColos => this._deleteColos;
  List get dataColor => this._dataColor;

  //修改删除颜色
  void updateDelteColors() {
    if (this._dataAction.length > 0) {
      this._deleteColos = Config.color;
    } else {
      this._deleteColos = Colors.blue[100];
    }
    notifyListeners();
  }

  //编辑全选
  void editSelectAll() {
    this._dataColor = JSON.jsonDecode(JSON.jsonEncode(this._dataColorBackAction));
    this._dataAction = JSON.jsonDecode(JSON.jsonEncode(this._dataActionData));
    this.updateDelteColors();
  }
  //编辑取消
  void editCancel() {
    this._dataColor = JSON.jsonDecode(JSON.jsonEncode(this._dataColorBack));
    this._dataAction = [];
    this.updateDelteColors();
    notifyListeners();
  }

  //编辑单个选中
  void editAction(int index) {
    if (this._dataColor[index]['color'] == 0xff42a5f5) {
      //选中状态
      this._dataColor[index]['color'] = 0xff9e9e9e;
      this._dataAction.remove(this._data[index]['id']);
    } else {
      //未选中状态
      this._dataColor[index]['color'] = 0xff42a5f5;
      this._dataAction.add(this._data[index]['id']);
    }
    this.updateDelteColors();
  }

  //编辑删除
  void editDel() {
    if (this._dataAction.length == this._data.length) {
      this._listData = [];
      this._data = [];
    } else {
      this._dataAction.forEach((value) {
        this._listData.removeWhere((v) => v['id'] == value);
        this._data.removeWhere((v) => v['id'] == value);
        this
            ._dataColor
            .removeWhere((v) => v['id'] == value);
        this
            ._dataColorBack
            .removeWhere((v) => v['id'] == value);
        this
            ._dataColorBackAction
            .removeWhere((v) => v['id'] == value);
      });
    }
    //删除广告
    if (this._data.length > 0) {
      //判断广告数量 - 10 = 2， 5 = 1
      int adNum = ((this._data.length) / 5).floor();
      int number = this._adData.length;
      this._adData.forEach((value) {
        if (number > adNum || adNum == 0) {
          _listData
              .removeWhere((v) => v['id'] == value['id']);
          number--;
        }
      });
    }
    this._dataAction = [];
    this.updateDelteColors();
  }


  //添加产品信息
  addData(Map value) {
    // this._listData.removeAt((this._listData.length - 1));
    this._listData.add(value);
    notifyListeners();
  }



  //数据内容修改更新
  displayUpdate(int key) {
    this._listData[key]['click'] = 1;
    notifyListeners();
  }

}