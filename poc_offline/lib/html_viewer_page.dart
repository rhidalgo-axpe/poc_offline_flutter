import 'dart:html';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

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
    if (kIsWeb) {
      // ignore: undefined_prefixed_name
      ui.platformViewRegistry.registerViewFactory(widget.path, (int viewId) {
        return IFrameElement()
          ..style.width = '100%'
          ..style.height = '100%'
          ..src = widget.path
          ..style.border = 'none';
      });
      return HtmlElementView(viewType: widget.path);
    }
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
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel("flutter", onMessageReceived: (message) {
        print(message.message);
      });

    return Scaffold(
      body: WebViewWidget(controller: controller),
    );
  }
}
