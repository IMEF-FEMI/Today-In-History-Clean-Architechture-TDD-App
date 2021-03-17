import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'dart:io';

import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String url;

  const WebViewPage({Key key, @required this.url}) : super(key: key);
  @override
  WebViewPageState createState() => WebViewPageState();
}

class WebViewPageState extends State<WebViewPage> {
  bool pageLoaded = false;
  int progress = 0;
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Today in History"),
        centerTitle: true,
        backgroundColor: Color(0xff3c3395),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              LinearProgressIndicator(
                value: progress.toDouble(),
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor,
                ),
              ),
              Expanded(
                child: WebView(
                  onProgress: (value) {
                    setState(() {
                      progress = value;
                      print(value);
                    });
                  },
                  onPageFinished: (_) {
                    setState(() {
                      pageLoaded = true;
                    });
                  },
                  initialUrl: widget.url,
                ),
              ),
            ],
          ),
          if (!pageLoaded)
            Align(
              alignment: Alignment.center,
              child: LottieBuilder.asset(
                'assets/animations/lottie/loading-screen-loader-spinning-circle.json',
                width: MediaQuery.of(context).size.width * 0.35,
                repeat: true,
              ),
            ),
        ],
      ),
    );
  }
}
