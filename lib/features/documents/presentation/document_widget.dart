import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '/core/network/django_app.dart';

class DocumentWidget extends StatefulWidget {
  final int docId;
  final String docName;
  DocumentWidget(this.docId, this.docName);

  @override
  _DocumentWidgetState createState() =>
      _DocumentWidgetState(this.docId, this.docName);
}

class _DocumentWidgetState extends State<DocumentWidget> {
  final int docId;
  final String docName;
  _DocumentWidgetState(this.docId, this.docName);
  @override
  Widget build(BuildContext context) {
    var box = Hive.box('user');
    return Scaffold(
      appBar: AppBar(title: Text(this.docName)),
      body: SfPdfViewer.network(
        'http://${DjangoApp.host}:${DjangoApp.port}/api/document/${this.docId}',
        headers: {"Authorization": "Token ${box.get(0).token}"},
      ),
    );
  }
}
