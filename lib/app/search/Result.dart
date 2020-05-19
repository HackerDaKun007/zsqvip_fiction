import 'package:flutter/material.dart';
import 'package:fiction/public/public.dart';

import 'package:fiction/res/searchData.dart';


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
  //构造函数
  _ResultSearchState({this.arguments}) {
    this.title = this.arguments['title'];
    this._input = this.arguments['title'];
  }

  @override
  // void initState() {
  //   super.initState();
  //   print(arguments['sr']);
  // }

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
              child: TextField(
                controller: TextEditingController(
                  text: this.title,
                ),
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
              )),
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
        children: <Widget>[
          // SizedBox(height: getPixe(30, context)),
          InkWell(
            onTap: () {},
            child: Container(
              width: double.infinity,
              height: getPixe(140, context),
              color: Colors.yellow,
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    getPixe(10, context),
                    getPixe(25, context),
                    getPixe(10, context),
                    getPixe(10, context)),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: getPixe(115, context),
                      width: getPixe(85, context),
                       decoration: BoxDecoration(
                        borderRadius:BorderRadius.circular(getPixe(5, context)),
                        image: DecorationImage(
                          image: NetworkImage("https://manhua.qpic.cn/operation/0/13_10_58_4745d48330847218e1e16b8e43693844_1586746736596.jpg/0"),
                          fit: BoxFit.cover,
                        )
                      ),
                    ),
                    SizedBox(width: getPixe(10, context),),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: getPixe(5, context)),
                          Text('我是大神仙', style: TextStyle(
                            fontSize: getPixe(18, context),
                          ),),
                          SizedBox(height: getPixe(5, context)),
                          Text('盛世卡漫', style: TextStyle(
                            fontSize: getPixe(14, context),
                            color: Color(0x99e2e2e2)
                          )),
                          SizedBox(height: getPixe(5, context)),
                          Text('年仅七岁却超速生长的短命神童时江，为恢复正常生活，带着寄宿体内的某位大神仙闯入仙界，从此走上成为仙界大亨的传奇之路', style: TextStyle(
                            fontSize: getPixe(14, context),
                            color: Color(0x99d2d2d2)
                          ), maxLines: 2, overflow: TextOverflow.ellipsis,),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
