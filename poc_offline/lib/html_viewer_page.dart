import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HTMLViewerPage extends StatefulWidget {
  final String fileHtmlContents;
  final String path;

  const HTMLViewerPage({
    Key? key,
    required this.fileHtmlContents,
    required this.path,
  }) : super(key: key);

  @override
  State<HTMLViewerPage> createState() => _HTMLViewerPageState();
}

class _HTMLViewerPageState extends State<HTMLViewerPage> {
  @override
  Widget build(BuildContext context) {
    final webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadFlutterAsset(widget.path);
    return Scaffold(
      appBar: AppBar(),
      body: WebViewWidget(controller: webViewController),
    );
  }
}
