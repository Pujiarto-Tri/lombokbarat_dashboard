import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class SrikandiWebViewScreen extends StatefulWidget {
  const SrikandiWebViewScreen({Key? key}) : super(key: key);

  static const routeName = '/srikandi_webview';

  @override
  // ignore: library_private_types_in_public_api
  _SrikandiWebViewScreenState createState() => _SrikandiWebViewScreenState();
}

class _SrikandiWebViewScreenState extends State<SrikandiWebViewScreen> {
  final GlobalKey srikandiWebViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  InAppWebViewSettings settings = InAppWebViewSettings();
  PullToRefreshController? pullToRefreshController;
  PullToRefreshSettings pullToRefreshSettings = PullToRefreshSettings(
    color: Colors.blue,
  );
  bool pullToRefreshEnabled = true;
  bool _isLoading = true;

  Future<bool> _goBack() async {
    if (await webViewController?.canGoBack() ?? false) {
      webViewController?.goBack();
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    settings.userAgent =
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3';

    pullToRefreshController = kIsWeb
        ? null
        : PullToRefreshController(
            settings: pullToRefreshSettings,
            onRefresh: () async {
              if (defaultTargetPlatform == TargetPlatform.android) {
                webViewController?.reload();
              } else if (defaultTargetPlatform == TargetPlatform.iOS) {
                webViewController?.loadUrl(
                    urlRequest:
                        URLRequest(url: await webViewController?.getUrl()));
              }
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _goBack,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Srikandi'),
        ),
        body: Column(
          children: <Widget>[
            if (_isLoading)
              LinearProgressIndicator(
                backgroundColor: Colors.grey[200],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            Expanded(
              key: srikandiWebViewKey,
              child: InAppWebView(
                initialUrlRequest:
                    URLRequest(url: WebUri("https://srikandi.arsip.go.id/")),
                initialSettings: settings,
                pullToRefreshController: pullToRefreshController,
                onWebViewCreated: (InAppWebViewController controller) {
                  webViewController = controller;
                },
                onLoadStart: (controller, url) {
                  setState(() {
                    _isLoading = true;
                  });
                },
                onLoadStop: (controller, url) {
                  setState(() {
                    _isLoading = false;
                  });
                  pullToRefreshController?.endRefreshing();
                },
                onReceivedError: (controller, request, error) {
                  setState(() {
                    _isLoading = false;
                  });
                  pullToRefreshController?.endRefreshing();
                },
                onProgressChanged: (controller, progress) {
                  if (progress == 100) {
                    setState(() {
                      _isLoading = false;
                    });
                    pullToRefreshController?.endRefreshing();
                  } else {
                    setState(() {
                      _isLoading = true;
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
