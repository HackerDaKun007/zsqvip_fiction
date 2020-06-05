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

class ReaderDrawer extends StatefulWidget {
  final Map data;
  ReaderDrawer({Key key, this.data}) : super(key: key);

  @override
  _ReaderDrawerState createState() => _ReaderDrawerState();
}

class _ReaderDrawerState extends State<ReaderDrawer> {

  Color activeColor = Colors.black;

  List<Widget> catalogueList = List<Widget>();
  List<Widget> reversedCatalogueList = List<Widget>();

  Map _data;
  bool _isReversed;

  final PixelSize pixel = PixelSize();

  @override
  void initState() {
    super.initState();
    _data = widget.data;
    _isReversed = false;
    List.generate(
        catalogueData.length,
        (index) => catalogueList
            .add(_buildCatalogueItem(index, catalogueData[index])));
    reversedCatalogueList = catalogueList.reversed.toList();
  }

  /// 目录倒转
  void _handleCatalogueReverse() {
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
              vertical: pixel.setFontSize(10, context),
              horizontal: pixel.setFontSize(20, context)),
          child: Text('第${index + 1}章  $chapter', style: TextStyle(color:ZFColors.toolTextColor),),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: ZFColors.paperColor,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(
                  pixel.setWidth(20, context),
                  pixel.statusBarHeight(context) + 10,
                  pixel.setWidth(20, context),
                  pixel.setHeight(30, context)),
              color: ZFColors.toolBarColor,
              child: Stack(children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.network(
                      _data['imageUrl'],
                      width: pixel.setWidth(110, context),
                      fit: BoxFit.fitWidth,
                    ),
                    SizedBox(
                      width: pixel.setWidth(30, context),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _data['title'],
                          style: TextStyle(
                              fontSize: pixel.setFontSize(20, context),
                              fontWeight: FontWeight.w500),
                        ),
                        Text(_data['author']),
                        Text('共${_data['chapter']}章'),
                      ],
                    ),
                  ],
                ),
                Positioned(
                    right: 0,
                    bottom: 0,
                    child: InkWell(
                      child: Icon(
                        Icons.swap_vert,
                        size: pixel.setFontSize(26, context),
                        color: ZFColors.textColor,
                      ),
                      onTap: _handleCatalogueReverse,
                    ))
              ]),
            ),
            Expanded(
                child: ListView(
              children: _isReversed ? reversedCatalogueList : catalogueList,
            ))
          ],
        ));
  }
}
