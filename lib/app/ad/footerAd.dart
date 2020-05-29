/*
 * @author      HackerDaKun007 <hackerdakun007@gmail.com> 
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         底部广告
*/
import 'package:flutter/material.dart';
import 'package:fiction/public/public.dart';

class FooterAd extends StatefulWidget {
  FooterAd({Key key}) : super(key: key);

  @override
  _FooterAdState createState() => _FooterAdState();
}

class _FooterAdState extends State<FooterAd> with PixelSize {

  //判断是否关闭广告, true开启广告，false关闭广告
  bool _isAd = true;
  

  @override

  void initState() {
    super.initState();
    //请求dio广告
  }

  Widget build(BuildContext context) {
    return this._getAd();
  }


  Widget _getAd() {
    if (this._isAd) {
      return Positioned(
        bottom: getPixe(15, context),
        left: getPixe(15, context),
        right: getPixe(15, context),
        child: Container(
          height: getPixe(150, context),
          width: double.infinity,
          child: Stack(
            children: <Widget>[
              GestureDetector(
                child: Center(
                  child: Image.network(
                    'https://manhua.qpic.cn/operation/0/16_00_10_88908a9e29068d08f1d7620fc2373cda_1589559004105.jpg/0',
                    fit: BoxFit.cover,
                  ),
                ),
                onTap: () {
                  print('跳转广告');
                },
              ),
              //关闭
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  // color: Colors.grey,
                  child: GestureDetector(
                    child: Icon(
                      Iconfont.shanchu,
                      color: Colors.black,
                      size: getPixe(25, context),
                    ),
                    onTap: () {
                      //关闭广告
                      setState(() {
                        this._isAd = false;
                      });
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  color: Color(0x99e2e2e2),
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          getPixe(5, context),
                          getPixe(2, context),
                          getPixe(5, context),
                          getPixe(2, context)),
                      child: Text(
                        '广告',
                        style: TextStyle(
                          fontSize: getPixe(12, context),
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Text('');
    }
  }


}
