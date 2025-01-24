import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable, camel_case_types
class WebView extends StatefulWidget {
  final url;
  const WebView({super.key, required this.url});

  @override
  State<WebView> createState() => _WebViewState();
  String get getUrl => url;
}

class _WebViewState extends State<WebView> {
  late var controller;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WebView"),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
