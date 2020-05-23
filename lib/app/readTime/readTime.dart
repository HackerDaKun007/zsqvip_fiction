/**
 * @author      HackerDaKun007 <hackerdakun007@gmail.com> 
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see        阅读时间
*/
import 'package:flutter/material.dart';
import 'package:fiction/provider/readTime.dart'; //阅读时间
import 'package:provider/provider.dart';

class ReadTime extends StatefulWidget {
  TextStyle style;
  ReadTime({Key key, this.style}) : super(key: key);

  @override
  _ReadTimeState createState() => _ReadTimeState(style: this.style);
}

class _ReadTimeState extends State<ReadTime>{
  TextStyle style; //传递style
  _ReadTimeState({this.style});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  Widget build(BuildContext context) {
  var providerReadTime = Provider.of<ReadTimeProvider>(context);
    return GestureDetector(
      child: Text("${providerReadTime.readTime}", style: this.style),
      onTap: () {
        providerReadTime.updateTime(providerReadTime.readTime+1);
      },
    );
  }
  
}