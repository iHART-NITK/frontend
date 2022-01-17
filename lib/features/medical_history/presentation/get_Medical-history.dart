import 'package:flutter/material.dart';
import '/features/medical_history/data/medical.dart';

class GetMed extends StatefulWidget {
  @override
  _GetMedState createState() => _GetMedState();
}

class _GetMedState extends State<GetMed> {
  @override
  Widget build(BuildContext context) {
    History history = new History();
    final Future<dynamic> _hash = history.getMed();
    return Scaffold(
        appBar: AppBar(title: const Text('Medical History')),
        body: DefaultTextStyle(
            style: Theme.of(context).textTheme.headline2!,
            textAlign: TextAlign.center,
            child: FutureBuilder<dynamic>(
                future: _hash, // a previously-obtained Future<String> or null
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  List<Widget> children;
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      children = <Widget>[
                        Center(
                            child: Text('No Medical History to show!',
                                style: TextStyle(fontSize: 20))),
                      ];
                    } else {
                      children = <Widget>[];
                      snapshot.data?.forEach((history) {
                        children.add(Container(
                          margin: const EdgeInsets.all(10.0),
                          padding: const EdgeInsets.all(5.0),
                          decoration: new BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              new BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5.0,
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Color.fromRGBO(181, 7, 23, 1),
                            ),
                            title: Text(
                              history["category"],
                            ),
                            subtitle: Text(
                              history["description"],
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
                    children = const <Widget>[
                      Center(
                        child: SizedBox(
                          child: CircularProgressIndicator(),
                          width: 60,
                          height: 60,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text('Awaiting result...'),
                      )
                    ];
                  }
                  return ListView(
                    controller: ScrollController(),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    children: children,
                  );
                })));
  }
}
