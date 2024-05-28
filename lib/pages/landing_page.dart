import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_app/pages/home.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        
        margin: EdgeInsets.symmetric(horizontal: 8,),
        child: Column(
          children: [
            Material(
              elevation: 5,
              borderRadius:BorderRadius.circular(20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/landing.jpg',
                           width: MediaQuery.of(context).size.width,
                           height: MediaQuery.of(context).size.height/1.7,
                           fit: BoxFit.cover,),
              ),
            ),
            SizedBox(height: 30,),
          RichText(text: TextSpan(
            text:'Serving news Catered',
            style:Theme.of(context).brightness == Brightness.dark ? TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24) : TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 24),
            children: const <TextSpan>[
              TextSpan(
                text: '\n       to your needs',
                style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 24)
              ),
            ]
          )),SizedBox(height: 30,),
          Text('Focused on What Matters to You',style: TextStyle(color: Colors.grey,fontSize: 15,fontWeight: FontWeight.bold),),
          SizedBox(height: MediaQuery.of(context).size.height*0.08,),
          ElevatedButton(
            
            style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red),fixedSize: MaterialStatePropertyAll(Size(300, 50)),elevation: MaterialStatePropertyAll(5)),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home_Screen(),));
            },
             child: Text('Get started',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),))
          ],
        ),
      ),
    );
  }
}