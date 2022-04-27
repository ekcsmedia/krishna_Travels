
import 'dart:async';

import 'package:flutter/material.dart';

const String LoggedInKey = 'LoggedIn';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    final size = query.size;
    final itemWidth = size.width*0.4;
    final itemHeight = itemWidth * (size.width / size.height);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
              children:[
                    Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Image.asset('assets/background.jpg',
                          width: itemWidth*3,height: itemHeight*5,),
                      ),
                    ),
                    SizedBox(
                      height:20
                    ),
                    Center(
                        child: Text("OM SRI KRISHNA TRAVELS",style: TextStyle(color:Theme.of(context).primaryColor ,
                        fontSize: 24,fontWeight: FontWeight.w700),)),
                SizedBox(
                    height:40
                ),
                Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Image.asset('assets/logo.png',
                          width: itemWidth,height: itemHeight,),
                      ),
                    ),
                Center(
                    child: Text("DEVELOPED BY KCS WEB TECHNOLOGIES",style: TextStyle(color:Theme.of(context).primaryColor ,
                        fontSize: 12,fontWeight: FontWeight.w700),)),

                  ]
              ),
        ),),);

  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Timer(const Duration(milliseconds: 2000), () {
      Navigator.pushReplacementNamed(
        context,
        '/signin',
      );
    });
  }
}