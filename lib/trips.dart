import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'UI/nav_drawer.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewExample extends StatefulWidget {
  final url;
  final title;
  const WebViewExample(this.url, this.title);
  @override
  createState() => Trips(this.url, this.title);

}

class Trips extends State<WebViewExample> {

  var _url;
  var _title;
  final _key = UniqueKey();
  Trips(this._url, this._title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Trips'),
      ),
      body: Column(
        children: [
          Expanded(
            child: WebView(
              key: _key,
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: _url,
            ),
          ),
        ],
      ),
    );
  }
}