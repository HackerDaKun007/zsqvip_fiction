/**
 * @author      HackerDaKun007 <hackerdakun007@gmail.com> 
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         首页底部导航栏目
*/
import 'package:flutter/material.dart';
import 'package:fiction/public/public.dart';

//导航栏目地址
import 'package:fiction/app/pages/home/home.dart'; //书城
import 'package:fiction/app/pages/bookshelf/bookshelf.dart'; //书架
import 'package:fiction/app/pages/category/category.dart'; //分类
import 'package:fiction/app/pages/my/my.dart'; //我的


class Tabs extends StatefulWidget{
  // Map arguments;
  Tabs({Key key}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> with PixelSize{
  //控制选中时的数据
  int _currenIndex = 0;


  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: this._currenIndex,
        //切换底部导航栏数组页面
        children: [
          BookShelfPage(getCurrenIndex: (number) => _getCurren(number) ),
          HomePage(getCurrenIndex: (number) => _getCurren(number)),
          CategoryPage(),
          MyPage(),
        ],
      ),
      //定义导航组件
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
           type: BottomNavigationBarType.fixed, //未选中显示字体
          fixedColor: Config.color,
          unselectedItemColor:Colors.grey,
          selectedFontSize: 12.0,
          currentIndex: this._currenIndex,
          onTap: (int index) {
            _getCurren(index);
          },
          //创建栏目
          items: [
            BottomNavigationBarItem(
              icon: Icon(Iconfont.book, size: getPixe(20, context) ),
              activeIcon: Icon(Iconfont.book_active, size: getPixe(20, context) ),
              title: Text('书架', style: TextStyle(
                fontSize: getPixe(13, context)
              )),
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconfont.home, size: getPixe(20, context) ),
              activeIcon: Icon(Iconfont.home_active, size: getPixe(20, context) ),
              title: Text('书城', style: TextStyle(
                fontSize: getPixe(13, context)
              )),
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconfont.category, size: getPixe(20, context) ),
              activeIcon: Icon(Iconfont.category_active, size: getPixe(20, context) ),
              title: Text('分类', style: TextStyle(
                fontSize: getPixe(13, context)
              )),
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconfont.mine, size: getPixe(20, context) ),
              activeIcon: Icon(Iconfont.mine_active, size: getPixe(20, context) ),
              title: Text('我的', style: TextStyle(
                fontSize: getPixe(13, context)
              ),),
            ),
          ],

        ),
      ),
    );
  }


  //修改切换状态数字
  void _getCurren(int number) {
    setState(() {
      // Path.minute += 1;
      this._currenIndex = number;
    });
  }

}