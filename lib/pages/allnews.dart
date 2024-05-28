import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model/Article_model.dart';
import 'package:news_app/model/slider_model.dart';
import 'package:news_app/pages/webview.dart';
import 'package:news_app/services/news.dart';
import 'package:news_app/services/slider_data.dart';

class viewAll extends StatefulWidget {
  String news;
   viewAll({required this.news,super.key});

  @override
  State<viewAll> createState() => _viewAllState();
}

class _viewAllState extends State<viewAll> {
    List<Slider_model> slide = [];
  List<Article_model> articles = [];

   void initState() {
    getSlider();//function to store carousels
    getNews();
    super.initState();
  }
  
  getNews()async{
    News newclass = News();
    await newclass.getnews(query: 'apple');
    articles = newclass.news;//saving in list
    setState(() {
      
    });
  
  }

  getSlider()async{
    Slide_api slide_api = Slide_api();
    await slide_api.getslider();
    slide = slide_api.Slideap;
    setState(() {
      
    });
    
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text(widget.news+ "News",
        style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 18),)
      ),
      body: Container(
        child: ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount:widget.news == "Breaking"? slide.length:articles.length,
                  itemBuilder: (context, index) {
                  return
                  Allnewssection(
                    url:widget.news == "Breaking"? slide[index].url!:articles[index].url!,
                    Image:widget.news == "Breaking"? slide[index].urlToImage!:articles[index].urlToImage!, 
                  desc: widget.news == "Breaking"? slide[index].description!:articles[index].description!, 
                  title:widget.news == "Breaking"? slide[index].title!:articles[index].title!);
                },),
      ),
    );
  }
}
class Allnewssection extends StatelessWidget {
  String Image,desc,title,url;
   Allnewssection({required this.Image,required this.desc,required this.title,required this.url});

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