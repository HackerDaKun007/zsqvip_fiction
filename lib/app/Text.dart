import 'package:flutter/material.dart';
// import 'package:flutter_loading/Toast.dart';

class MyHomePage extends StatefulWidget {
  // MyHomePage({Key key, this.title}) : super(key: key);
  final String title = '加载动画';
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _childLayout(),
    );
  }

  Widget _childLayout() {
    return Center(
      child: RaisedButton(
        onPressed: () => _onRefresh(),
        child: Text('显示加载动画'),
      ),
    );
  }

   _onRefresh()  {
    ProgressDialog(loading: true, child: _childLayout());
    // await Future.delayed(Duration(seconds: 3), () {
    //   setState(() {
    //     _loading = false;
    //     // Toast.show(context, "加载完成");
    //     ProgressDialog(loading: false, child: _childLayout());
    //     print('123');
    //   });
    // });
  }
}

class ProgressDialog extends StatelessWidget {
  final bool loading;
  final Widget child;
  ProgressDialog({Key key, @required this.loading, @required this.child})
      : assert(child != null),
        assert(loading != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    widgetList.add(child); //假如正在加载，则显示加载增加加载中布局
    if (loading) {
      widgetList.add(Center(
        child: CircularProgressIndicator(),
      ));
    }
    return Stack(
      children: widgetList,
    );
  }
}
