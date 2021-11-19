import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreen createState() => _SplashScreen();
}
class _SplashScreen extends State<SplashScreen> {
  bool isLoading=true;
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 10),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                    SignIn()
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
           child: Stack(
            children: <Widget>[
            Container(
              width: double.infinity,
              height: double.infinity,
            child: Image.asset("images/background.jpg",
              fit: BoxFit.fill,
              ),
            ),
             Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Welcome to Trips",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        color: Colors.indigo,
                        letterSpacing: 1,
                        fontSize: 26,
                      ),
                    ),
                  ),
                  Center(
                   child: Image.asset("images/logo.png",
                     height: 120,
                     width: 120,
                    alignment: Alignment.center,),
                      ),
                  Positioned(child: (isLoading)?Center(child: Container(height:26,width: 26,child: CircularProgressIndicator(backgroundColor: Colors.indigo,))):Container(),right: 30,bottom: 0,top: 0,)
                ],
                  ),
                ),
          ],
        ),
      ),),
    );
  }
}

