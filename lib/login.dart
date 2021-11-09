import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trips/register.dart';
import 'package:trips/user.dart';
import 'package:trips/trips.dart';
import 'package:http/http.dart' as http;

import 'UI/input_field.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super (key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>{

  final _formKey = GlobalKey<FormState>();
  User user = User("", "");
  var url = Uri.parse("http://localhost:8080/register");

  Future save() async {
    var res = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
            {'email': user.email,
              'password': user.password}
              )
    );
    print(res.body);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      //Scaffold
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
        image: DecorationImage(
        image: AssetImage("images/background.jpg"),
        fit: BoxFit.cover,
        ),
        ),
        child: Stack(
          key: _formKey,
          children: <Widget>[
            Center(
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Material(
                      child: Image.asset(
                        "images/logo.png",
                        alignment: AlignmentDirectional.topCenter,
                      ),
                    ),
                    TextFormField(
                      cursorColor: Colors.grey,
                      textAlign: TextAlign.center,
                      controller: TextEditingController(text: user.email),
                      onChanged: (val) {
                        user.email = val;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email is Empty';
                        }
                        return null;
                      },
                      style: const TextStyle(fontSize: 20, color: Colors.grey),
                      decoration: const InputDecoration(
                          errorStyle:
                          TextStyle(fontSize: 20, color: Colors.grey),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.indigo)),
                        hintText: 'Email',
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 10,
                      color: Colors.white,
                    ),
                    TextFormField(

                      textAlign: TextAlign.center,
                      cursorColor: Colors.grey,
                      obscureText: true,
                      controller:
                      TextEditingController(text: user.password),
                      onChanged: (val) {
                        user.password = val;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password is Empty';
                        }
                        return null;
                      },
                      style: const TextStyle(fontSize: 20, color: Colors.grey),
                      decoration: const InputDecoration(
                          errorStyle:
                          TextStyle(fontSize: 20, color: Colors.grey),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.indigo)),
                        hintText: 'Password',
                      ),
                    ),
                    Container(
                      height: 10,
                      color: Colors.white,
                    ),
                    Container(
                      margin: const EdgeInsets.all(25),
                      // ignore: deprecated_member_use
                      child: FlatButton(
                        child: const Text('LOGIN', style: TextStyle(fontSize: 15.0),),
                        color: Colors.indigo,
                        textColor: Colors.white,
                        onPressed: () {
                          save();

                        },
                      ),
                    ),
                    const Text(
                      "Don't have an Account ?",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.indigo),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}