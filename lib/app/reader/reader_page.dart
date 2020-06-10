/*
 * @author      Yuri Chen <pluto401zz@gmail.com> 
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         阅读页面 - 主页
*/

import 'package:fiction/app/ad/readerAd.dart';
import 'package:fiction/app/reader/reader_bottom_bar.dart';
import 'package:fiction/app/reader/reader_drawer.dart';
import 'package:fiction/app/reader/reader_tool_bar.dart';
import 'package:fiction/app/reader/reader_page_agent.dart';
import 'package:fiction/app/reader/article_model.dart';
import 'package:fiction/public/public.dart';
import 'package:fiction/res/articleData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReaderPage extends StatefulWidget {
  final arguments;
  ReaderPage({this.arguments});

  @override
  _ReaderPageState createState() => _ReaderPageState();
}

class _ReaderPageState extends State<ReaderPage> {
  double textSize = 20;
  bool isVisible = false;
  dynamic _data;
  final PixelSize pixel = PixelSize();
  PageController _pageController = PageController(keepPage: false);
  int _pageCount = 0;
  int _currentPage = 0;
  int _articleIndex = 0;
  Article preArticle;
  Article currentArticle;
  Article nextArticle;

  getArticle(int index) {
    Map data = articleData[index];
    Article _article = Article.fromJson(data);
    double contentHeight = pixel.screenHeightDp(context) -
        (pixel.statusBarHeight(context) +
            kToolbarHeight +
            pixel.setHeight(170, context) +
            pixel.setHeight(50, context));
    double contentWidth = pixel.screenWidthDp(context);
    _article.pageOffsets = ReaderPageAgent.getPageOffsets(
        _article.content, contentHeight, contentWidth, pixel.setFontSize(textSize, context));
    return _article;
  }

  @override
  void initState() {
    super.initState();
    _pageController.addListener(onScroll);
    _data = widget.arguments['data'];
    currentArticle = getArticle(_articleIndex);
    preArticle = getPreArticle(_articleIndex);
    nextArticle = getNextArticle(_articleIndex);
    _pageCount = currentArticle.pageCount;

    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  }

  /// 屏幕点击监听
  onTapHandler(Offset position) {
    double xRate = position.dx / pixel.screenWidthDp(context);
    if (xRate > 0.33 && xRate < 0.66) {
      systemStatusBarHandler();
    } else if (xRate >= 0.66) {
      nextPage();
    } else {
      previousPage();
    }
  }

  /// 上一页
  previousPage() {
    if (_currentPage == 0 && _articleIndex == 0) {
      print('已经是第一页了');
      return;
    }
    _pageController.previousPage(duration: Duration(milliseconds: 250), curve: Curves.easeOut);
  }

  /// 下一页
  nextPage() {
    if (_currentPage >= currentArticle.pageCount - 1 && _articleIndex == 0) {
      print('已经是最后一页了');
      return;
    }
    _pageController.nextPage(duration: Duration(milliseconds: 250), curve: Curves.easeOut);
  }


  getPreArticle(int index) {
    Article _article;
    _article = index > 0 ? getArticle(index - 1) : null;
    return _article;
  }

  getNextArticle(int index) {
    Article _article;
    _article = index < articleData.length ? getArticle(index + 1) : null;
    return _article;
  }

  /// 系统状态栏的状态
  void systemStatusBarHandler() {
    setState(() {
      isVisible = !isVisible;
      isVisible
          ? SystemChrome.setEnabledSystemUIOverlays(
              [SystemUiOverlay.top, SystemUiOverlay.bottom])
          : SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    });
  }

  /// 监听页面滚动
  onScroll() {
    var page = _pageController.offset / pixel.screenWidthDp(context);

    var nextArtilePage = currentArticle.pageCount + (preArticle != null ? preArticle.pageCount : 0);
    if (page >= nextArtilePage) {
      print('到达下个章节了');
      _currentPage = 0;
      preArticle = currentArticle;
      currentArticle = nextArticle;
      nextArticle = null;
      _pageController.jumpToPage(preArticle.pageCount);
      // fetchNextArticle(currentArticle.nextArticleId);
      setState(() {});
    }
    if (preArticle != null && page <= preArticle.pageCount - 1) {
      print('到达上个章节了');

      nextArticle = currentArticle;
      currentArticle = preArticle;
      _currentPage = currentArticle.pageCount - 1;
      preArticle = null;

      _pageController.jumpToPage(currentArticle.pageCount - 1);
      // fetchPreviousArticle(currentArticle.preArticleId);
      setState(() {});
    }
  }

