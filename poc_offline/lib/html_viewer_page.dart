import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:webview_windows/webview_windows.dart';

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
    if (Platform.isWindows) {
      return _getWindows();
    }
    if (kIsWeb) {
      return _getWeb();
    }
    return _getMobile();
  }

  Widget _getWindows() {
    final controller = WebviewController();
    controller.initialize();
    controller.loadUrl(widget.path);

    return Scaffold(
      body: Webview(controller),
    );
  }

  Widget _getWeb() {
    return Container();
  }

  Widget _getMobile() {
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    controller
      ..enableZoom(false)
      ..loadFlutterAsset(widget.path)
      ..setJavaScriptMode(JavaScriptMode.unrestricted);

    return Scaffold(
      body: WebViewWidget(controller: controller),
    );
  }
}
