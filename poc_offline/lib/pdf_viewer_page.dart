import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:pdfx/pdfx.dart';

class PDFViewerPage extends StatefulWidget {
  final File file;

  const PDFViewerPage({Key? key, required this.file}) : super(key: key);

  @override
  State<PDFViewerPage> createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {

  @override
  Widget build(BuildContext context) {
    final pdfController = PdfController(
      document:
      PdfDocument.openFile(widget.file.path),
      viewportFraction: 1,
    );
    final name = basename(widget.file.path);
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: PdfView(
        controller: pdfController,
        scrollDirection: Axis.vertical,
      ),
    );
  }
}
