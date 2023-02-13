import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:poc_offline/pdf_viewer_page.dart';

import 'html_viewer_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final pdfFiles = [
    "2015-pengo-publication.pdf",
    "2017-holtman-publication.pdf",
    "acl-top-50-series-case-study-summary-usa.pdf",
    "acl-top-family-50-series-brochure.pdf",
    "acltop-family-sell-sheet-300.pdf",
    "clin-econ-impact-platelet-function-testing-neurointervention.pdf",
    "rotem-pocket-booklet-kja.pdf",
    "ROTEMsigma-WHO-PBM-policy-brief.pdf",
    "thrombosis-research-t-warkentin-performance.pdf",
  ];

  final htmlFiles = [
    "acl-top-50-series-family",
    "gem-premier-5000",
    "gem-premier-chemstat",
    "hemocell",
    "iqm2",
    "video-html",
    "hemostasis-calc"
  ];

  final String _title = 'PoC Offline';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(child: Text("PDF", style: TextStyle(fontSize: 24),)),
          ),
          ...pdfFiles.map((filename) => ListTile(title: Text(filename), onTap: () async {
            final path = "assets/contents/$filename";
            final file = await loadAsset(path);
            openPdf(context, file);
          })),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(child: Text("HTML", style: TextStyle(fontSize: 24),)),
          ),
          ...htmlFiles.map((filename) => ListTile(
              title: Text(filename),
              onTap: () async {
                final path = "assets/contents/$filename/index.html";
                String fileHtmlContents = await rootBundle.loadString(path);
                openHTML(context, fileHtmlContents, path);
              })),
        ],
      ),
    );
  }

  Future<File> loadAsset(String path) async {
    final data = await rootBundle.load(path);
    final bytes = data.buffer.asUint8List();
    return _storeFile(path, bytes);
  }

  Future<File> _storeFile(String url, List<int> bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }

  void openPdf(BuildContext context, File file) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => PDFViewerPage(file: file)));

  void openHTML(BuildContext context, String fileHtmlContents, String path) =>
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => HTMLViewerPage(fileHtmlContents: fileHtmlContents, path: path)));

}
