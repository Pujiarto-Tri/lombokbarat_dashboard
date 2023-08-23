//================================================
//DO NOT USE THIS
//STILL IN DEVELOPMENT
//=============================================

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewV2Screen extends StatefulWidget {
  static const routeName = '/webview_v2';

  const WebViewV2Screen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WebViewV2ScreenState createState() => _WebViewV2ScreenState();
}

class _WebViewV2ScreenState extends State<WebViewV2Screen> {
  InAppWebViewController? webView;
  late String link;
  // Declare the link property

  InAppWebViewController? webViewController;
  InAppWebViewSettings settings = InAppWebViewSettings();
  PullToRefreshController? pullToRefreshController;
  PullToRefreshSettings pullToRefreshSettings = PullToRefreshSettings(
    color: Colors.blue,
  );
  bool pullToRefreshEnabled = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    link = args['link']!; // Set the link property
  }

  @override
  void initState() {
    super.initState();
    pullToRefreshController = PullToRefreshController(
      settings: pullToRefreshSettings,
      onRefresh: () async {
        if (webViewController != null) {
          await webViewController!.reload();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: handleBackNavigation,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(""),
        ),
        body: InAppWebView(
          initialUrlRequest: URLRequest(
            url: WebUri(link), // Use the link property
          ),
          initialSettings: settings,
          pullToRefreshController: pullToRefreshController,
          onWebViewCreated: (controller) {
            webView = controller;
          },
          onLoadStop: (controller, url) {
            pullToRefreshController?.endRefreshing();
          },
          onReceivedError: (controller, request, error) {
            pullToRefreshController?.endRefreshing();
          },
          onProgressChanged: (controller, progress) {
            if (progress == 100) {
              pullToRefreshController?.endRefreshing();
            }
          },
        ),
      ),
    );
  }

  Future<bool> handleBackNavigation() async {
    if (webView != null && await webView!.canGoBack()) {
      webView!.goBack();
      return false; // Prevent default system back navigation
    }
    return true; // Allow default system back navigation
  }
}
