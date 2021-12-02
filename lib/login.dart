import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  late String username, password;
  bool _isChecked = false;
  bool isLoading=false;
  TextEditingController _usernameController=new TextEditingController();
  TextEditingController _passwordController=new TextEditingController();
  GlobalKey<ScaffoldState>_scaffoldKey=GlobalKey();
  late ScaffoldMessengerState scaffoldMessenger ;

  @override
  void initState() {
    _loadUserEmailPassword();
    super.initState();
  }

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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Center(
                          child: Image.asset(
                            "images/logo.png",
                            height: 200,
                            width: 200,
                            alignment: Alignment.center,
                          )),
                      SizedBox(
                        height: 13,
                      ),
                      Text(
                        "Sign In",
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
                                controller: _usernameController,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red)),
                                  hintText: "Username/Email",
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 15),
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
                                      color: Colors.grey, fontSize: 15),
                                ),
                                onSaved: (val) {
                                  username = val!;
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  alignment: Alignment.topRight,
                                  child: Row(
                                      children: <Widget>[
                                        Checkbox(
                                            activeColor: Colors.grey,
                                            value: _isChecked,
                                            onChanged: _handleRememberMe),
                                        Text("Remember Me",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 12,
                                                fontFamily: 'Rubic')
                                        ),
                                      ],
                                  ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if(isLoading)
                                      {
                                        return;
                                      }
                                      if(_usernameController.text.isEmpty||_passwordController.text.isEmpty)
                                      {
                                        scaffoldMessenger.showSnackBar(SnackBar(content:Text("Please Fill all fileds")));
                                        return;
                                      }
                                      login(_usernameController.text,_passwordController.text);
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
                                        "SUBMIT",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                                color: Colors.indigo,
                                                fontSize: 16,
                                                letterSpacing: 1)),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    child: (isLoading)?
                                    Center(
                                        child: Container(
                                            alignment: Alignment.center,
                                            height:26,width: 26,
                                            child: CircularProgressIndicator(
                                              backgroundColor: Colors.indigo,
                                            )
                                        ),
                                    )
                                        :Container(),right: 30,bottom: 0,top: 0,)

                                ],
                              )

                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(context, "/forgotPassword");
                            },
                            child: Text(
                              "Forgot Password",
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      color: Colors.red,
                                      fontSize: 13,
                                      decoration: TextDecoration.underline,
                                      letterSpacing: 0.5)),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, "/register");
                        },
                        child: Text(
                          "Don't have an account?",
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

  login(username,password,) async {
    var url = Uri.parse("http://localhost:8080/api/login-user");
    final header = {
      "Content-Type": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    };

    var data = {
      'username': username,
      'password': password
    };

    final response = await post(url,
        headers: header,
        body: data,
    );
    if (response.statusCode == 200) {
      setState(() {
        isLoading=false;
      });
      final Map res = jsonDecode(response.body);
      Map user=res;

      print(" User name ${user['name']}");
      savePref(1,user['name'],user['surname'],user['username'],user['id']);
      scaffoldMessenger.showSnackBar(SnackBar(content:Text("Login successful!")));
      Navigator.pushReplacementNamed(context, "/home");

    } else if(response.statusCode == 403){
      scaffoldMessenger.showSnackBar(SnackBar(content:Text("Incorrect Username or Password.Please try again!")));
    }else{
      scaffoldMessenger.showSnackBar(SnackBar(content:Text("An error has occured.Please try again!")));
    }



  }
  savePref(int value, String name,String surname, String username, int id) async {
    SharedPreferences.getInstance().then(
        (prefs){
          prefs.setInt("value", value);
          prefs.setString("username", username);
          prefs.setString("name", name);
          prefs.setString("surname", surname);
        }
    );
  }

  void _handleRememberMe(bool? value) {
    _isChecked = value!;
    SharedPreferences.getInstance().then(
          (prefs) {
        prefs.setBool("remember_me", value);
        prefs.setString('username', _usernameController.text);
        prefs.setString('password', _passwordController.text);
      },
    );
    setState(() {
      _isChecked = value;
    });
  }

  void _loadUserEmailPassword() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      var _username = _prefs.getString("username") ?? "";
      var _password = _prefs.getString("password") ?? "";
      var _rememberMe = _prefs.getBool("remember_me") ?? false;
      print(_rememberMe);
      print(_username);
      print(_password);
      if (_rememberMe) {
        setState(() {
          _isChecked = true;
        });
        _usernameController.text = _username ?? "";
        _passwordController.text = _password ?? "";
      }
    } catch (e)
    {
      print(e);
    }
  }
}

