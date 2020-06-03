/*
 * @author      HackerDaKun007 <hackerdakun007@gmail.com> 
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         局部 - 加载动画
*/
import 'package:flutter/material.dart';
import 'package:fiction/public/public.dart';
class ModuleLoad  {

  PixelSize pixel = PixelSize(); 

  //显示局部请求加载动画
  Widget showModuleLoad(BuildContext context, {String value:'加载中...'}) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Config.color),
            ),
            SizedBox(
                height: pixel.setHeight(15, context),
              ),
              Text(value,
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                    decoration: TextDecoration.none),
              )
          ],
        ),
      ),
    );
  }

  //显示局部加载失败
  Widget errorModule(BuildContext context, {String value:'请求失败!'}) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
             Icon(Iconfont.jinggao,
                  size: pixel.setFontSize(35, context), color: Colors.red),
            SizedBox(
                height: pixel.setHeight(15, context),
              ),
              Text(value,
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                    decoration: TextDecoration.none),
              )
          ],
        ),
      ),
    );
  }
}