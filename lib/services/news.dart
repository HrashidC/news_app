import 'dart:convert';
import 'package:news_app/model/Article_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class News {
  List<Article_model> news = [];

  Future<void> getnews({required String? query}) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    DateTime date = DateTime.now().subtract(const Duration(days: 30));
    var formattedDate = formatter.format(date);
    print(formattedDate.toString());
    String url = "https://newsapi.org/v2/everything?q=${query ?? 'tesla'}&from=$formattedDate&sortBy=publishedAt&apiKey=aaa62b9c1eb240dba2565d322e15e44b";

    try {
      var response = await http.get(Uri.parse(url));
      
      print(response.body);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

        if (jsonData['status'] == 'ok') {
          news.clear(); // Clear the previous articles
          jsonData['articles'].forEach((element) {
            Article_model article_model = Article_model(
              title: element['title'] ?? 'No Title',
              description: element['description'] ?? 'No Description available',
              url: element['url'] ?? '',
              urlToImage: element['urlToImage'] ?? 'https://via.placeholder.com/150', // Placeholder image
              content: element['content'] ?? 'Content not available',
              author: element['author'] ?? 'Unknown Author',
            );
            news.add(article_model);
          });
        } else {
          print("Error: ${jsonData['status']}");
        }
      } else {
        print("Failed to load data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("An error occurred: $e");
    }
  }
}
