import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/models/article.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticlePage extends StatelessWidget {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  ArticlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    final Completer<WebViewController> _controller =
        Completer<WebViewController>();
    Article article = Article(
      id: 1,
      title: "Enam Teknik Mencuci Mobil yang Benar, Jangan Asal!",
      category: "Otomotif",
      imageURL: "https://i.imgur.com/9waAALi.jpg",
      webURL: "http://id.wikipedia.org/wiki/Rantai_blok",
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          splashRadius: 24,
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Artikel"),
        titleTextStyle: AppStyle.title3Text.copyWith(color: Colors.white),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
        elevation: 2,
      ),
      body: WebView(
        initialUrl: article.webURL,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) async {
          _controller.complete(webViewController);
        },
        gestureNavigationEnabled: true,
      ),
    );
  }
}
