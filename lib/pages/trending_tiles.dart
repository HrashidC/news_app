import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_app/model/Article_model.dart';
import 'package:news_app/pages/webview.dart';

class Trending_tiles extends StatelessWidget {
  Trending_tiles(
      {required this.imageUrl,
      required this.desc,
      required this.title,
      required this.url,
     required this.index,
      super.key});
  String imageUrl, title, desc,url;
  int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => WebView(blogurl: url),));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Material(
            borderRadius: BorderRadius.circular(10),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 10, horizontal: 2.1), //horizontal=5
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                           placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(color: Colors.red,),
                        ),
                              errorWidget: (context, url, error) => Image.asset('lib/assets/images/Img.png'),
                          imageUrl:imageUrl,
                          height: 120,
                          fit: BoxFit.cover,
                          width: 120,
                        )),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 1.7,
                        child: Text(
                        title,
                        maxLines: 2,
                      style: Theme.of(context).brightness == Brightness.dark ? TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15) : TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.7,
                        child: Text(
                          '$index $desc',
                          maxLines: 3,
                          style:Theme.of(context).brightness == Brightness.dark ? TextStyle(color: Colors.white30,fontWeight: FontWeight.w500,fontSize: 12) : TextStyle(color: Colors.black54,fontWeight: FontWeight.w500,fontSize: 12),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
