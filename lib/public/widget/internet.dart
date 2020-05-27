/*
 * @author      HackerDaKun007 <hackerdakun007@gmail.com> 
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         获取网络状态
*/
import 'package:flutter/material.dart';
import 'package:fiction/public/public.dart';
import 'package:connectivity/connectivity.dart';
import 'package:fiction/public/utils/bounced.dart';

class Internet extends StatefulWidget {
  Widget centent;

  //加载动画
  String value; //提示文本
  bool isLoad;
  Internet(this.centent, this.isLoad, {Key key, this.value:'加载中...'}) : super(key: key);

  @override
  _InternetState createState() => _InternetState(centent=this.centent, isLoad=this.isLoad,value:this.value);
}

class _InternetState extends State<Internet> with PixelSize {
  
  var subscription;
  String stateText;
  bool isInternet = true;
  Widget centent; //内容值

  var bounced = Bounced(); //请求的值

  //加载动画
  String value; //提示文本
  bool isLoad;
  _InternetState(this.centent, this.isLoad, {this.value});

  @override
  dispose() {
    super.dispose();
    subscription.cancel();  //注意,销毁内存
  }

  void initState() {
    super.initState();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.wifi) {
        setState(() {
          stateText = "wifi";
          isInternet = true;
        });
      } else if (result == ConnectivityResult.mobile) {
        setState(() {
          stateText = "mobile";
          isInternet = true;
        });
      } else {
        bounced.alert('提示', '您当前网络存在异常', context);
        setState(() {
          stateText = "none";
          isInternet = false;
        });
      }
    });
  }

  Widget build(BuildContext context) {
    return _init(this.centent);
  }

  //初始化定义数据
  Widget _init(Widget centent) {
    //判断网络 true网络正常，false网站不正常
    if (isInternet) {
      //isLoad: true返回正常内容， false返回加载内容
      if (isLoad) {
        return centent;
      } else {
        return _load(this.value);
      }
    } else {
      return Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(
                  0, getPixe(220, context), 0, getPixe(10, context)),
              height: getPixe(80, context),
              child: Image.asset('images/internet.png', fit: BoxFit.fill),
            ),
            Text(
              '请检查当前网络状态',
              style: TextStyle(
                fontSize: getPixe(14, context),
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }
  }

  //加载动画
  Widget _load(String value) {
    return Center(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Container(
            width: getPixe(120, context),
            height: getPixe(120, context),
            // padding: EdgeInsets.all(getPixe(20, context),
            decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.circular(getPixe(4, context)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(
                  // strokeWidth: 1.0,
                  // backgroundColor: Colors.black38,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  // backgroundColor: Colors.black,
                ),
                SizedBox(height: getPixe(15, context),),
                 Text(
                value,
                style: TextStyle(fontSize: 16.0, color:Colors.white),
              )
              ],
            ),
          ),
        ),
      );
  }
}
