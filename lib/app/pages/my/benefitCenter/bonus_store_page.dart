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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: EdgeInsets.only(bottom: getPixe(20, context)),
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
                        fontSize: getPixe(20, context)),
                  ),
                  Text(
                    '已获得0个碎片，集满10个可兑换iPhone Xs Max',
                    style: TextStyle(
                        color: Colors.grey, fontSize: getPixe(11, context)),
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
                    _getProductCard(
                        childWidth, 'images/welfare_integral_1.png', 'iPhone X',
                        ishot: true),
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
                  fontWeight: FontWeight.w600, fontSize: getPixe(20, context)),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, getPixe(15, context),
                  getPixe(10, context), getPixe(10, context)),
              child: Wrap(
                direction: Axis.horizontal,
                spacing: getPixe(15, context),
                runSpacing: getPixe(30, context),
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
                      top: Radius.circular(getPixe(16, context)))),
              builder: (BuildContext context) {
                return Container(
                  height: getHeight(context) * 0.35,
                  child: _buildBottomSheetContent(),
                );
              });
        },
        child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: getPixe(30, context),
                vertical: getPixe(3, context)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(getPixe(22, context)),
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
            )));
  }

  Widget _buildBottomSheetContent() {
    return Container(
        padding: EdgeInsets.all(getPixe(10, context)),
        margin: EdgeInsets.only(bottom: getPixe(20, context)),
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: getPixe(30, context),
                  horizontal: getPixe(20, context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '免5分钟广告',
                          style: TextStyle(fontSize: getPixe(24, context)),
                        ),
                        SizedBox(
                          height: getPixe(15, context),
                        ),
                        Text(
                          '兑换后立即生效，可以免除5分钟阅读器内广告，5分钟后自动失效。',
                          style: TextStyle(fontSize: getPixe(12, context)),
                        )
                      ]),
                      Spacer(),
                  InkWell(
                    onTap: toBack,
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: getPixe(120, context),
                            vertical: getPixe(10, context)),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(getPixe(20, context)),
                            gradient: LinearGradient(
                                colors: [Color(0xffE3B967), Color(0xffF8E1AA)],
                                end: Alignment.centerLeft,
                                begin: Alignment.centerRight)),
                        child: Text(
                          '使用10积分兑换',
                          style: TextStyle(
                              fontSize: getPixe(15, context),
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
                  style: TextStyle(fontSize: getPixe(15, context)),
                ),
                Text(
                  '消耗 $earnNum积分',
                  style: TextStyle(
                      fontSize: getPixe(12, context), color: Colors.grey),
                )
              ],
            ),
            SizedBox(
              height: getPixe(10, context),
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
                    horizontal: getPixe(5, context),
                    vertical: getPixe(1, context)),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: isNew ? _newColors : _hotColors,
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(getPixe(8, context)),
                        bottomLeft: Radius.circular(getPixe(8, context)),
                        bottomRight: Radius.circular(getPixe(8, context)))),
                child: Text(
                  isNew ? '新用户专享' : '热门',
                  style: TextStyle(
                      color: Colors.white, fontSize: getPixe(10, context)),
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
      ),
      ishot
          ? Positioned(
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: getPixe(5, context),
                    vertical: getPixe(1, context)),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.deepOrange, Colors.orange[700]],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(getPixe(8, context)),
                        bottomLeft: Radius.circular(getPixe(8, context)),
                        bottomRight: Radius.circular(getPixe(8, context)))),
                child: Text(
                  'HOT',
                  style: TextStyle(
                      color: Colors.white, fontSize: getPixe(10, context)),
                ),
              ))
          : SizedBox()
    ]);
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
          height: 800,
          child: Stack(children: [
            _buildHeader(),
            Positioned(
              top: getPixe(200, context),
              child:
                  Column(children: [_buildBonusDetail(), _buildFooterInfo()]),
            ),
          ]),
        )));
  }
}
