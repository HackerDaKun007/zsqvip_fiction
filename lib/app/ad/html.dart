/*
 * @author      HackerDaKun007 <hackerdakun007@gmail.com> 
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         html页面
*/
import 'package:flutter/material.dart';
import 'package:fiction/public/public.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class Html extends StatefulWidget {
  Map arguments;
  Html({Key key, this.arguments}) : super(key: key);

  @override
  _HtmlState createState() => _HtmlState(arguments: this.arguments);
}

class _HtmlState extends State<Html> with PixelSize {
  /* 需要传入: title, url */
  Map arguments;
  _HtmlState({this.arguments});

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
            size: getPixe(28, context),
            color: Color(0x99393D49),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Container(
          width: getPixe(200, context),
          child: Text(
            arguments['title'],
            style: TextStyle(
                fontSize: getPixe(16, context), color: Color(0x99393D49),),
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
                  initialUrl: arguments['url'],
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