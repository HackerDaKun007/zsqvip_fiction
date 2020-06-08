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

String articleContent =
    '<h3>第1章：点名要她</h3><p>　“音音啊，你爸爸病倒，现在还在ICU，我们都不能进去探望他呜呜呜……”</p><p>　　“音音，他们趁你爸爸生病弄了一批辐射珠宝。”</p><p>　　“音音，你爸爸当初给你杜叔叔做担保，你杜叔叔破产，公司被冻结，银行要你爸爸赔三亿。”</p><p>　　……</p><p>　　电话里的哭诉一声比一声凄惨和绝望。</p><p>　　回应电话的是“笃笃笃”有规律的刀与砧板碰撞的声音。</p><p>　　少女的手机远远放在与操作台相连的木质饭桌上，少女系着围裙，乌黑长发高挽，修长的身体站在砧板前，手起刀落，手法娴熟迅速的用刀背敲打着鱼肉面。</p><p>　　少女的手机远远放在与操作台相连的木质饭桌上，少女系着围裙，乌黑长发高挽，修长的身体站在砧板前，手起刀落，手法娴熟迅速的用刀背敲打着鱼肉面。</p><p>　　电话那头的方美娴哭了半晌，没有得到女儿一言半语的回应，停下了抽泣声，听到了熟悉的声音，顿时怒火高涨。</p><p>　　“郦唯音，你有没有良心，你爸进了ICU面临破产，你妈妈和妹妹都快流落街头，你还有心情做菜！”</p><p>　　尖锐的指责声，让郦唯音停下了手上的动作，她看了看鱼肉，放下了刀，拿了一把钢精匙，同时伸手把手机抓近一些。</p>';
