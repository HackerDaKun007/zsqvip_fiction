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

class Internet extends StatefulWidget {
  Widget centent;
  Internet(this.centent, {Key key}) : super(key: key);

  @override
  _InternetState createState() => _InternetState(centent=this.centent);
}

class _InternetState extends State<Internet> with PixelSize {
  
  var subscription;
  String stateText;
  bool isInternet = true;
  Widget centent; //内容值

  _InternetState(this.centent);

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
        setState(() {
          stateText = "none";
          isInternet = false;
        });
      }
    });
  }

  Widget build(BuildContext context) {
    return init(this.centent);
  }

  Widget init(Widget centent) {
    //判断网络 true网络正常，false网站不正常
    if (isInternet) {
      return centent;
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
}
