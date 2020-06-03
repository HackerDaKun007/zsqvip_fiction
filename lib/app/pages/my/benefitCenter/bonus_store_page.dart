import 'package:fiction/public/public.dart';
import 'package:flutter/material.dart';

class BonusStorePage extends StatefulWidget {
  @override
  _BonusStorePageState createState() => _BonusStorePageState();
}

class _BonusStorePageState extends State<BonusStorePage> {
  bool isLogin;

  PixelSize pixel = PixelSize();

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
    super.initState();
    isLogin = true;
  }

  /// 头部
  Widget _buildHeader() {
    return Container(
      width: pixel.screenWidthDp(context),
      height: pixel.setFontSize(250, context),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/welfare.jpg'), fit: BoxFit.cover)),
      child: _buildHeaderText(),
    );
  }

  Widget _buildHeaderText() {
    return Container(
      padding: EdgeInsets.only(top: pixel.setFontSize(35, context)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: isLogin
            ? <Widget>[
                Text(
                  '当前积分',
                  style: TextStyle(
                      fontSize: pixel.setFontSize(12, context), color: Colors.white54),
                ),
                SizedBox(
                  height: pixel.setFontSize(10, context),
                ),
                Text(
                  '50',
                  style: TextStyle(
                    fontSize: pixel.setFontSize(45, context),
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: pixel.setFontSize(8, context),
                ),
                InkWell(
                  onTap: toBack,
                  child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: pixel.setFontSize(50, context),
                          vertical: pixel.setFontSize(6, context)),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(pixel.setFontSize(20, context)),
                          gradient: LinearGradient(
                              colors: [Color(0xffE3B967), Color(0xffF8E1AA)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight)),
                      child: Text(
                        '去赚积分>',
                        style: TextStyle(
                            fontSize: pixel.setFontSize(15, context),
                            fontWeight: FontWeight.w600,
                            color: Colors.deepOrange[900]),
                      )),
                )
              ]
            : <Widget>[
                Text(
                  '登录可领取积分、兑换大奖',
                  style: TextStyle(
                      color: Colors.white, fontSize: pixel.setFontSize(12, context)),
                ),
                SizedBox(
                  height: pixel.setFontSize(15, context),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: pixel.setFontSize(35, context),
                          vertical: pixel.setFontSize(6, context)),
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
                            fontSize: pixel.setFontSize(14, context)),
                      )),
                )
              ],
      ),
    );
  }

  /// 积分商城展示
  Widget _buildBonusDetail() {
    double mainWidth = pixel.screenWidthDp(context);
    double childWidth = pixel.setFontSize((mainWidth - 63) / 3, context);
    return Container(
      padding: EdgeInsets.all(pixel.setFontSize(15, context)),
      width: mainWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: EdgeInsets.only(bottom: pixel.setFontSize(20, context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '兑换iPhone Xs Max',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: pixel.setFontSize(20, context)),
                  ),
                  Text(
                    '已获得0个碎片，集满10个可兑换iPhone Xs Max',
                    style: TextStyle(
                        color: Colors.grey, fontSize: pixel.setFontSize(11, context)),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    0, pixel.setFontSize(15, context), 0, pixel.setFontSize(10, context)),
                child: Wrap(
                  direction: Axis.horizontal,
                  spacing: pixel.setFontSize(15, context),
                  runSpacing: pixel.setFontSize(15, context),
                  children: [
                    _getProductCard(
                        childWidth, 'images/welfare_integral_1.png', 'iPhone X',
                        ishot: true),
                    _getProductCard(childWidth, 'images/welfare_integral_2.png',
                        'iPhone X 碎片'),
                    _getProductCard(childWidth, 'images/welfare_integral_2.png',
                        'iPhone X 碎片'),
                  ],
                ),
              )
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '兑换免广告特权',
              style: TextStyle(
                  fontWeight: FontWeight.w600, fontSize: pixel.setFontSize(20, context)),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  0, pixel.setFontSize(15, context), 0, pixel.setFontSize(10, context)),
              child: Wrap(
                direction: Axis.horizontal,
                spacing: pixel.setFontSize(15, context),
                runSpacing: pixel.setFontSize(15, context),
                children: [
                  _getTextCard(childWidth,
                      isNew: true, time: '5分钟', earnNum: 10),
                  _getTextCard(childWidth,
                      isHot: true, time: '30分钟', earnNum: 120),
                  _getTextCard(childWidth,
                      isHot: true, time: '1小时', earnNum: 240),
                  _getTextCard(childWidth, time: '1天', earnNum: 1200),
                  _getTextCard(childWidth, time: '1周', earnNum: 4000),
                  _getTextCard(childWidth, time: '1个月', earnNum: 8888),
                ],
              ),
            )
          ],
        )
      ]),
    );
  }

  /// 按钮
  Widget _getButton({String title, VoidCallback callback}) {
    return InkWell(
        onTap: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true, // 设置为true即可设置高度
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(pixel.setFontSize(16, context)))),
              builder: (BuildContext context) {
                return Container(
                  height: pixel.height * 0.35,
                  child: _buildBottomSheetContent(),
                );
              });
        },
        child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: pixel.setFontSize(30, context),
                vertical: pixel.setFontSize(3, context)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(pixel.setFontSize(22, context)),
                gradient: LinearGradient(
                    colors: [Color(0xffE3B967), Color(0xffF8E1AA)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight)),
            child: Text(
              title,
              style: TextStyle(
                  fontSize: pixel.setFontSize(13, context),
                  fontWeight: FontWeight.w600,
                  color: Colors.deepOrange[900]),
            )));
  }

  Widget _buildBottomSheetContent() {
    return Container(
        padding: EdgeInsets.all(pixel.setFontSize(10, context)),
        margin: EdgeInsets.only(bottom: pixel.setFontSize(20, context)),
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: pixel.setFontSize(30, context),
                  horizontal: pixel.setFontSize(20, context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '免5分钟广告',
                          style: TextStyle(fontSize: pixel.setFontSize(24, context)),
                        ),
                        SizedBox(
                          height: pixel.setFontSize(15, context),
                        ),
                        Text(
                          '兑换后立即生效，可以免除5分钟阅读器内广告，5分钟后自动失效。',
                          style: TextStyle(fontSize: pixel.setFontSize(12, context)),
                        )
                      ]),
                  Spacer(),
                  InkWell(
                    onTap: toBack,
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: pixel.setFontSize(120, context),
                            vertical: pixel.setFontSize(10, context)),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(pixel.setFontSize(20, context)),
                            gradient: LinearGradient(
                                colors: [Color(0xffE3B967), Color(0xffF8E1AA)],
                                end: Alignment.centerLeft,
                                begin: Alignment.centerRight)),
                        child: Text(
                          '使用10积分兑换',
                          style: TextStyle(
                              fontSize: pixel.setFontSize(15, context),
                              color: Colors.deepOrange[900]),
                        )),
                  )
                ],
              ),
            ),
            Positioned(
              right: 0,
              child: InkWell(
                  onTap: toBack,
                  child: Icon(
                    Icons.close,
                    color: Colors.grey,
                  )),
            )
          ],
        ));
  }

  /// 文字卡片
  Widget _getTextCard(
    childWidth, {
    bool isNew = false,
    bool isHot = false,
    String time,
    int earnNum,
  }) {
    List<Color> _newColors = [Colors.deepOrange, Colors.orange[700]];
    List<Color> _hotColors = [Colors.amber[700], Colors.amber[300]];
    bool _isActive = isNew || isHot;

    return Stack(children: [
      Container(
        width: childWidth,
        height: childWidth,
        decoration: BoxDecoration(
          color: Colors.amber[50],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '免$time广告',
                  style: TextStyle(fontSize: pixel.setFontSize(15, context)),
                ),
                Text(
                  '消耗 $earnNum积分',
                  style: TextStyle(
                      fontSize: pixel.setFontSize(12, context), color: Colors.grey),
                )
              ],
            ),
            SizedBox(
              height: pixel.setFontSize(10, context),
            ),
            _getButton(title: '兑换')
          ]),
        ),
      ),
      _isActive
          ? Positioned(
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: pixel.setFontSize(5, context),
                    vertical: pixel.setFontSize(1, context)),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: isNew ? _newColors : _hotColors,
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(pixel.setFontSize(8, context)),
                        bottomLeft: Radius.circular(pixel.setFontSize(8, context)),
                        bottomRight: Radius.circular(pixel.setFontSize(8, context)))),
                child: Text(
                  isNew ? '新用户专享' : '热门',
                  style: TextStyle(
                      color: Colors.white, fontSize: pixel.setFontSize(10, context)),
                ),
              ))
          : SizedBox()
    ]);
  }

  /// 产品卡片
  Widget _getProductCard(childWidth, imgUrl, productName,
      {bool ishot = false}) {
    return Stack(children: [
      Container(
        height: pixel.setFontSize(165, context),
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
                      color: Colors.grey[300], width: pixel.setFontSize(1, context))),
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
              style: TextStyle(fontSize: pixel.setFontSize(12, context)),
            ),
            _getButton(title: '兑换')
          ],
        ),
      ),
      ishot
          ? Positioned(
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: pixel.setFontSize(5, context),
                    vertical: pixel.setFontSize(1, context)),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.deepOrange, Colors.orange[700]],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(pixel.setFontSize(8, context)),
                        bottomLeft: Radius.circular(pixel.setFontSize(8, context)),
                        bottomRight: Radius.circular(pixel.setFontSize(8, context)))),
                child: Text(
                  'HOT',
                  style: TextStyle(
                      color: Colors.white, fontSize: pixel.setFontSize(10, context)),
                ),
              ))
          : SizedBox()
    ]);
  }

  /// 底部提示信息
  Widget _buildFooterInfo() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: pixel.setFontSize(15, context)),
      child: Text(
        '抽奖活动及活动奖品由热读小说提供',
        style: TextStyle(fontSize: pixel.setFontSize(12, context), color: Colors.grey),
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '积分兑换',
          style: TextStyle(fontSize: pixel.setFontSize(20, context)),
        ),
        centerTitle: true,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Iconfont.zuo),
          iconSize: pixel.setFontSize(26, context),
          onPressed: toBack,
        ),
        actions: <Widget>[
          InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/bonusdetail');
              },
              child: Container(
                  padding: EdgeInsets.only(
                    right: pixel.setFontSize(15, context),
                  ),
                  child: Center(
                    child: Text(
                      '明细',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: pixel.setFontSize(16, context),
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ))),
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(children: [
          Container(
            height: 1000,
          ),
          _buildHeader(),
          Positioned(
            top: pixel.setFontSize(200, context),
            child: Column(children: [_buildBonusDetail(), _buildFooterInfo()]),
          ),
        ]),
      ),
    );
  }
}
