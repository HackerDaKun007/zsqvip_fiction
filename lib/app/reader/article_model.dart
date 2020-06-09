class Article {
  int id;
  int novelId;
  String title;
  String content;
  int price;
  int index;
  int nextArticleId;
  int preArticleId;

  List<Map<String, int>> pageOffsets;

  Article.fromJson(Map data) {
    id = data['id'];
    novelId = data['novel_id'];
    title = data['title'];
    content = data['content'];
    content = '\u3000\u3000' + content;
    content = content.replaceAll('\n', '\n\u3000\u3000');
    content = '$title\n\n' + content;
    price = data['price'];
    index = data['index'];
    nextArticleId = data['next_id'];
    preArticleId = data['prev_id'];
  }

  String stringAtPageIndex(int index) {
    var offset = pageOffsets[index];
    return this.content.substring(offset['start'], offset['end']);
  }

  int get pageCount {
    return pageOffsets.length;
  }
}