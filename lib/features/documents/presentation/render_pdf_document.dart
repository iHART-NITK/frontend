import 'package:flutter/material.dart';
import '/core/network/django_app.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class DocumentPage extends StatefulWidget {
  const DocumentPage({Key? key}) : super(key: key);

  @override
  _DocumentPageState createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Test Document'),
            backgroundColor: Color.fromRGBO(181, 7, 23, 1),
            centerTitle: true),
        body: SfPdfViewer.network('http://10.0.2.2:8000/api/document/1'));
  }
}
