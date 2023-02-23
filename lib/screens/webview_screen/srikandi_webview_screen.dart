import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class SrikandiWebViewScreen extends StatefulWidget {
  const SrikandiWebViewScreen({Key? key}) : super(key: key);

  static const routeName = '/srikandi_webview';

  @override
  // ignore: library_private_types_in_public_api
  _SrikandiWebViewScreenState createState() => _SrikandiWebViewScreenState();
}

class _SrikandiWebViewScreenState extends State<SrikandiWebViewScreen> {
  InAppWebViewController? _controller;
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Srikandi Web View'),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshWebView,
        child: Stack(
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(
                url: Uri.parse('https://srikandi.arsip.go.id'),
              ),
              initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                  userAgent:
                      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.82 Safari/537.36',
                ),
              ),
              onWebViewCreated: (controller) {
                _controller = controller;
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
              },
            ),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _refreshWebView() async {
    if (_controller != null) {
      setState(() {
        _isLoading = true;
      });
      await _controller!.reload();
      setState(() {
        _isLoading = false;
      });
    }
  }
}
