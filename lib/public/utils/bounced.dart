/*
 * @author      HackerDaKun007 <hackerdakun007@gmail.com> 
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         弹出层
*/

import 'package:flutter/material.dart';

import 'package:fiction/public/public.dart';


class Bounced  {

  PixelSize pixel = PixelSize(); 

  /*
   * 质询框
   * @param {String} title 提示标题
   * @param {String} content 内容
   * return {Bool} 确定返回true, 取消返回false
   */
  confirm(String title, String content, BuildContext context) async {
    bool result = await showDialog(
        barrierDismissible: true, //表示点击灰色背景的时候是否消失弹出框
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content,
                style: TextStyle(
                  fontSize: pixel.setFontSize(16, context),
                )),
            actions: <Widget>[
              FlatButton(
                child: Text('取消',
                    style: TextStyle(
                      fontSize: pixel.setFontSize(16, context),
                    )),
                textColor: Colors.grey,
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
              FlatButton(
                child: Text('确定',
                    style: TextStyle(
                      fontSize: pixel.setFontSize(16, context),
                    )),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
            ],
          );
        });
    return result;
  }

  /*
   * 提示框
   * @param {String} title 提示标题
   * @param {String} content 内容
   * return {Bool} 确定返回true, 取消返回false
  */
  alert(String title, String content, BuildContext context) async {
    bool result = await showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content,
                style: TextStyle(
                  fontSize: pixel.setFontSize(16, context),
                )),
            actions: <Widget>[
              FlatButton(
                child: Text('确定',
                    style: TextStyle(
                      fontSize: pixel.setFontSize(16, context),
                    )),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
            ],
          );
        });
    return result;
  }

   /*
   * toast提示框
   * @param {String} msg 内容
  */
  static OverlayEntry _overlayEntry; //toast靠它加到屏幕上
  static bool _showing = false; //toast是否正在showing
  static DateTime _startedTime; //开启一个新toast的当前时间，用于对比是否已经展示了足够时间
  static String _msg;
  void toast(
    String msg,
    BuildContext context,
  ) async {
    assert(msg != null);
    _msg = msg;
    _startedTime = DateTime.now();
    //获取OverlayState
    OverlayState overlayState = Overlay.of(context);
    _showing = true;
    if (_overlayEntry == null) {
      _overlayEntry = OverlayEntry(
          builder: (BuildContext context) => Positioned(
                //top值，可以改变这个值来改变toast在屏幕中的位置
                top: pixel.screenHeightDp(context) * 2 / 2.5,
                child: Container(
                    alignment: Alignment.center,
                    width: pixel.screenWidthDp(context),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: pixel.setFontSize(80.0, context)),
                      child: AnimatedOpacity(
                        opacity: _showing ? 1.0 : 0.0, //目标透明度
                        duration: _showing
                            ? Duration(milliseconds: 100)
                            : Duration(milliseconds: 400),
                        child: Center(
                          child: Card(
                            color: Colors.black54,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: pixel.setFontSize(12.0, context),
                                  vertical: pixel.setFontSize(7.0, context)),
                              child: Text(
                                _msg,
                                style: TextStyle(
                                  fontSize: pixel.setFontSize(16, context),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )),
              ));
      overlayState.insert(_overlayEntry);
    } else {
      //重新绘制UI，类似setState
      _overlayEntry.markNeedsBuild();
    }
    await Future.delayed(Duration(milliseconds: 2000)); //等待两秒

    //2秒后 到底消失不消失
    if (DateTime.now().difference(_startedTime).inMilliseconds >= 2000) {
      _showing = false;
      _overlayEntry.remove();
      _overlayEntry = null;
    }
  }


}
