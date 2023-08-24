import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:ppid_flutter/screens/screen.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

class WebViewV2Screen extends StatefulWidget {
  static const routeName = '/webview_v2';

  const WebViewV2Screen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WebViewV2ScreenState createState() => _WebViewV2ScreenState();
}

class _WebViewV2ScreenState extends State<WebViewV2Screen> {
  InAppWebViewController? webView;
  final GlobalKey webViewKey = GlobalKey();

  late String link;
  double progress = 0;
  bool showProgressBar = true;

  InAppWebViewController? webViewController;
  InAppWebViewSettings settings =
      InAppWebViewSettings(useOnDownloadStart: true);
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
        if (defaultTargetPlatform == TargetPlatform.android) {
          webViewController?.reload();
        } else if (defaultTargetPlatform == TargetPlatform.iOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: handleBackNavigation,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(""),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () async {
                if (webView != null) {
                  await webView!.reload();
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                Navigator.of(context).pushNamed(DashboardScreen.routeName);
              },
            ),
          ],
          bottom: showProgressBar
              ? PreferredSize(
                  preferredSize: const Size.fromHeight(3),
                  child: LinearProgressIndicator(
                    value: progress / 100,
                    backgroundColor: Colors.grey[300],
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                )
              : null,
        ),
        body: InAppWebView(
          key: webViewKey,
          initialUrlRequest: URLRequest(
            url: WebUri(link), // Use the link property
          ),
          initialSettings: settings,
          pullToRefreshController: pullToRefreshController,
          onWebViewCreated: (controller) {
            webView = controller;
          },
          onLoadStop: (controller, url) {
            showProgressBar = false;
            pullToRefreshController?.endRefreshing();
          },
          onReceivedError: (controller, request, error) {
            showProgressBar = false;
            pullToRefreshController?.endRefreshing();
          },
          onProgressChanged: (controller, progress) {
            setState(() {
              this.progress = progress.toDouble();
            });
            if (progress == 100) {
              showProgressBar = false;
              pullToRefreshController?.endRefreshing();
            } else {
              setState(() {
                showProgressBar = true;
              });
            }
          },
          onDownloadStartRequest: (controller, downloadRequest) async {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Downloading file...'),
                duration: Duration(seconds: 3), // Adjust the duration as needed
              ),
            );
            await FlutterDownloader.enqueue(
              url: downloadRequest.url.toString(),
              savedDir: (await getExternalStorageDirectory())!.path,
              saveInPublicStorage: true,
              showNotification:
                  true, // show download progress in status bar (for Android)
              openFileFromNotification:
                  true, // click on notification to open downloaded file (for Android)
            );
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
