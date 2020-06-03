/*
 * @author      HackerDaKun007 <hackerdakun007@gmail.com> 
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         h5页面广告
*/
import 'package:flutter/material.dart';
import 'package:fiction/public/public.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class H5Ad extends StatefulWidget {
  Map arguments;
  H5Ad({Key key, this.arguments}) : super(key: key);

  @override
  _H5AdState createState() => _H5AdState(arguments:this.arguments);
}

class _H5AdState extends State<H5Ad>  {
  PixelSize pixel = PixelSize();
  Map arguments;
  Map data;

  _H5AdState({this.arguments}) {
    //执行dio网络请求方案
    this.data = {
      'title': '远离高利息， 有钱花日息，最快5分钟到账',
      'url': 'http://sports.sina.com.cn/l/2020-05-29/doc-iircuyvi5657180.shtml',
    };

    //发送广告统计到服务器

  }


  InAppWebViewController webView;
  String url = "";
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        backgroundColor: Color(0x99f2f2f2),
        leading: IconButton(
          icon: Icon(
            Iconfont.zuo,
            size: pixel.setFontSize(28, context),
            color: Color(0x99393D49),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Container(
          width: pixel.setWidth(200, context),
          child: Text(
            data['title'],
            style: TextStyle(
                fontSize: pixel.setFontSize(16, context), color: Color(0x99393D49),),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      body: Container(
          child: Column(children: <Widget>[
            Container(
                child: progress < 1.0
                    ? LinearProgressIndicator(value: progress, valueColor:AlwaysStoppedAnimation<Color>(Config.color), backgroundColor: Colors.grey,)
                    : Container()),
            Expanded(
              child: Container(
                child: InAppWebView(
                  initialUrl: data['url'],
                  initialHeaders: {},
                  initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                        debuggingEnabled: true,
                    )
                  ),
                  onWebViewCreated: (InAppWebViewController controller) {
                    webView = controller;
                  },
                  onLoadStart: (InAppWebViewController controller, String url) {
                    setState(() {
                      this.url = url;
                    });
                  },
                  onLoadStop: (InAppWebViewController controller, String url) async {
                    setState(() {
                      this.url = url;
                    });
                  },
                  onProgressChanged: (InAppWebViewController controller, int progress) {
                    setState(() {
                      this.progress = progress / 100;
                    });
                  },
                ),
              ),
            ),
        ])),
    );
  }
}