  /// 文章内容
  Widget _buildContent() {
    return Container(
      width: pixel.screenWidthDp(context),
      height: pixel.screenHeightDp(context)+pixel.bottomBarHeight(context),
      color: ZFColors.paperColor,
      child: Column(children: [
        Expanded(
          child: _buildPage(),
        ),
         ReaderAd(),
      ]),
    );
  }

  /// 监听页面切换
  onPageChanged(int index) {
    var page = index - (preArticle != null ? preArticle.pageCount : 0);
    if (page < currentArticle.pageCount && page >= 0) {
      setState(() {
        _currentPage = page;
      });
    } 
    
  }
 /// 页面
  Widget buildPage(BuildContext context, int index) {
    var page = index - (preArticle != null ? preArticle.pageCount : 0);
    var article;
    if (page >= this.currentArticle.pageCount) {
      // 到达下一章了
      article = nextArticle;
      page = 0;
    } else if (page < 0) {
      // 到达上一章了
      article = preArticle;
      page = preArticle.pageCount - 1;
      _pageCount = article.pageCount;
    } else {
      article = this.currentArticle;
      _pageCount = article.pageCount;
    }

    return GestureDetector(
        onTapUp: (TapUpDetails details) {
          onTapHandler(details.globalPosition);
        },
        child: buildContent(article, page));
  }

  buildContent(Article article, int page) {
    var content = article.stringAtPageIndex(page);

    if (content.startsWith('\n')) {
      content = content.substring(1);
    }
    return Container(
        height: pixel.screenHeightDp(context)+pixel.bottomBarHeight(context),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        padding: EdgeInsets.only(left: pixel.setFontSize(20, context)),
        height: pixel.statusBarHeight(context) +
            kToolbarHeight -
            pixel.setFontSize(30, context),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            currentArticle.title,
            style: TextStyle(
                fontSize: pixel.setFontSize(12, context),
                color: ZFColors.textColor),
          ),
        ),
      ),
      Expanded(
        child: Container(
          padding: EdgeInsets.only(
            left: pixel.setFontSize(20, context),
            right: pixel.setFontSize(20, context),
          ),
          child: Container(
              child: Text.rich(
            TextSpan(children: [
              TextSpan(
                  text: content,
                  style: TextStyle(
                      fontSize: pixel.setFontSize(textSize, context),
                      color: ZFColors.textColor,
                      height: 1.7,
                      letterSpacing: 1.7))
            ]),
            textAlign: TextAlign.justify,
          )),
        ),
      ),
      Container(
        padding: EdgeInsets.fromLTRB(pixel.setFontSize(20, context), 0, 0, 0),
        height: pixel.setHeight(40, context),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '${_currentPage + 1}/$_pageCount',
              style: TextStyle(
                  fontSize: pixel.setFontSize(12, context),
                  color: ZFColors.textColor),
            )),
      ),
    ]));
  }

  _buildPage() {
    if (currentArticle == null) {
      return Container();
    }

    int itemCount = (preArticle != null ? preArticle.pageCount : 0) +
        currentArticle.pageCount +
        (nextArticle != null ? nextArticle.pageCount : 0);

    return PageView.builder(
      physics: BouncingScrollPhysics(),
      controller: _pageController,
      itemCount: itemCount,
      itemBuilder: buildPage,
      onPageChanged: onPageChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ZFColors.paperColor,
      drawer: Drawer(
        child: ReaderDrawer(data: _data),
      ),
      drawerEdgeDragWidth: 0.0,
      body: Stack(children: [ 
        GestureDetector(
          onTapUp: (TapUpDetails details) {
            onTapHandler(details.globalPosition);
          },
          child: _buildContent(),
        ),
        Positioned(
          top: isVisible
              ? 0
              : -(pixel.statusBarHeight(context) + kToolbarHeight),
          child: ReaderToolBar(),
        ),
        Positioned(
            bottom: isVisible
                ? 0
                : -(pixel.bottomBarHeight(context) +
                    pixel.setHeight(250, context)),
            child: BottomBar(
              data: _data,
            ))
      ]),
    );
  }
}
