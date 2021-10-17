import 'package:flutter/material.dart';
import 'package:frontend/features/medical_history/data/medical.dart';

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
        body: DefaultTextStyle(
      style: Theme.of(context).textTheme.headline2!,
      textAlign: TextAlign.center,
      child: FutureBuilder<dynamic>(
        future: _hash, // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = <Widget>[];
            snapshot.data?.forEach((history) {
              children.add(
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Category: ${history["category"]}\nDescription: ${history["description"]}',
                      
                    ),
                  ),
                ),
              );
            });
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              )
            ];
          } else {
            children = const <Widget>[
              SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              )
            ];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
          );
        },
      ),
    ));
  }
}
