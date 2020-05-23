import 'package:fiction/res/categoryNameData.dart';
import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {
  List<List> boyStatusIndexList = List<List>(4);
  // List girlStatusIndexList = List<Object>();
  List<bool> boyStatusList = List<bool>();
  List<bool> girlStatusList = List<bool>();

  List boydata = categoryNameData[0]['category_list'];
  List girldata = categoryNameData[1]['category_list'];

  bool isSelect = false;
  List<int> selectIndexs = List<int>();
  CategoryProvider() {
    isSelect = false;

    List.generate(boydata.length, (index) => selectIndexs.add(0));

    // List.generate(boydata[0].length, (index) => boyStatusIndexList[0].add(isSelect));
    // List.generate(boydata[1].length, (index) => boyStatusIndexList[1].add(isSelect));
    // List.generate(boydata[2].length, (index) => boyStatusIndexList[2].add(isSelect));
    // List.generate(boydata[3].length, (index) => boyStatusIndexList[3].add(isSelect));
  }


  setBtnStatus(index, parentIndex) {
    if(selectIndexs[parentIndex] == index) return;
    int selectIndex = selectIndexs[parentIndex];

    boyStatusIndexList[parentIndex][selectIndex] = false;
    selectIndexs[parentIndex] = index;
    boyStatusIndexList[parentIndex][index] = true;
    print('=====================$index  $parentIndex $boyStatusIndexList');
    notifyListeners();
  }

}