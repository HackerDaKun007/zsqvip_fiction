import 'package:fiction/public/public.dart';
import 'package:flutter/material.dart';

class BookDetailPage extends StatefulWidget {
  final arguments;
  BookDetailPage({this.arguments});

  @override
  _BookDetailPageState createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> with PixelSize {

  dynamic _data;

  @override
  void initState() {
    super.initState();
    _data = widget.arguments['data'];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          leading: IconButton(
            icon: Icon(Iconfont.zuo),
            iconSize: getPixe(26, context),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(_data['title']),
          pinned: true,
          floating: true,
          centerTitle: true,
        ),
        SliverPadding(
          padding: EdgeInsets.all(getPixe(10, context)),
          sliver: SliverToBoxAdapter(
            child: Container(
              height: 1200,
              width: getWidth(context),
              color: Colors.grey,
            ),
          ),
        )
      ],
    )
    );
  }
}
