import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'package:shared_preferences/shared_preferences.dart';
class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  late String name,username, password,surname;
  bool isLoading=false;
  GlobalKey<ScaffoldState>_scaffoldKey=GlobalKey();
  late ScaffoldMessengerState scaffoldMessenger ;
  var reg=RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  TextEditingController _nameController=new TextEditingController();
  TextEditingController _surnameController=new TextEditingController();
  TextEditingController _usernameController=new TextEditingController();
  TextEditingController _passwordController=new TextEditingController();
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
                        height: 20,
                      ),
                      Text(
                        "Sign Up",
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
                                controller: _nameController,

                                decoration: InputDecoration(

                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red)),
                                  hintText: "Name",
                                  hintStyle: TextStyle(
                                      color: Colors.indigo, fontSize: 15),
                                ),
                                onSaved: (val) {
                                  name = val!;
                                },
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                style: TextStyle(
                                  color: Colors.indigo,
                                ),
                                controller: _surnameController,

                                decoration: InputDecoration(

                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red)),
                                  hintText: "Surname",
                                  hintStyle: TextStyle(
                                      color: Colors.indigo, fontSize: 15),
                                ),
                                onSaved: (val) {
                                  surname = val!;
                                },
                              ),

                              SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                style: TextStyle(
                                  color: Colors.indigo,
                                ),
                                controller: _usernameController,

                                decoration: InputDecoration(

                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red)),
                                  hintText: "Email",
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
                              TextFormField(
                                style: TextStyle(
                                  color: Colors.indigo,
                                ),
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red)),
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                      color: Colors.indigo, fontSize: 15),
                                ),
                                onSaved: (val) {
                                  password = val!;
                                },
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Stack(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 0),
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.red),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: InkWell(
                                      onTap: (){
                                        if(isLoading)
                                        {
                                          return;
                                        }
                                        if(_nameController.text.isEmpty)
                                        {
                                          scaffoldMessenger.showSnackBar(SnackBar(content:Text("Please Enter Name")));
                                          return;
                                        }
                                        if(_surnameController.text.isEmpty)
                                        {
                                          scaffoldMessenger.showSnackBar(SnackBar(content:Text("Please Enter Surname")));
                                          return;
                                        }
                                        if(!reg.hasMatch(_usernameController.text))
                                        {
                                          scaffoldMessenger.showSnackBar(SnackBar(content:Text("Enter Valid Email")));
                                          return;
                                        }
                                        if(_passwordController.text.isEmpty||_passwordController.text.length<6)
                                        {
                                          scaffoldMessenger.showSnackBar(SnackBar(content:Text("Password should be min 6 characters")));
                                          return;
                                        }
                                        signup(_nameController.text,_usernameController.text,_passwordController.text,_surnameController.text);
                                      },
                                      child: Text(
                                        "CREATE ACCOUNT",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                                color: Colors.indigo,
                                                fontSize: 16,
                                                letterSpacing: 1)),
                                      ),
                                    ),
                                  ),
                                  Positioned(child: (isLoading)?Center(child: Container(height:26,width: 26,child: CircularProgressIndicator(backgroundColor: Colors.green,))):Container(),right: 30,bottom: 0,top: 0,)

                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, "/login");
                        },
                        child: Text(
                          "Already have an account?",
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  color: Colors.indigo,
                                  fontSize: 13,
                                  decoration: TextDecoration.underline,
                                  letterSpacing: 0.5)),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  signup(name,username,password,surname) async {
    setState(() {
      isLoading = true;
    });
    var url = Uri.parse("http://localhost:8080/api/register-user");
    final header = {
      "Content-Type": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    };

    print("Calling");

    var data = {
      'username': username,
      'password': password,
      'name': name,
      'surname': surname
    };

    print(data);
    final response = await post(url,
        headers: header,
        body: data
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 201) {
      setState(() {
        isLoading = false;
      });
      final Map parsed = json.decode(response.body);
      print(parsed);

      Map user=parsed;
      print(" User name ${user['name']}");
      savePref(1,user['name'],user['surname'],user['username'],user['id']);
      Navigator.pushReplacementNamed(context, "/login");

    } else {
      scaffoldMessenger.showSnackBar(SnackBar(content:Text("Please Try again")));
    }
  }
  savePref(int value, String name,String surname, String username, int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setInt("value", value);
    preferences.setString("name", name);
    preferences.setString("surname", surname);
    preferences.setString("username", username);
    preferences.setString("id", id.toString());
    preferences.commit();
  }
}
