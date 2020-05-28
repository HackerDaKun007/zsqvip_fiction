/*
 * @author      HackerDaKun007 <hackerdakun007@gmail.com> 
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         加载动画
*/

import 'package:flutter/material.dart';
import 'package:fiction/public/public.dart';

class Load  with PixelSize { 

  OverlayEntry _overlayLoad; //加到屏幕上

  /*
   * 启动加载动画 
   */
  showLoad(BuildContext context, {double top=0.0, double bottom=0.0, String value='加载中...'}) {
    //获取OverlayState
    OverlayState overlayState = Overlay.of(context);
    if (_overlayLoad == null) {
      //创建OverlayEntry
      _overlayLoad = OverlayEntry(
        builder: (BuildContext context) => Container(
            margin: EdgeInsets.fromLTRB(0, getPixe(top, context), 0, getPixe(bottom, context)),
          width: double.infinity,
          height: double.infinity,
          color: Colors.black12,
            child: Center(
              child: Container(
                width: getPixe(120, context),
                height: getPixe(120, context),
                // padding: EdgeInsets.all(getPixe(20, context),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(getPixe(4, context)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                    SizedBox(
                      height: getPixe(15, context),
                    ),
                    Text(
                      value,
                      style: TextStyle(fontSize: 16.0, color: Colors.white, decoration: TextDecoration.none),
                    )
                  ],
                ),
              ),
            ),
        ));
    //显示到屏幕上
    overlayState.insert(_overlayLoad);
    } else {
      //重新绘制UI，类似setState
      _overlayLoad.markNeedsBuild();
    }
  }

  /*
   * 关闭动画
   */
  hidLod() {
    _overlayLoad.remove();
    _overlayLoad = null;
  }
}