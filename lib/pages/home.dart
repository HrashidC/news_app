import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_app/model/Article_model.dart';
import 'package:news_app/model/category_model.dart';
import 'package:news_app/model/slider_model.dart';
import 'package:news_app/pages/allnews.dart';
import 'package:news_app/pages/category_selection.dart';
import 'package:news_app/pages/landing_page.dart';
import 'package:news_app/pages/trending_tiles.dart';
import 'package:news_app/pages/webview.dart';
import 'package:news_app/services/data.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:news_app/services/news.dart';
import 'package:news_app/services/slider_data.dart';
import 'package:news_app/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  bool _loading = true;
  List<Category_model> categories = [];
  List<Slider_model> slide = [];
  List<Article_model> articles = [];
  int activeindex = 0;
  @override
  void initState() {
    getSlider(); //function to store carousels
    categories = getCategories(); //function that stores list of category
    getNews();
    super.initState();
  }

  
 
  Future<void> getNews() async {
    setState(() {
      _loading = true;
    });

    // Create a dynamic URL
    String url = "https://newsapi.org/v2/everything?q=tesla&from=${DateTime.now().subtract(Duration(days: 1)).toIso8601String()}&sortBy=publishedAt&apiKey=aaa62b9c1eb240dba2565d322e15e44b";

    News newclass = News();
    await newclass.getnews(query: "tesla");
   

    setState(() {
      articles = newclass.news; //saving in list
      _loading = false;
    });
  }
   Future<void> getNewsWithNewQuery({required String query}) async {
  setState(() {
    _loading = true;
  });
  News newclass = News();
  await newclass.getnews(query: query);
  setState(() {
    articles = newclass.news;
    _loading = false;
  });
}

 Future<void> getSlider() async {
  setState(() {
    _loading = true;
  });
  Slide_api slide_api = Slide_api();
  await slide_api.getslider();
  setState(() {
    slide = slide_api.Slideap;
    _loading = false;
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Text('Daily'),
            // Text(
            //   'News',
            //   style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            // ),
            RichText(text: TextSpan(text: 'Daily',style:Theme.of(context).brightness == Brightness.dark?TextStyle(color: Colors.white,fontSize: 22) : TextStyle(color: Colors.black,fontSize: 22),
            children: <TextSpan>[
              TextSpan(
                text: 'News',
                style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold)
              )
            ])),
            IconButton(onPressed: (){
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            }, icon: Icon(Icons.dark_mode_outlined)),
            IconButton(onPressed: ()async{
              await getNewsWithNewQuery(query: 'tesla'); 
            }, icon: Icon(Icons.replay_outlined))
          ],
        ),
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(
              color: Colors.red,
            ))
          : SingleChildScrollView(
              child: Container(
                // margin: EdgeInsets.only(left: 10),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      height: 70,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Category(
                            image: categories[index].image,
                            categoryName: categories[index].categoryName,
                          );
                        },
                        itemCount: categories.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Breaking News',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          GestureDetector(
                            onTap: () {
                              
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => viewAll(news: "Breaking"),));
                            },
                            child: Text(
                              'Know more',
                              style: TextStyle(
                                  color: Colors.red, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Slider_Webview(
                            slideurl: slide[activeindex].url!,
                          ),
                        ));
                      },
                      child: CarouselSlider.builder(
                          itemCount: slide.length,
                          itemBuilder: (context, index, realIndex) {
                            String? res = slide[index].urlToImage;
                            String? res1 = slide[index].title;

                            return buidslides(res!, index, res1!);
                          },
                          options: CarouselOptions(
                            height: 220,
                            // viewportFraction: 1,
                            enlargeCenterPage: true,
                            autoPlay: true,
                            enlargeStrategy: CenterPageEnlargeStrategy.height,
                            onPageChanged: (index, reason) {
                              setState(() {
                                activeindex = index;
                              });
                            },
                          )),
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    buildindicator(),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Trending News!',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          GestureDetector(
                              onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => viewAll(news: "Trending"),));
                            },
                            child: Text(
                              'Know more',
                              style: TextStyle(
                                  color: Colors.red, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    //trending tiles
                    
                    Container(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: articles.length,
                        itemBuilder: (context, index) {
                          print(articles.length);
                          return Trending_tiles(
                            index: index,
                              url: articles[index].url!,
                              imageUrl: articles[index].urlToImage!,
                              desc: articles[index].description!,
                              title: articles[index].title!);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  Widget buidslides(String image, int index, String name) => GestureDetector(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 3),
          child: Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    errorWidget: (context, url, error) => Image.asset('lib\assets\images\Img.png'),
                    height: 220,
                    imageUrl: image,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                  )),
              Container(
                // height: 300,
                margin: EdgeInsets.only(top: 150),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.black26,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 3),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Text(
                      name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
              )
            ],
          ),
        ),
      );
  Widget buildindicator() => AnimatedSmoothIndicator(
        activeIndex: activeindex,
        count: 5,
        effect: SlideEffect(
            activeDotColor: Colors.red,
            dotColor: Colors.grey,
            dotHeight: 12,
            dotWidth: 12),
      );
}

class Category extends StatelessWidget {
  const Category({super.key, this.image, this.categoryName});
  final image;
  final categoryName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Cat_Selection(name: categoryName),
        ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                image,
                width: 120,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: 120,
              height: 70,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color:Colors.black38 ),
              // color: Colors.black38,
              child: Center(
                  child: Text(
                categoryName,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              )),
            )
          ],
        ),
      ),
    );
  }
}
