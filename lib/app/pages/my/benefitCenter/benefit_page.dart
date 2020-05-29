import 'package:flutter/material.dart';

import 'package:fiction/public/public.dart';

class BenefitPage extends StatefulWidget {
  @override
  _BenefitPageState createState() => _BenefitPageState();
}

class _BenefitPageState extends State<BenefitPage> with PixelSize {
  bool isLogin; // 是否登录
  bool isTodayRegister; // 今日是否签到

  @override
  void initState() {
    super.initState();
    isLogin = true;
    isTodayRegister = false;
  }

  /// 头部
  Widget _buildHeader() {
    return Container(
        height: getPixe(365, context),
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
              padding: EdgeInsets.only(top: getPixe(25, context)),
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
          Positioned(top: getPixe(120, context), child: _buildStoreSummary()),
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
              children: <Widget>[
                Container(
                  height: getPixe(160, context),
                  width: childWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: childWidth,
                        height: childWidth,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Image.asset(
                            'images/2.jpg',
                            width: childWidth - 15,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Text(
                        '小米手机',
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
                                fontSize: getPixe(13, context),
                                color: Colors.white)),
                      )
                    ],
                  ),
                ),
                Container(
                  height: getPixe(160, context),
                  width: childWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: childWidth,
                        height: childWidth,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Image.asset(
                            'images/2.jpg',
                            width: childWidth - 10,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Text(
                        '小米手机',
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
                                fontSize: getPixe(13, context),
                                color: Colors.white)),
                      )
                    ],
                  ),
                ),
                Container(
                  height: getPixe(160, context),
                  width: childWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: childWidth,
                        height: childWidth,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Image.asset(
                            'images/2.jpg',
                            width: childWidth - 10,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Text(
                        '小米手机',
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
                                fontSize: getPixe(13, context),
                                color: Colors.white)),
                      )
                    ],
                  ),
                ),
              ],
            ),
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
      height: getPixe(400, context),
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
            height: getPixe(80, context),
            padding: EdgeInsets.all(getPixe(10, context)),
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
                  onTap: (){},
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
                  )
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 新手福利
  Widget _buildBeginnerBenefit() {}

  /// 底部提示信息
  Widget _buildFooterInfo() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: getPixe(15, context)),
      child: Text(
        '抽奖活动及活动奖牌有热读小说提供',
        style: TextStyle(fontSize: getPixe(12, context), color: Colors.grey),
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                          color: Colors.grey, fontSize: getPixe(16, context)),
                      textAlign: TextAlign.center,
                    ),
                  )))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[_buildHeader(), _buildDailyBenefit()],
        ),
      ),
    );
  }
}
