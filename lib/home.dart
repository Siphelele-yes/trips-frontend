import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Trips extends StatefulWidget {
  @override
  _TripsState createState() => _TripsState();
}

class _TripsState extends State<Trips> {

  late SharedPreferences preferences;
  late var name = getPref().toString();
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        leading: InkWell(child: Icon(Icons.compare_arrows),onTap: () async {

          Navigator.pushReplacementNamed(context, "/login");
        },),
        title: Text(
          " Welcome to Trips.",
          style: GoogleFonts.roboto(
              textStyle: TextStyle(fontSize: 18, letterSpacing: 1)),
        ),
      ),
    );
  }

   getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String? name = preferences.getString('name');
    if(name!.isNotEmpty) {
      return name;
    }
  }
}
