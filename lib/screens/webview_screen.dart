import 'package:flutter/material.dart';
import '../models/fooder_fetch_pages.dart';

import 'dart:io';

import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  final String pageTitle;

  static MaterialPage page(String url, String pageTitle) {
    return MaterialPage(
        name: FooderFetchPages.yeditepe,
        key: ValueKey(FooderFetchPages.yeditepe),
        child: WebViewScreen(url: url, pageTitle: pageTitle));
  }

  const WebViewScreen({Key? key, required this.url, required this.pageTitle})
      : super(key: key);

  @override
  WebViewScreenState createState() => WebViewScreenState();
}

class WebViewScreenState extends State<WebViewScreen> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pageTitle),
      ),
      body: WebView(
        initialUrl: widget.url,
      ),
    );
  }
}
