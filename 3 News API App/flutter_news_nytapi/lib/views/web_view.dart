import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewWidget extends StatelessWidget {
  final String url;

  WebViewWidget({this.url});

  @override
  Widget build(BuildContext context) {
    print(url);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.exit_to_app),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
        child: WebView(
          initialUrl: url,
        ),
      ),
    );
  }
}
