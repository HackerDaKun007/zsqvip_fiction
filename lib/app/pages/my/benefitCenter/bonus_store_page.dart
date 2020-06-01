import 'package:fiction/public/public.dart';
import 'package:flutter/material.dart';

class BonusStorePage extends StatefulWidget {
  @override
  _BonusStorePageState createState() => _BonusStorePageState();
}

class _BonusStorePageState extends State<BonusStorePage> with PixelSize {
  bool isLogin;

  /// 转到登录页
  void toLoginPage() {
    Navigator.pushNamed(context, '/login');
  }

  /// 转到书架页
  void toBack() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLogin = true;
  }

  /// 头部
  Widget _buildHeader() {
    return Container(
      width: getWidth(context),
      height: getPixe(250, context),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/welfare.jpg'), fit: BoxFit.cover)),
      child: Container(
        padding: EdgeInsets.only(top: getPixe(35, context)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: isLogin
              ? <Widget>[
                  Text(
                    '当前积分',
                    style: TextStyle(
                        fontSize: getPixe(12, context), color: Colors.white54),
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
                  ),
                  SizedBox(
                    height: getPixe(8, context),
                  ),
                  InkWell(
                    onTap: toBack,
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: getPixe(50, context),
                            vertical: getPixe(6, context)),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(getPixe(20, context)),
                            gradient: LinearGradient(
                                colors: [Color(0xffE3B967), Color(0xffF8E1AA)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight)),
                        child: Text(
                          '去赚积分>',
                          style: TextStyle(
                              fontSize: getPixe(15, context),
                              fontWeight: FontWeight.w600,
                              color: Colors.deepOrange[900]),
                        )),
                  )
                ]
              : <Widget>[
                  Text(
                    '登录可领取积分、兑换大奖',
                    style: TextStyle(
                        color: Colors.white, fontSize: getPixe(12, context)),
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
                                colors: [Colors.blue[600], Colors.blue[300]],
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
    );
  }

  /// 积分商城展示
  Widget _buildBonusDetail() {
    double mainWidth = getWidth(context);
    double childWidth = getPixe((mainWidth - 53) / 3, context);
    return Container(
      padding: EdgeInsets.all(getPixe(15, context)),
      width: mainWidth,
      height: 500,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '兑换iPhone Xs Max',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: getPixe(20, context)),
              ),
              Text(
                '已获得0个碎片，集满10个可兑换iPhone Xs Max',
                style: TextStyle(
                    color: Colors.grey, fontSize: getPixe(10, context)),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, getPixe(15, context),
                getPixe(10, context), getPixe(10, context)),
            child: Wrap(
              direction: Axis.horizontal,
              spacing: getPixe(15, context),
              children: [
                _getStoreCard(
                    childWidth, 'images/welfare_integral_1.png', 'iPhone X'),
                _getStoreCard(
                    childWidth, 'images/welfare_integral_2.png', 'iPhone X 碎片'),
              ],
            ),
          )
        ],
      ),
    );
  }

  _getButton({String title, VoidCallback callback}) {
    return InkWell(
      onTap: () {},
      child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: getPixe(24, context), vertical: getPixe(2, context)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(getPixe(20, context)),
              gradient: LinearGradient(
                  colors: [Color(0xffE3B967), Color(0xffF8E1AA)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight)),
          child: Text(
            title,
            style: TextStyle(
                fontSize: getPixe(13, context),
                fontWeight: FontWeight.w600,
                color: Colors.deepOrange[900]),
          ))
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
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: Colors.grey[300], width: getPixe(1, context))),
            child: Center(
              child: Image.asset(
                imgUrl,
                width: childWidth - 40,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Text(
            productName,
            style: TextStyle(fontSize: getPixe(12, context)),
          ),
          _getButton(title: '兑换')
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '积分兑换',
            style: TextStyle(fontSize: getPixe(20, context)),
          ),
          centerTitle: true,
          elevation: 1,
          leading: IconButton(
            icon: const Icon(Iconfont.zuo),
            iconSize: getPixe(26, context),
            onPressed: toBack,
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
                        '明细',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: getPixe(16, context),
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    ))),
          ],
        ),
        body: SingleChildScrollView(
            child: Container(
          height: 1000,
          child: Stack(children: [
            _buildHeader(),
            Stack(children: [
              Positioned(
                top: getPixe(200, context),
                child: _buildBonusDetail(),
              ),
            ]),
          ]),
        )));
  }
}
