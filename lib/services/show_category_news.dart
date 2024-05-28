import 'dart:convert';

import 'package:news_app/model/Article_model.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/model/show_category_model.dart';

class Category_service{
  List<Selection_model> cat_service_list = [];

  Future<void> getselectedcat(String category)async{
    String url = 'https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=aaa62b9c1eb240dba2565d322e15e44b';

    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);

   if (jsonData['status']=='ok'){
    jsonData['articles'].forEach((element){
      if(element['urlToImage']!=null && element['description']!=null){
        Selection_model selection_model = Selection_model(
          title: element['title'],
          description: element['description'],
          url: element['url'],
          urlToImage: element['urlToImage'],
          content: element['content'],
          author: element['author']
        );
        cat_service_list.add(selection_model);
      }
    });
   }
  }

}