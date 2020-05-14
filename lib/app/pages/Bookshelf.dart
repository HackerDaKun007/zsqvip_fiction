/**
 * @author      dakun007 <dakun007@hotmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         书城
*/
import 'package:flutter/material.dart';

class BookshelfPage extends StatefulWidget {
  BookshelfPage({Key key}) : super(key: key);

  @override
  _BookshelfPageState createState() => _BookshelfPageState();
}

class _BookshelfPageState extends State<BookshelfPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('书城'),
      ),
      body: Container(
        height: 800,
        child: ListTile(
          title: Text('书城'),
        ),
      ),
    );
  }
}