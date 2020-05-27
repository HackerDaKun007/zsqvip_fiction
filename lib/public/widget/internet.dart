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
  
  final Widget centent; //父级内容区域
  bool isLoad;  //执行加载动画
  String value; //加载动画提示文本
  bool isError; //数据是否请求失败

  Internet(this.centent, this.isLoad,
      {this.value = '加载中...', this.isError = false, Key key})
      : super(key: key);

  @override
  _InternetState createState() => _InternetState(isLoad = this.isLoad,
      value: this.value, isError: this.isError);
}

class _InternetState extends State<Internet> with PixelSize {
  var subscription;
  String stateText;
  bool isInternet = true;

  var bounced = Bounced(); //请求的值

  //加载动画
  String value; //提示文本
  bool isLoad;
  //数据是否请求失败
  bool isError;

  //是否已经提示弹框, 防止重复弹框
  static bool isAlert = false;

  _InternetState(this.isLoad, {this.value, this.isError});

  @override
  dispose() {
    super.dispose();
    subscription.cancel(); //注意,销毁内存
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
        if (!isAlert) {
          bounced.alert('提示', '您当前网络存在异常', context).then((value) {
            if (value) {
              isAlert = false;
            }
          });
        }
        setState(() {
          stateText = "none";
          isInternet = false;
          if (!isAlert) {
            isAlert = true;
          }
        });
      }
    });
  }

  Widget build(BuildContext context) {
    return _init();
  }

  //初始化定义数据
  Widget _init() {
    //判断网络 true网络正常，false网站不正常
    if (isInternet) {
      if (isError) {
        //isLoad: true返回请求失败， false返回请求成功
        return _error(); //数据请求失败
      } else if (isLoad) {
        //isLoad: true返回正常内容， false返回加载内容
        return widget.centent;
      } else {
        return _load();
      }
    } else {
      return internetContent();
    }
  }

  //加载动画
  Widget _load() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Center(
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
              SizedBox(
                height: getPixe(15, context),
              ),
              Text(
                this.value,
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              )
            ],
          ),
        ),
      ),
    );
  }

  //网络请求
  Widget internetContent() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: getPixe(80, context),
              child: Image.asset('images/internet.png', fit: BoxFit.fill),
            ),
            SizedBox(
                height: getPixe(15, context),
              ),
            Text(
              '请检查当前网络状态',
              style: TextStyle(
                  fontSize: getPixe(14, context),
                  color: Colors.grey,
                  decoration: TextDecoration.none),
            ),
          ],
        ),
      ),
    );
  }

  //数据请求失败展示
  Widget _error() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Center(
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
              Icon(Iconfont.jinggao,
                  size: getPixe(35, context), color: Colors.white),
              SizedBox(
                height: getPixe(15, context),
              ),
              Text(
                '数据请求失败',
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              )
            ],
          ),
        ),
      ),
    );
  }
}
