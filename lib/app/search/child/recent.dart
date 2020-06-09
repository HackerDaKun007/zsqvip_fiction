
/*
 * @author      HackerDaKun007 <hackerdakun007@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         搜索页面 - 最近搜索
*/
import "package:flutter/material.dart";

import 'package:fiction/public/utils/shared.dart';
import 'package:fiction/public/public.dart';
class Recent extends StatefulWidget {
  final myButton;
  Recent({Key key, this.myButton}) : super(key: key);

  @override
  _RecentState createState() => _RecentState();
}

class _RecentState extends State<Recent> {

  PixelSize pixel = PixelSize();
  PathName path = PathName();

  //判断是否删除搜索记录, true不删除，false删除
  List<String> recen = []; //最近搜索记录

  //是否请求成功
  bool _request = false;

  @override
  //初始化数据
  void initState() {
    super.initState();
  }
  Widget build(BuildContext context) {
    Storage.getList(path.search['recen']).then((value) {
      if (value != null) {
        recen = value;
      }
      setState(() {
        _request = true;
      });
    });
    return _request ? Column(
      children: <Widget>[
        this._getRecentTitle(),
        SizedBox(height: pixel.setHeight(20, context)),
        this._getRecentContent(),
      ],
    ) : Text('');
  }


  //最近搜索标题
  Widget _getRecentTitle() {
    if (recen.length > 0) {
      return Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Text(
              '最近搜索',
              style: TextStyle(
                  fontSize: pixel.setFontSize(18, context), fontWeight: FontWeight.bold),
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
                      fontSize: pixel.setFontSize(14, context),
                      color: Color(0x993e3e3e),
                    ),
                  ),
                  SizedBox(
                    width: pixel.setWidth(2, context),
                  ),
                  Icon(
                    Iconfont.shanchu1,
                    size: pixel.setFontSize(13, context),
                    color: Color(0x993e3e3e),
                  ),
                ],
              ),
              onTap: () {
                setState(() {
                  //删除搜索记录
                  recen = [];
                  Storage.remove(path.search['recen']); //删除本地
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
    if (recen.length > 0) {
      List<Widget> rencentList = new List();
      //倒序输出
      for (int i = (recen.length - 1); i >= 0; i--) {
        rencentList.add(widget.myButton(recen[i], "0"));
      }
      return Container(
        width: double.infinity,
        child: Wrap(
          spacing: pixel.setWidth(10, context),
          alignment: WrapAlignment.start,
          children: rencentList,
        ),
      );
    } else {
      return Text('');
    }
  }
}