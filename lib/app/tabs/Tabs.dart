import 'package:fiction/app/tabs/tabs_icon.dart';
/**
 * @author      dakun007 <dakun007@hotmail.com>  YuriChen <pluto401zz@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         首页底部导航栏目
*/
import 'package:flutter/material.dart';

//导航栏目地址
import 'package:fiction/app/pages/Home.dart'; //书城
import 'package:fiction/app/pages/BookShelf.dart'; //书架
import 'package:fiction/app/pages/Category.dart'; //分类
import 'package:fiction/app/pages/My.dart'; //我的

//像素
import 'package:fiction/widget/PixelSize.dart';

class Tabs extends StatefulWidget{
  Tabs({Key key}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> with PixelSize{
  //控制选中时的数据
  int _currenIndex = 0;

  _TabsState ({index=0}) {
    this._currenIndex = index;
    
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
              icon: Icon(MyIcons.home, size: fontSize(20) ),
              activeIcon: Icon(MyIcons.home_active, size: fontSize(20) ),
              title: Text('书架', style: TextStyle(
                fontSize: fontSize(13)
              )),
            ),
            BottomNavigationBarItem(
              icon: Icon(MyIcons.book, size: fontSize(20) ),
              activeIcon: Icon(MyIcons.book, size: fontSize(20) ),
              title: Text('书城', style: TextStyle(
                fontSize: fontSize(13)
              )),
            ),
            BottomNavigationBarItem(
              icon: Icon(MyIcons.category, size: fontSize(20) ),
              activeIcon: Icon(MyIcons.category_active, size: fontSize(20) ),
              title: Text('分类', style: TextStyle(
                fontSize: fontSize(13)
              )),
            ),
            BottomNavigationBarItem(
              icon: Icon(MyIcons.mine, size: fontSize(20) ),
              activeIcon: Icon(MyIcons.mine_active, size: fontSize(20) ),
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
