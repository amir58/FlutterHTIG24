import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleWebview extends StatefulWidget {
  const ArticleWebview({super.key, required this.articleUrl});

  final String articleUrl;

  @override
  State<ArticleWebview> createState() => _ArticleWebviewState();
}

class _ArticleWebviewState extends State<ArticleWebview> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.articleUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("News")),
      body: WebViewWidget(controller: controller),
    );
  }
}
