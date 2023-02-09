import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:webview_windows/webview_windows.dart';

class HTMLViewerPage extends StatefulWidget {
  final String path;

  const HTMLViewerPage({
    Key? key,
    required this.path,
  }) : super(key: key);

  @override
  State<HTMLViewerPage> createState() => _HTMLViewerPageState();
}

class _HTMLViewerPageState extends State<HTMLViewerPage> {
  final _controller = WebviewController();

  @override
  void initState() {
    initPlatformState(widget.path);
    super.initState();
  }

  Future<void> initPlatformState(String url) async {
    if (Platform.isWindows) {
      try {
        await _controller.initialize();

        await _controller.setBackgroundColor(Colors.transparent);
        await _controller.setPopupWindowPolicy(WebviewPopupWindowPolicy.deny);
        await _controller.loadUrl(getAssetFileUrl(url));
        _controller.webMessage.listen((event) {
          print(event);
        });

        if (!mounted) return;
        setState(() {});
      } on PlatformException catch (e) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Container();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isWindows) {
      return _getWindows(_controller);
    }
    return _getMobile();
  }

  // Windows
  Widget _getWindows(WebviewController controller) {
    return Scaffold(
      appBar: AppBar(
          title: StreamBuilder<String>(
        stream: _controller.title,
        builder: (context, snapshot) {
          return Text(widget.path);
        },
      )),
      body: Center(
        child: Webview(
          _controller,
          permissionRequested: _onPermissionRequested,
        ),
      ),
    );
  }

  String getAssetFileUrl(String asset) {
    final assetsDirectory = p.join(p.dirname(Platform.resolvedExecutable),
        'data', 'flutter_assets', asset);
    return Uri.file(assetsDirectory).toString();
  }

  Future<WebviewPermissionDecision> _onPermissionRequested(
      String url, WebviewPermissionKind kind, bool isUserInitiated) async {
    return WebviewPermissionDecision.allow;
  }

  // Mobile
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
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel("flutter", onMessageReceived: (message) {
        print(message.message);
      });

    return Scaffold(
      body: WebViewWidget(controller: controller),
    );
  }
}
