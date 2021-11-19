import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'package:shared_preferences/shared_preferences.dart';
class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPassword createState() => _ForgotPassword();
}

class _ForgotPassword extends State<ForgotPassword> {

  final _formKey = GlobalKey<FormState>();
  late String username;
  bool isLoading=false;
  GlobalKey<ScaffoldState>_scaffoldKey=GlobalKey();
  late ScaffoldMessengerState scaffoldMessenger ;
  var reg=RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  TextEditingController _userNameController=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Image.asset(
                    "images/background.jpg",
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                          child: Image.asset(
                            "images/logo.png",
                            height: 30,
                            width: 30,
                            alignment: Alignment.center,
                          )),
                      SizedBox(
                        height: 13,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        "Forgot Password",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            color: Colors.indigo,
                            letterSpacing: 1,
                            fontSize: 23,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Form(
                        key: _formKey,
                        child: Container(
                          margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 45),
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                style: TextStyle(
                                  color: Colors.indigo,
                                ),
                                controller: _userNameController,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red)),
                                  hintText: "Username/Email",
                                  hintStyle: TextStyle(
                                      color: Colors.indigo, fontSize: 15),
                                ),
                                onSaved: (val) {
                                  username = val!;
                                },
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Stack(
                                children: [
                                  GestureDetector(
                                  onTap: () {
                                    if(isLoading){
                                      return;
                                    }
                      if(_userNameController.text.isEmpty) {
                      scaffoldMessenger.showSnackBar(SnackBar(content:Text("Please Fill all fileds")));
                      return;
                      }
                      forgotPassword(_userNameController.text);
                      setState(() {
                      isLoading=true;
                      });
                      //Navigator.pushReplacementNamed(context, "/home");
                      },
                        child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 0),
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.indigo),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            "Send Email",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: Colors.indigo,
                                    fontSize: 16,
                                    letterSpacing: 1)),
                          ),
                        ),
                      ),
                              ],
                              ),
                        ],
                      ),
                  ),
                ),
              ],
            ),
          ),
        ],
    ),
    ),),
    );
  }

  forgotPassword(String username) async {

    var url = Uri.parse("http://localhost:8080/api/forgotPassword");
    final header = {
      "Content-Type": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    };

    var data = {
      'username': username,
    };

    final response = await post(url,
      headers: header,
      body: data,
    );
  }
}
