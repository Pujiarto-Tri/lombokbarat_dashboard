import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ppid_flutter/screens/screen.dart';

class WebViewScreen extends StatefulWidget {
  static const routeName = '/webview_v2';

  const WebViewScreen({super.key});

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController _controller;
  late String link;
  double progress = 0;
  bool showProgressBar = true;
  Timer? _progressUpdateTimer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    link = args['link']!; // Set the link property

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              this.progress = progress.toDouble();
              showProgressBar = progress < 100;
            });
          },
          onPageStarted: (String url) {
            setState(() {
              showProgressBar = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              showProgressBar = false;
            });
          },
          onHttpError: (HttpResponseError error) {
            setState(() {
              showProgressBar = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            setState(() {
              showProgressBar = false;
            });
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            // Handle specific file downloads here
            if (request.url.endsWith('.pdf') || request.url.endsWith('.zip')) {
              _downloadFile(request.url);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(link));
  }

  void _downloadFile(String url) async {
    final directory = await getExternalStorageDirectory();
    final savedDir = directory!.path;

    // Throttle progress updates
    if (_progressUpdateTimer != null && _progressUpdateTimer!.isActive) {
      _progressUpdateTimer!.cancel();
    }
    _progressUpdateTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      FlutterDownloader.loadTasks().then((tasks) {
        // Handle the tasks safely
        final task = tasks?.firstWhere(
          (t) => t.url == url,
          orElse: () => DownloadTask(
              taskId: '',
              url: url,
              filename: '',
              savedDir: savedDir,
              status: DownloadTaskStatus.undefined,
              progress: 0,
              timeCreated: 1,
              allowCellular: true),
        );

        if (task != null && task.taskId != '1') {
          setState(() {
            progress = task.progress.toDouble();
            showProgressBar = task.status == DownloadTaskStatus.running;
          });
        } else {
          // Handle the case where the task is not found or is empty
          setState(() {
            showProgressBar = false;
          });
        }
      });
    });

    await FlutterDownloader.enqueue(
      url: url,
      savedDir: savedDir,
      fileName: url.split('/').last,
      showNotification:
          true, // show download progress in status bar (for Android)
      openFileFromNotification:
          true, // click on notification to open downloaded file (for Android)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WebView"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              await _controller.reload();
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
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              )
            : null,
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
