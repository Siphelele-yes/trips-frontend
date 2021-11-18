import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trips/register.dart';
import 'package:trips/splashScreen.dart';
import 'home.dart';
import 'login.dart';

void main() {
  runApp(MaterialApp(home: MyApp(),));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Stack(children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset(
            "images/background.jpg",
            fit: BoxFit.fill,
          ),
        ),
        (_loginStatus==1)?SplashScreen():SplashScreen()
      ],),
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => new SignIn(),
        '/register': (BuildContext context) => new SignUp(),
        '/home':  (BuildContext context) =>  Trips()
      },
    );
  }
  var _loginStatus = 0;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
     // _loginStatus = preferences.getInt("value")!;
    });
  }
}

