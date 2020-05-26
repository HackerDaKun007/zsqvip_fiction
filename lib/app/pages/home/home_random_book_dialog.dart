/*
 * @author      Yuri Chen <pluto401zz@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 * 
 * @see         书城页面-随便看看版块
*/

import 'package:fiction/public/public.dart';
import 'package:fiction/res/guessYouLikeData.dart';
import 'package:flutter/material.dart';

class RandomBookDialog extends StatefulWidget {
  @override
  _RandomBookDialogState createState() => _RandomBookDialogState();
}

class _RandomBookDialogState extends State<RandomBookDialog> with PixelSize{
  double rpx;
  List<Map> _data = guessYouLikeData;

  @override
  void initState() {
    super.initState();
    _data.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    rpx = getWidth(context) / 750;
    return Container(
      height: 620 * rpx,
      width: 450 * rpx,
      padding: EdgeInsets.fromLTRB(30 * rpx, 10 * rpx, 10 * rpx, 10 * rpx),
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                    padding:
                        EdgeInsets.fromLTRB(0, 20 * rpx, 20 * rpx, 20 * rpx),
                    child: Column(
                      children: <Widget>[
                        Material(
                          elevation: 8,
                          color: Colors.transparent,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8 * rpx),
                            child: Image.network(_data.first['imageUrl'],
                                height: 190 * rpx, fit: BoxFit.fill),
                          ),
                        ),
                        SizedBox(
                          height: 20 * rpx,
                        ),
                        Text(
                          _data.first['title'],
                          style: TextStyle(
                              fontSize: 36 * rpx, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10 * rpx,
                        ),
                        Text(
                          _data.first['author'],
                          style:
                              TextStyle(color: Colors.grey, fontSize: 26 * rpx),
                        ),
                        SizedBox(
                          height: 10 * rpx,
                        ),
                        Text(
                          _data.first['sutitle'],
                          style: TextStyle(
                              color: Colors.black54, fontSize: 26 * rpx),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    )),
              ),
              Container(
                  padding: EdgeInsets.only(right: 20 * rpx),
                  width: 450 * rpx,
                  child: FlatButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: Text('立即阅读'),
                    onPressed: () {
                      print('====== pressed =====');
                    },
                  ))
            ],
          ),
          Positioned(
              top: 0,
              right: 0,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close,
                  color: Colors.grey,
                ),
              ))
        ],
      ),
    );
  }
}
