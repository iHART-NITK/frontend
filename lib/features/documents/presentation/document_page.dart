import 'package:flutter/material.dart';

import '/features/documents/data/get_all_documents.dart';
import '/features/documents/presentation/document_widget.dart';

class DocumentPage extends StatefulWidget {
  const DocumentPage({Key? key}) : super(key: key);

  @override
  _DocumentPageState createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {
  @override
  Widget build(BuildContext context) {
    final Future<List<dynamic>> _response = FetchDocuments().get();
    return Scaffold(
        appBar: AppBar(title: const Text('Documents')),
        body: FutureBuilder<List<dynamic>>(
            future: _response,
            builder:
                (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  children = const <Widget>[
                    Center(
                      child: Text(
                        'No Documents to show!',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ];
                } else {
                  children = <Widget>[];
                  snapshot.data?.forEach((document) {
                    children.add(InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DocumentWidget(
                                    document["id"], document["filename"])));
                      },
                      child: Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                                title: Text(document["filename"]),
                                subtitle: Text(
                                    "Size: ${(int.parse(document["filesize"]) / 1000).toStringAsFixed(2)} KB"))
                          ],
                        ),
                      ),
                    ));
                  });
                }
              } else if (snapshot.hasError) {
                children = <Widget>[
                  const Icon(
                    Icons.error_outline,
                    color: Color.fromRGBO(181, 7, 23, 1),
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text('Error: ${snapshot.error}'),
                  )
                ];
              } else {
                children = <Widget>[
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: CircularProgressIndicator(),
                          width: 60,
                          height: 60,
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text("Awaiting Result...")),
                      ],
                    ),
                  ),
                ];
              }
              return ListView(
                controller: ScrollController(),
                padding: const EdgeInsets.symmetric(vertical: 15),
                children: children,
              );
            }));
  }
}
