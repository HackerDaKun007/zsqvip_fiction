/*
 * @author      Yuri Chen <pluto401zz@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 * 
 * @see         积分商城
*/

import 'package:fiction/public/public.dart';
import 'package:flutter/material.dart';

List catalogueData = [
  '初次出手',
  '初次出手1',
  '初次出手2',
  '初次出手3',
  '初次出手3',
  '初次出手3',
  '初次出手3',
  '初次出手3',
  '初次出手3',
  '初次出手3',
  '初次出手3',
  '初次出手3',
  '初次出手3',
  '初次出手3',
  '初次出手3',
  '初次出手3',
  '初次出手3',
  '初次出手5',
  '初次出手5',
  '初次出手5',
  '初次出手5',
  '初次出手9',
];

class BookDetailCatalogue extends StatefulWidget {
  final Map data;
  BookDetailCatalogue({Key key, this.data}):super(key: key);

  @override
  _BookDetailCatalogueState createState() => _BookDetailCatalogueState();
}

class _BookDetailCatalogueState extends State<BookDetailCatalogue> {
  List<Widget> catalogueList = List<Widget>();
  List<Widget> reversedCatalogueList = List<Widget>();
  Map data;
  bool _isReversed;
  final PixelSize pixel = PixelSize();

  @override
  void initState() {
    super.initState();
    data = widget.data;
    _isReversed = false;
    List.generate(
        catalogueData.length,
        (index) => catalogueList
            .add(_buildCatalogueItem(index, catalogueData[index])));
    reversedCatalogueList = catalogueList.reversed.toList();
  }

  /// 目录倒转
  _handleCatalogueReverse() {
    setState(() {
      _isReversed = !_isReversed;
    });
  }

  Widget _buildCatalogueItem(index, chapter) {
    return InkWell(
        onTap: () {
          print('=========第${index + 1}章=========');
        },
        child: Ink(
          height: pixel.setFontSize(50, context),
          padding: EdgeInsets.symmetric(
              vertical: pixel.setFontSize(10, context), horizontal: pixel.setFontSize(20, context)),
          child: Text('第${index + 1}章  $chapter'),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: pixel.screenWidthDp(context),
          child: Row(
            children: <Widget>[
              Spacer(
                flex: 1,
              ),
              Expanded(
                flex: 6,
                child: Text(
                  '目录',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: pixel.setFontSize(18, context),
                      fontWeight: FontWeight.w500),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
                color: Colors.grey,
              )
            ],
          ),
        ),
        Container(
          width: pixel.screenWidthDp(context),
          padding: EdgeInsets.symmetric(horizontal: pixel.setFontSize(15, context)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '共${data['chapter']}章',
                style: TextStyle(
                    fontSize: pixel.setFontSize(12, context), color: Config.color),
              ),
              IconButton(
                onPressed: _handleCatalogueReverse,
                icon: const Icon(Icons.swap_vert),
                color: Config.color,
                iconSize: pixel.setFontSize(20, context),
              )
            ],
          ),
        ),
        Expanded(
            child: ListView(
          children: _isReversed ? reversedCatalogueList : catalogueList,
        ))
      ],
    );
  }
}
