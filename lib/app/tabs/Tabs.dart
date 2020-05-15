/**
 * @author      dakun007 <dakun007@hotmail.com>  Yuri Chen <pluto401zz@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         首页底部导航栏目
*/
import 'package:flutter/material.dart';
import 'package:fiction/config/Config.dart';
import 'package:fiction/fonts/Iconfont.dart';

//导航栏目地址
import 'package:fiction/app/pages/Home.dart'; //书城
import 'package:fiction/app/pages/BookShelf.dart'; //书架
import 'package:fiction/app/pages/Category.dart'; //分类
import 'package:fiction/app/pages/My.dart'; //我的

//像素
import 'package:fiction/widget/PixelSize.dart';
class Tabs extends StatefulWidget{
  Map arguments;
  Tabs({Key key, this.arguments}) : super(key: key);

  @override
  _TabsState createState() => _TabsState(arguments: this.arguments);
}

class _TabsState extends State<Tabs> with PixelSize{
  //控制选中时的数据
  int _currenIndex = 0;
  Map arguments;
  _TabsState ({this.arguments}) {
    this._currenIndex = arguments != null ? this.arguments['index'] : 0;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      // appBar: HomeTopPage(),
      body: IndexedStack(
        index: this._currenIndex,
        children: this._pageList,
      ),
      //定义导航组件
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
           type: BottomNavigationBarType.fixed, //未选中显示字体
          fixedColor: Colors.blue[400],
          unselectedItemColor:Colors.grey,
          selectedFontSize: 12.0,
          currentIndex: this._currenIndex,
          onTap: (int index) {
            setState(() {
              minute += 1;
              this._currenIndex = index;
            });
          },
          //创建栏目
          items: [
            BottomNavigationBarItem(
              icon: Icon(Iconfont.book, size: fontSize(20) ),
              activeIcon: Icon(Iconfont.book_active, size: fontSize(20) ),
              title: Text('书架', style: TextStyle(
                fontSize: fontSize(13)
              )),
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconfont.home, size: fontSize(20) ),
              activeIcon: Icon(Iconfont.home_active, size: fontSize(20) ),
              title: Text('书城', style: TextStyle(
                fontSize: fontSize(13)
              )),
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconfont.category, size: fontSize(20) ),
              activeIcon: Icon(Iconfont.category_active, size: fontSize(20) ),
              title: Text('分类', style: TextStyle(
                fontSize: fontSize(13)
              )),
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconfont.mine, size: fontSize(20) ),
              activeIcon: Icon(Iconfont.mine_active, size: fontSize(20) ),
              title: Text('我的', style: TextStyle(
                fontSize: fontSize(13)
              ),),
            ),
          ],

        ),
      ),
    );
  }

  //切换底部导航栏数组页面
  final List<Widget> _pageList = [
    BookShelfPage(),
    HomePage(),
    CategoryPage(),
    MyPage(),
  ];


}
