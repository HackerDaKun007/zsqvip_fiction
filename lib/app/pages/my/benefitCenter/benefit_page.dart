import 'package:dio/dio.dart';
import 'package:fiction/providers/tabIndexProvider.dart';
import 'package:flutter/material.dart';

import 'package:fiction/public/public.dart';
import 'package:provider/provider.dart';

class BenefitPage extends StatefulWidget {
  @override
  _BenefitPageState createState() => _BenefitPageState();
}

class _BenefitPageState extends State<BenefitPage> with PixelSize {
  bool isLogin; // 是否登录
  bool isTodayRegister; // 今日是否签到
  TabIndexProvider tabProvider;
  @override
  void initState() {
    super.initState();
    isLogin = true;
    isTodayRegister = false;
  }

  /// 转到登录页
  void toLoginPage() {
    Navigator.pushNamed(context, '/login');
  }

  /// 转到书架页
  void toBookShelfPage() {
    Navigator.pop(context);
    tabProvider.changeCurrentIndex(0);
  }

  /// 转到积分商城页
  void toStorePage() {
    Navigator.pushNamed(context, '/store');
  }

  /// 头部
  Widget _buildHeader() {
    return Container(
        height: getPixe(375, context),
        width: getWidth(context),
        child: Stack(children: [
          Container(
            width: getWidth(context),
            height: getPixe(200, context),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/welfare.jpg'),
                    fit: BoxFit.cover)),
            child: Container(
              padding: EdgeInsets.only(top: getPixe(35, context)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: isLogin
                    ? <Widget>[
                        Text(
                          '当前积分',
                          style: TextStyle(
                              fontSize: getPixe(12, context),
                              color: Colors.white54),
                        ),
                        SizedBox(
                          height: getPixe(10, context),
                        ),
                        Text(
                          '50',
                          style: TextStyle(
                            fontSize: getPixe(45, context),
                            color: Colors.white,
                          ),
                        )
                      ]
                    : <Widget>[
                        Text(
                          '登录可领取积分、兑换大奖',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: getPixe(12, context)),
                        ),
                        SizedBox(
                          height: getPixe(15, context),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: getPixe(35, context),
                                  vertical: getPixe(6, context)),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        Colors.blue[600],
                                        Colors.blue[300]
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text(
                                '立即登录',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: getPixe(14, context)),
                              )),
                        )
                      ],
              ),
            ),
          ),
          Positioned(top: getPixe(130, context), child: _buildStoreSummary()),
        ]));
  }

  /// 积分商城展示
  Widget _buildStoreSummary() {
    double mainWidth = getWidth(context) - getPixe(20, context);
    double childWidth = getPixe((mainWidth - 80) / 3, context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: getPixe(10, context)),
      padding: EdgeInsets.all(getPixe(15, context)),
      width: mainWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
              colors: [Color(0xffE3B967), Color(0xffF8E1AA)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '积分商城',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: getPixe(18, context)),
              ),
              InkWell(
                onTap: () {},
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      '查看更多',
                      style: TextStyle(
                          fontSize: getPixe(13, context),
                          color: Color(0xffdaa520)),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Color(0xffdaa520),
                      size: getPixe(20, context),
                    )
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
                getPixe(10, context),
                getPixe(15, context),
                getPixe(10, context),
                getPixe(10, context)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _getStoreCard(
                    childWidth, 'images/welfare_integral_1.png', 'iPhone X'),
                _getStoreCard(
                    childWidth, 'images/welfare_integral_2.png', 'iPhone X 碎片'),
                _getStoreCard(
                    childWidth, 'images/welfare_integral_3.png', '免广告'),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// 主按钮
  Widget _buildButton({String title, VoidCallback onTabHandler}) {
    return InkWell(
      onTap: isLogin ? onTabHandler : toLoginPage,
      child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: getPixe(15, context), vertical: getPixe(5, context)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(getPixe(20, context)),
              gradient: LinearGradient(
                  colors: [Color(0xffE3B967), Color(0xffF8E1AA)],
                  end: Alignment.centerLeft,
                  begin: Alignment.centerRight)),
          child: Text(
            title,
            style: TextStyle(
                fontSize: getPixe(14, context), fontWeight: FontWeight.w600),
          )),
    );
  }
  /// 
  Widget _getStoreCard(childWidth, imgUrl, productName) {
    return Container(
      height: getPixe(160, context),
      width: childWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: childWidth,
            height: childWidth,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: Center(
              child: Image.asset(
                imgUrl,
                width: childWidth - 30,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Text(
            productName,
            style: TextStyle(fontSize: getPixe(12, context)),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: getPixe(20, context),
                vertical: getPixe(5, context)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    offset: Offset(1, 3),
                    blurRadius: 2,
                    color: Color(0xccff7043)),
                BoxShadow(
                    offset: Offset(1, 2),
                    blurRadius: 0,
                    color: Color(0x22ffffff)),
              ],
              gradient: LinearGradient(
                  colors: [Colors.deepOrange, Colors.orange[700]],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight),
            ),
            child: Text('立即兑换',
                style: TextStyle(
                    fontSize: getPixe(13, context), color: Colors.white)),
          )
        ],
      ),
    );
  }

  /// 日常福利
  Widget _buildDailyBenefit() {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: getPixe(10, context), vertical: getPixe(10, context)),
      padding: EdgeInsets.all(getPixe(10, context)),
      width: getWidth(context),
      decoration: BoxDecoration(
        color: Color(0xfffffffe),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                left: getPixe(10, context), bottom: getPixe(10, context)),
            child: Text(
              '日常福利',
              style: TextStyle(
                  color: Color(0xffE3B967),
                  fontWeight: FontWeight.w500,
                  fontSize: getPixe(18, context)),
            ),
          ),
          Container(
            height: getPixe(70, context),
            padding: EdgeInsets.all(getPixe(10, context)),
            margin: EdgeInsets.only(bottom: getPixe(15, context)),
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/bg.jpg'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(6)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '每日签到',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: getPixe(17, context)),
                    ),
                    SizedBox(
                      height: getPixe(5, context),
                    ),
                    Text(
                      '连续签到赚更多积分',
                      style: TextStyle(
                          color: Colors.black45,
                          fontSize: getPixe(13, context)),
                    )
                  ],
                ),
                InkWell(
                    onTap: () {
                      showDialog(context: context, child: Dialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        child: Container(
                          height: getPixe(380, context),
                          padding: EdgeInsets.all(getPixe(10, context)),
                          child: Stack(
                            children: <Widget>[
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: getPixe(10, context), horizontal: getPixe(10, context)),
                                  child: Column(
                                    children: <Widget>[
                                      Column(
                                        children: [
                                          Text('已累计签到2天', style: TextStyle(fontSize: getPixe(22, context)),),
                                          Text('明天签到可领50积分', style: TextStyle(fontSize: getPixe(12, context), color: Colors.amber[600]),),
                                        ]
                                      ),
                                      _getRegisterDay(index: 2)
                                    ],
                                  )
                                )
                              ),
                            ],
                          ),
                        ),
                      ));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: getPixe(15, context),
                          vertical: getPixe(5, context)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.orange[800],
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(1, 2),
                              blurRadius: 1,
                              color: Color(0xccff7043)),
                        ],
                      ),
                      child: Text(
                        '去签到',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: getPixe(14, context),
                            fontWeight: FontWeight.w500),
                      ),
                    )),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: getPixe(5, context),
            ),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      '读享快乐',
                      style: TextStyle(
                          fontSize: getPixe(16, context),
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: getPixe(5, context),
                    ),
                    Text(
                      '每日阅读轻松赚积分',
                      style: TextStyle(
                          fontSize: getPixe(12, context),
                          color: Colors.grey,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: getPixe(5, context),
                      vertical: getPixe(10, context)),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 7,
                        child: Padding(
                            padding:
                                EdgeInsets.only(right: getPixe(50, context)),
                            child: Column(
                              children: <Widget>[
                                _getReadTimeContent(
                                    isFirst: true,
                                    isActive: true,
                                    time: 5,
                                    earnNum: 10),
                                _getReadTimeContent(
                                    time: 15, earnNum: 20, isActive: true),
                                _getReadTimeContent(time: 30, earnNum: 20),
                                _getReadTimeContent(time: 60, earnNum: 30),
                                _getReadTimeContent(time: 90, earnNum: 30),
                                _getReadTimeContent(time: 120, earnNum: 40),
                                _getReadTimeContent(
                                    isLast: true, time: 180, earnNum: 60),
                              ],
                            )),
                      ),
                      Expanded(
                        flex: 2,
                        child: Center(
                            child: _buildButton(
                                title: '去阅读', onTabHandler: toBookShelfPage)),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _getRegisterDay({int index}) {
    List registerEarnList = [10,20,50,30,30,30,100];
    _getItem(){
      List<Widget> _list = List<Widget>();
      for(int i=0;i<registerEarnList.length; i++) {
        bool isActive = index==(i+1);
        bool isPassed = i<index;
        bool isLast = i==registerEarnList.length-1;
        Color _bgColor = isPassed ? Colors.deepOrange : Colors.amber[200];
        _list.add(
          Column(
            children: [
             Container(
               padding: isActive ? EdgeInsets.only(bottom: getPixe(4, context)) : EdgeInsets.only( top: getPixe(2.5, context),bottom: getPixe(6.5, context)),
               child: Row(
                 children: <Widget>[
                             i==0 ? SizedBox():Container(
                     width: getPixe(10, context),
                     height: getPixe(2, context),
                     color: _bgColor,
                   ),
                   Container(
                     padding: isLast ? EdgeInsets.symmetric(vertical: getPixe(4, context),horizontal: getPixe(1, context)) :EdgeInsets.all(getPixe(4, context)),
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(20),
                       color: _bgColor,
                     ),
                     child: Text('${registerEarnList[i]}', style: TextStyle(fontSize: isActive ? getPixe(18, context) : getPixe(13, context), color: Colors.white), )
                   ),
                   isLast ? SizedBox():Container(
                     width: getPixe(10, context),
                     height: getPixe(2, context),
                     color: _bgColor,
                   ),
                 ],
               ),
             ),
              Text('${i+1}天', style: TextStyle(fontSize: getPixe(10, context),color: Colors.brown),)
            ]
          )
        );
      }
      return _list;
    }
    return Container(
      padding: EdgeInsets.symmetric(vertical: getPixe(20, context)),
      height: getPixe(90, context),
      child: Row(
        children: _getItem(),
      )
    );
  }

  _getReadTimeContent(
      {bool isFirst = false,
      bool isLast = false,
      bool isActive = false,
      int time,
      int earnNum}) {
    Color _bgColor = isActive ? Colors.deepOrange : Colors.grey[300];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(children: [
          Column(children: [
            Container(
              width: getPixe(2, context),
              height: getPixe(10, context),
              color: isFirst ? Colors.transparent : _bgColor,
            ),
            Container(
              width: getPixe(13, context),
              height: getPixe(13, context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: _bgColor,
              ),
              child: isActive
                  ? Icon(
                      Icons.check,
                      size: getPixe(10, context),
                      color: Colors.white,
                    )
                  : SizedBox(),
            ),
            Container(
              width: getPixe(2, context),
              height: getPixe(10, context),
              color: isLast ? Colors.transparent : _bgColor,
            ),
          ]),
          SizedBox(
            width: getPixe(10, context),
          ),
          Text(
            '阅读$time分钟',
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: getPixe(14, context)),
          ),
        ]),
        Text(
          '$earnNum积分',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.deepOrange,
              fontSize: getPixe(12, context)),
        )
      ],
    );
  }

  /// 新手福利
  Widget _buildBeginnerBenefit() {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: getPixe(10, context), vertical: getPixe(10, context)),
      padding: EdgeInsets.all(getPixe(10, context)),
      width: getWidth(context),
      decoration: BoxDecoration(
        color: Color(0xfffffffe),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                left: getPixe(10, context), bottom: getPixe(10, context)),
            child: Text(
              '新手福利',
              style: TextStyle(
                  color: Colors.orange[800],
                  fontWeight: FontWeight.w500,
                  fontSize: getPixe(18, context)),
            ),
          ),
          _getRowItem('首次登录奖励', '登录后可领取更多积分', 10, toLoginPage),
          _getRowItem('首次阅读10分钟', '轻轻松松赚积分', 10, toBookShelfPage, isRead: true),
          _getRowItem('开启精选推送', '开启必要权限及时收取推送', 50, toLoginPage),
        ],
      ),
    );
  }

  _getRowItem(title, subTitle, earnNum, callback, {bool isRead = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: getPixe(10, context)),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: getPixe(10, context)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 7,
                  child: Padding(
                      padding: EdgeInsets.only(right: getPixe(50, context)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  title,
                                  style: TextStyle(
                                      fontSize: getPixe(15, context),
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  subTitle,
                                  style: TextStyle(
                                      fontSize: getPixe(10, context),
                                      color: Colors.grey),
                                )
                              ],
                            ),
                            Text(
                              '$earnNum积分',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.deepOrange,
                                  fontSize: getPixe(12, context)),
                            ),
                          ])),
                ),
                Expanded(
                    flex: 2,
                    child: Center(
                      child: _buildButton(
                          title: isRead ? '去阅读' : '去完成',
                          onTabHandler: callback),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 底部提示信息
  Widget _buildFooterInfo() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: getPixe(15, context)),
      child: Text(
        '抽奖活动及活动奖品由热读小说提供',
        style: TextStyle(fontSize: getPixe(12, context), color: Colors.grey),
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    tabProvider = Provider.of<TabIndexProvider>(context);
    return Scaffold(
      backgroundColor: Color(0xfff7f7f7),
      appBar: AppBar(
        title: Text(
          '福利中心',
          style: TextStyle(fontSize: getPixe(20, context)),
        ),
        centerTitle: true,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Iconfont.zuo),
          iconSize: getPixe(26, context),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          InkWell(
              onTap: () {},
              child: Container(
                  padding: EdgeInsets.only(
                    right: getPixe(15, context),
                  ),
                  child: Center(
                    child: Text(
                      '积分商城',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: getPixe(16, context),
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  )))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildHeader(),
            _buildDailyBenefit(),
            _buildBeginnerBenefit(),
            _buildFooterInfo()
          ],
        ),
      ),
    );
  }
}
