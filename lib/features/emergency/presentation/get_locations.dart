import 'package:flutter/material.dart';
import 'package:frontend/features/emergency/data/locations.dart';

class GetLocations extends StatefulWidget {
  @override
  _GetLocationsState createState() => _GetLocationsState();
}

class _GetLocationsState extends State<GetLocations> {
  @override
  Widget build(BuildContext context) {
    Location location = new Location();
    final Future<dynamic> _hash = location.getLocations();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Locations'),
        backgroundColor: Color.fromRGBO(181, 7, 23, 1),
      ),
      body: FutureBuilder<dynamic>(
          future: _hash, // a previously-obtained Future<String> or null
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              children = <Widget>[];
              snapshot.data?.forEach((key, value) {
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
                      value,
                    ),
                  ),
                ));
              });
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
            return ListView(
              controller: ScrollController(),
              padding: const EdgeInsets.symmetric(vertical: 15),
              children: children,
            );
          }),
    );
  }
}
