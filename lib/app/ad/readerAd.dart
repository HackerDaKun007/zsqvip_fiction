import 'package:fiction/public/public.dart';
import 'package:flutter/material.dart';

class ReaderAd extends StatefulWidget {
  @override
  _ReaderAdState createState() => _ReaderAdState();
}

class _ReaderAdState extends State<ReaderAd> {
  PixelSize pixel = PixelSize();

  @override
  void initState() {
    super.initState();
    // dio请求广告
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          print('跳转广告');
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: pixel.setHeight(10, context)),
          height: pixel.setHeight(120, context),
          width: double.infinity,
          color: Colors.transparent,
          child:Stack(
            children: [
              Row(
                children: <Widget>[
                 Padding(
                   padding: EdgeInsets.symmetric(horizontal: pixel.setWidth(20, context)),
                   child: ClipRRect(
                     borderRadius: BorderRadius.circular(4),
                     child: Image.network(
                       'https://manhua.qpic.cn/operation/0/16_00_10_88908a9e29068d08f1d7620fc2373cda_1589559004105.jpg/0',
                       fit: BoxFit.cover,
                     ),
                   ),
                 ),
                 Expanded(
                   child: Container(
                     padding: EdgeInsets.symmetric(vertical: pixel.setFontSize(10, context)),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: <Widget>[
                         Text('抖音', style: TextStyle(color: ZFColors.textColor, fontWeight: FontWeight.w500),),
                         Text('太好玩了！来电秀，海量视频免费看看看啊看', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: pixel.setFontSize(12, context), color: ZFColors.textColor),)
                       ],
                     ),
                   ),
                 ),
                 GestureDetector(
                   child: Container(
                     margin: EdgeInsets.symmetric(horizontal: pixel.setWidth(20, context)),
                     padding: EdgeInsets.symmetric(horizontal: pixel.setFontSize(22, context), vertical: pixel.setFontSize(3, context)),
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(20),
                       border: Border.all(width: 1, color: ZFColors.orangeColor),
                     ),
                     child: Text('查看', style: TextStyle(fontSize: pixel.setFontSize(14, context), color: ZFColors.orangeColor),),
                   ),
                 )
                ],
              ),
              Positioned(
                top: 0,
                right: pixel.setWidth(10, context),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: pixel.setFontSize(4, context), vertical: pixel.setFontSize(1, context)),
                  decoration: BoxDecoration(
                    border: Border.all(width: pixel.setWidth(1, context), color: Colors.grey[400]),
                    borderRadius: BorderRadius.circular(2)
                  ),
                  child: Text('广告', style: TextStyle(fontSize: pixel.setFontSize(10, context),color: ZFColors.textColor),),
                ),
              )
            ]
          ),
        ));
  }
}
