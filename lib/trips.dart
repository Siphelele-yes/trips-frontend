import 'package:flutter/material.dart';
import 'UI/nav_drawer.dart';

class WebViewExample extends StatefulWidget {
  const WebViewExample({Key? key}) : super(key: key);
  @override
  createState() => Trips();

}

class Trips extends State<WebViewExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Trips'),
      ),
    );
  }
}