String content =
    "第1章：点名要她“音音啊，你爸爸病倒，现在还在ICU，我们都不能进去探望他呜呜呜……”　　“音音，他们趁你爸爸生病弄了一批辐射珠宝。”　　“音音，你爸爸当初给你杜叔叔做担保，你杜叔叔破产，公司被冻结，银行要你爸爸赔三亿。”　　……　　电话里的哭诉一声比一声凄惨和绝望。　　回应电话的是“笃笃笃”有规律的刀与砧板碰撞的声音。　　少女的手机远远放在与操作台相连的木质饭桌上，少女系着围裙，乌黑长发高挽，修长的身体站在砧板前，手起刀落，手法娴熟迅速的用刀背敲打着鱼肉面。　　电话那头的方美娴哭了半晌，没有得到女儿一言半语的回应，停下了抽泣声，听到了熟悉的声音，顿时怒火高涨。　　“郦唯音，你有没有良心，你爸进了ICU面临破产，你妈妈和妹妹都快流落街头，你还有心情做菜！”　　尖锐的指责声，让郦唯音停下了手上的动作，她看了看鱼肉，放下了刀，拿了一把钢精匙，同时伸手把手机抓近一些。　　“妈，你说吧，你要我怎么做。”　　她的声音清清泠泠，像山涧里潺潺流动的细水，也透着山野的冷寂。　　郦唯音比谁都了解她的母亲，在父母眼里她就是个只知道吃喝玩乐的废物，发生天大的事情，他们都不会想起她，只有当她能够发挥价值的时候，他们才会想起。　　她曾经一度怀疑她是抱养，为此还在有积蓄之后，拿了父母的头发丝去做亲子鉴定。　　结果不言而喻，她是亲生无疑，只不过她不得他们欢心而已。　　她弯着身，用钢精匙细心地将敲烂的鱼肉从鱼皮上刮下来，对于自己即将被待价而沽，表现得很漠然。　　本来理直气壮的方美娴，一下子变得心虚起来，尤其是电话那边静悄悄的，似乎女儿已经停下手，她反而更加紧张。　　坐在方美娴旁边的郦唯心握住了母亲的手，给她一个鼓励的眼神。　　方美娴心口一暖，镇定下来：“音音，许夫人你知道吗？她找过我，想和我们家联姻，只要我们能够成为亲家，银行那三亿，许家可以代替我们还上。”　　果然，郦唯音唇角微扬，她的唇瓣天生有丝柔迷人的唇线，让冷刺的笑容都别又韵味：“许夫人，津城第一家的许夫人，这么好的婚事，心心也成年了呀。”　　“你妹妹才刚刚十九岁，还在读书呢！”方美娴立刻拔高声音，语气里浓浓的不满，连声数落，“你怎么这么不懂事，家里从小让你养尊处优，现在家里出了事儿，你就想着让你妹妹来出力，她还那么小！”　　嗯，十九岁的郦唯心还那么小，二十二岁的她就是很大。　　“我只是觉得我这么粗俗无礼又野性难驯，许家高门大户，应该只看得上心心这样乖巧懂事的名媛淑女。”　　这是方美娴对她两个女儿的评价。　　“许夫人亲口说，她想给儿子娶你。”这句话方美娴没有说谎。　　郦唯音是许夫人点名要她，别说家里遇上了危机，就算顺顺当当的时候，谁敢得罪华国第一女强人许夫人？　　以下是作者的罗里吧嗦，放在题外话怕有些人忽视，反正第一章不会收费，就多说几句。　　关于尊重，我觉得是互相。　　我的文写出来，可以不喜欢，毕竟萝卜青菜各有所爱，但是不喜欢不是可以伤害的理由，它好好长在这里，没有去招惹谁，希望觉得不和胃口的读者静静来，默默离开。　　关于评论评分，我也希望故意要给个差评的读者能够慎重一点，不要和我杠，说评论是读者的自由，读者有评论权，让我有本事令书城取消赋予你们的权利。　　我就一个小作者，没有那个权利，但我必须告诉有这样想法的读者，你有权利评论，看着不喜欢就差评，我也有书城给的禁言删帖权利，我看不爽你的评论，我也有资格删。　　别到时候双标，认为你评论是自由，我删帖禁言就是专制听不进去意见。　　评分对于书很重要，希望大家都能给个五星好评，不喜欢的可以不评分，我就感激不尽。　　要提意见，首先给善意，没有善意的意见，抱歉我不接受。　　最后是关于更新，我基本是年产200万字＋，任何作者开始都勤奋，是因为文灵感好，后面可能会忽高忽低，请不要把多更加更暴更当做理所当然，少更偶尔请假当做不可原谅。　　我尽最大努力更新，实在更新不出来，总不能水文，谁都有忙的时候，生病的时候，疲惫的时候，互相理解，和谐看文。　　最后注明本文美食文，部分菜谱来自于文献，非我原创，以免以后被指抄袭，每道菜占字数不超过150字。　　以上就是作者一些废话，不爱看的就自动略过。";

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

  getArticle(int index)  {
    Map data = articleData[index];
    Article _article = Article.fromJson(data);
    double contentHeight = pixel.screenHeightDp(context) - (pixel.statusBarHeight(context) + kToolbarHeight + pixel.setHeight(170, context) + pixel.setFontSize(30, context));
    double contentWidth = pixel.screenWidthDp(context);
    _article.pageOffsets = ReaderPageAgent.getPageOffsets(_article.content, contentHeight, contentWidth, 20);
  
    return _article;
  }



  @override
  void initState() {
    super.initState();
    _data = widget.arguments['data'];
    currentArticle = getArticle(_articleIndex);
    _pageCount = currentArticle.pageCount;

    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  onTapHandler(Offset position) {
    double xRate = position.dx / pixel.screenWidthDp(context);
    if (xRate > 0.33 && xRate < 0.66) {
      systemStatusBarHandler();
    } else if (xRate >= 0.66) {}
  }

  getPreArticle(int index) {
    Article _article;
    _article = index > 0 ?? getArticle(index-1);
    return _article;
  }

  getNextArticle(int index) {
    Article _article;
    currentArticle = index < articleData.length ?? getArticle(index+1);
    return _article;
  }

  /// 系统状态栏的状态
  void systemStatusBarHandler() {
    setState(() {
      isVisible = !isVisible;
      isVisible
          ? SystemChrome.setEnabledSystemUIOverlays(
              [SystemUiOverlay.top, SystemUiOverlay.bottom])
          : SystemChrome.setEnabledSystemUIOverlays([]);
    });
  }

  /// 文章内容
  Widget _buildContent() {
    return Container(
      width: pixel.screenWidthDp(context),
      height: pixel.screenHeightDp(context),
      color: ZFColors.paperColor,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: EdgeInsets.only(left:pixel.setFontSize(20, context)),
          height: pixel.statusBarHeight(context) + kToolbarHeight - pixel.setFontSize(30, context),
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
              child: _buildPage()
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(pixel.setFontSize(20, context),0,0,0),
          height: pixel.setHeight(40, context),
          child:Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '${_currentPage + 1}/$_pageCount',
              style: TextStyle(
                  fontSize: pixel.setFontSize(12, context),
                  color: ZFColors.textColor),
            )
          ),
        ),
        ReaderAd()
      ]),
    );
  }

  onPageChanged(int index) {
    var page = index - (preArticle != null ? preArticle.pageCount : 0);
    if (page < currentArticle.pageCount && page >= 0) {
      setState(() {
        _currentPage = page;
      });
    } else if (page >= currentArticle.pageCount -1) {
      setState(() {
        currentArticle = getNextArticle(_articleIndex);
        _articleIndex++;
      });
    }
  }

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
    } else {
      article = this.currentArticle;
    }

    return GestureDetector(
        onTapUp: (TapUpDetails details) {
          onTapHandler(details.globalPosition);
        },
        child: buildContent(article, _currentPage));
  }

  buildContent(Article article, int page) {
    var content = article.stringAtPageIndex(page);

    if (content.startsWith('\n')) {
      content = content.substring(1);
    }
    return Text.rich(
      TextSpan(children: [
        TextSpan(
            text: content,
            style: TextStyle(
              fontSize: pixel.setFontSize(textSize, context),
              height: 1.7,
              letterSpacing: 1.7
            ))
      ]),
      textAlign: TextAlign.justify,
    );
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
