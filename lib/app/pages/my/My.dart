/*
 * @author      Yuri Chen <pluto401zz@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         个人页面
*/
import 'package:flutter/material.dart';

import 'package:fiction/public/public.dart';
import 'package:fiction/app/readTime/readTime.dart'; //阅读时间

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff7f7f7),
      body: SingleChildScrollView(child: MineBody()),
    );
  }
}

class MineBody extends StatefulWidget {
  @override
  _MineBodyState createState() => _MineBodyState();
}

class _MineBodyState extends State<MineBody> {
  double rpx;

  @override
  Widget build(BuildContext context) {
    rpx = MediaQuery.of(context).size.width / 750;
    return Container(
        child: Column(
      children: <Widget>[
        _topWidget(),
        Column(
          children: <Widget>[_serviceListWiget(), _helpListWidget()],
        )
      ],
    ));
  }

  /// 顶部内容
  Widget _topWidget() {
    return Container(
      height: 400 * rpx,
      width: 750 * rpx,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'images/bg.jpg',
              ),
              fit: BoxFit.cover)),
      padding: MediaQuery.of(context).padding,
      child: Column(
        children: <Widget>[
          Container(
            height: 180 * rpx,
            margin: EdgeInsets.only(top: 20 * rpx),
            padding: EdgeInsets.symmetric(horizontal: 40 * rpx),
            child: Row(
              children: <Widget>[
                Material(
                    color: Colors.transparent,
                    elevation: 10,
                    shape: CircleBorder(),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(
                      'images/ava1.png',
                      width: 150 * rpx,
                      height: 150 * rpx,
                      fit: BoxFit.fill,
                    )),
                SizedBox(
                  width: 50 * rpx,
                ),
                InkWell(
                  onTap: () {
                    print('=======Login button pressed========');
                  },
                  child: Text(
                    '点击登录',
                    style: TextStyle(
                        fontSize: 38 * rpx, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 30 * rpx,
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _getHeaderRowListItem(title: '积分', countNum: 0, isNav: true, callback: (){
                  Navigator.pushNamed(context, '/booklist');
                }),
                // _getHeaderRowListItem(title: '卡券', countNum: 5, isNav: true),
                _getHeaderRowListItem(
                  title: '今日已读(分钟)',
                  // countNum: Path.minute,
                  countNum: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getHeaderRowListItem(
      {String title, int countNum, bool isNav = false, Function callback}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          '$countNum',
          style: TextStyle(fontSize: 44 * rpx, fontWeight: FontWeight.bold),
        ),
        InkWell(
          onTap: callback,
          child: Row(
            children: <Widget>[
              Text(
                title,
                style: TextStyle(color: Colors.grey[600], fontSize: 24 * rpx),
              ),
              isNav
                  ? Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                      size: 36 * rpx,
                    )
                  : SizedBox(
                      width: 0,
                    )
            ],
          ),
        )
      ],
    );
  }

  Widget _serviceListWiget() {
    return Container(
      margin: EdgeInsets.only(top: 20 * rpx),
      width: 750 * rpx,
      height: 460 * rpx,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _getListItem(title: '福利中心', icon: Icons.redeem, subtitle: '抽大奖'),
          _getListItem(title: '积分商城', icon: Icons.store, subtitle: '兑换好礼'),
          _getListItem(
              title: '阅读兴趣', icon: Icons.favorite_border, subtitle: '精选推荐好书'),
          _getListItem(
            title: '阅读记录',
            icon: Icons.access_time,
          ),
        ],
      ),
    );
  }

  Widget _helpListWidget() {
    return Container(
      margin: EdgeInsets.only(top: 20 * rpx),
      width: 750 * rpx,
      height: 230 * rpx,
      child: Column(
        children: <Widget>[
          _getListItem(title: '意见反馈', icon: Icons.error_outline),
          _getListItem(title: '设置', icon: Icons.settings, callback: () {
            Navigator.pushNamed(context, '/settings');
          }),
        ],
      ),
    );
  }

  Widget _getListItem(
      {IconData icon, @required String title, String subtitle, Function callback}) {
    return InkWell(
      onTap: callback,
      child: Ink(
        height: 115 * rpx,
        width: 750 * rpx,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20 * rpx),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  icon,
                  color: Colors.black,
                ),
                SizedBox(width: 20 * rpx),
                Text(
                  title,
                  style: TextStyle(fontSize: 28 * rpx),
                ),
              ],
            ),
            Row(
                  children: <Widget>[
                    subtitle != null
                        ? Text(subtitle,
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 24 * rpx))
                        : SizedBox(width: 0),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                      size: 38 * rpx,
                    )
                  ],
                )
          ],
        ),
      )
    );
  }

}
