import 'package:flutter/material.dart';
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
            child: Center(
                child: Text(
              "PDF",
              style: TextStyle(fontSize: 24),
            )),
          ),
          ...pdfFiles.map((filename) => ListTile(
              title: Text(filename),
              onTap: () async {
                final path = "assets/contents/$filename";
                openHTML(context, path);
              })),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
                child: Text(
              "HTML",
              style: TextStyle(fontSize: 24),
            )),
          ),
          ...htmlFiles.map((filename) => ListTile(
              title: Text(filename),
              onTap: () async {
                final path = "assets/contents/$filename/index.html";
                openHTML(context, path);
              })),
        ],
      ),
    );
  }

  void openHTML(BuildContext context, String path) =>
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => HTMLViewerPage(path: path)));
}
