import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/news_model.dart';
import '../constants.dart';

class NewsService {
  List<Article> news = [];

  Future<void> getAll() async {
    String url =
        'https://newsapi.org/v2/top-headlines?country=id&category=business&apiKey=b301ce890b9d40608eb6d50f1638451b';

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          Article article = new Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publishedAt: DateTime.parse(element['publishedAt']),
            content: element['content'],
            articleUrl: element['url'],
          );

          news.add(article);
        }
      });
    }
  }
}
