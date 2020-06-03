import 'package:fiction/public/public.dart';
import 'package:flutter/material.dart';

class ReaderToolBar extends StatefulWidget {
  @override
  _ReaderToolBarState createState() => _ReaderToolBarState();
}

class _ReaderToolBarState extends State<ReaderToolBar> with PixelSize{

  Widget _buildTopBar() {
    return Container(
      height: kToolbarHeight + MediaQuery.of(context).padding.top,
      color: Colors.transparent,
      child: AppBar(
        leading: IconButton(
          icon: const Icon(Iconfont.zuo),
          iconSize: getPixe(26, context),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      
    );
  }
}