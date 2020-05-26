/*
 * @author      HackerDaKun007 <hackerdakun007@gmail.com> 
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see        文章目录 - 详情页面
*/

import 'package:flutter/material.dart';
import 'package:fiction/public/public.dart';

class Present extends StatefulWidget {
 
  @override
  _PresentState createState() => _PresentState();
}
 
class _PresentState extends State<Present> with PixelSize{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Text('详情页面'),
    );
  }

}