import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:news_app/model/slider_model.dart';
import 'package:http/http.dart' as http;

class Slide_api{
  List<Slider_model>Slideap = [];

  Future<void> getslider()async{
    String url = 'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=aaa62b9c1eb240dba2565d322e15e44b';
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);

    if(jsonData['status']== 'ok' ){
         Slideap.clear(); // Clear the previous sliders
      jsonData['articles'].forEach((element){
        if(element['urlToImage']!=null && element['description']!=null){
          Slider_model slider_model = Slider_model(
          title: element['title'],
          description: element['description'],
          url: element['url'],
          urlToImage: element['urlToImage'],
          content: element['content'],
          author: element['author']
          );
             Slideap.add(slider_model); 
        }
     
      });
    }

  }
}