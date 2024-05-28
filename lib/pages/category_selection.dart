import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_app/model/show_category_model.dart';
import 'package:news_app/pages/webview.dart';
import 'package:news_app/services/show_category_news.dart';

class Cat_Selection extends StatefulWidget {
  String name;
   Cat_Selection({super.key,required this.name});

  @override
  State<Cat_Selection> createState() => _Cat_SelectionState();
}

class _Cat_SelectionState extends State<Cat_Selection> {
  List<Selection_model> selected = [];
   bool _loading = true;

     void initState() {
    super.initState();
        getcat();
  }

  getcat()async{
    Category_service category_service = Category_service();
    await category_service.getselectedcat(widget.name.toLowerCase());
    selected = category_service.cat_service_list;//saving in list
    setState(() {
      _loading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
         appBar: AppBar(
        title: Text(widget.name,
        style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 18),)
      ),
      body:  
      Container(
                child: 
                ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: selected.length,
                  itemBuilder: (context, index) {
                  return
                  ShowCategory(
                    url: selected[index].url!,
                    Image: selected[index].urlToImage!, 
                  desc: selected[index].description!, 
                  title: selected[index].title!);
                },),
              )
    );
  }
}

class ShowCategory extends StatelessWidget {
  String Image,desc,title,url;
   ShowCategory({required this.Image,required this.desc,required this.title,required this.url});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => WebView(blogurl: url),));
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(imageUrl: Image,
                width: MediaQuery.of(context).size.width,
                height: 200,
                fit: BoxFit.cover,
                ),
              ),
              Text(title,maxLines: 2,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
              SizedBox(height: 2,),
              Text(desc,maxLines: 3,)
            ],
          ),
        ),
      ),
    );
  }
}