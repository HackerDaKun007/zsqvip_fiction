/**
 * @author      dakun007 <dakun007@hotmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         搜索页面
*/
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fiction/widget/Pixelsize.dart';
import 'package:fiction/fonts/Iconfont.dart';

class Search extends StatefulWidget {
  Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> with PixelSize {
  @override
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
                decoration: InputDecoration(
                  icon: Icon(
                    Iconfont.sousuo,
                    size: getPixe(22, context),
                    color: Color(0x993c3c3c),
                  ),
                  hintText: '搜索书名或作者',
                  border: InputBorder.none,
                ),
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
                      fontSize: getPixe(15, context),
                    ),
                  ),
                ),
                onTap: () {},
              )),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(getPixe(10, context), getPixe(20, context),
            getPixe(10, context), getPixe(10, context)),
        child: Stack(
          children: <Widget>[
            //主体内容
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
              ],
            ),
            // SizedBox(height: getPixe(10, context)),
           
            
          ],
        ),
      ),
    );
  }

  //大家都在搜索标题
  Widget _getEveryoneTitle() {
    return 
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Text(
                '大家都在搜索',
                style: TextStyle(
                    fontSize: getPixe(16, context),
                    fontWeight: FontWeight.bold),
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
                  print('换一换');
                },
              ),
            )
          ],
    );
  }
  //大家都在搜索内容
  Widget _getEveryoneContent() {
    return Wrap(
      spacing: getPixe(10, context),
      // runSpacing: getPixe(5, context),
      alignment: WrapAlignment.start,
      // direction: Axis.vertical,
      children: <Widget>[
        this._myButton('你好', 0),
        this._myButton('你好', 0),
        this._myButton('你好', 1),
        this._myButton('你好', 0),
        this._myButton('你好2312312', 0),
      ],
    );
  }

  //最近搜索标题
  Widget _getRecentTitle() {
    return Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Text(
                '最近搜索',
                style: TextStyle(
                    fontSize: getPixe(16, context),
                    fontWeight: FontWeight.bold),
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
                  print('删除');
                },
              ),
            )
          ],
    );
  }

  //公共点击按钮点击事件
  Widget _myButton(String text, int isIcon) {
    _isIconValidata() {
      if (isIcon == 1) {
        return Padding(
          padding: EdgeInsets.fromLTRB(getPixe(3, context), 0, 0, 0),
          child: Icon(Iconfont.remen, size: getPixe(16, context),color: Colors.red,),
        );
      } else {
        return Text('');
      }
    }
    return  FlatButton(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(text, style: TextStyle(
            fontSize: getPixe(14, context),
          ),),
          _isIconValidata(),
        ],
      ),
      
      textColor: Colors.black,
      color: Color(0x99e2e2e2),
      onPressed: () {
        
      },
    );
  }


}



// class MyButton extends StatelessWidget {
//   final String text;
//   final int icon;
//   const MyButton (this.text, {Key key, this.icon}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return FlatButton(
//       child: Row(
//         children: <Widget>[
//           Text(this.text),
//           SizedBox(width: ,),
//         ],
//       ),
//       textColor: Colors.black,
//       color: Color(0x99e2e2e2),
//       onPressed: () {
        
//       },
//     );
//   }
// }
