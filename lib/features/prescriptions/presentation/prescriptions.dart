import 'package:flutter/material.dart';
import 'package:frontend/features/prescriptions/data/get_prescriptions.dart';

class PrescriptionsPage extends StatefulWidget {
  @override
  _PrescriptionsPageState createState() => _PrescriptionsPageState();
}

class _PrescriptionsPageState extends State<PrescriptionsPage> {
  @override
  Widget build(BuildContext context) {
    GetPrescriptions _getPrescriptions = new GetPrescriptions();
    final Future<List<dynamic>> _response = _getPrescriptions.getData();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Prescriptions'),
          backgroundColor: Color.fromRGBO(181, 7, 23, 1),
        ),
        body: FutureBuilder<List<dynamic>>(
            future: _response,
            builder:
                (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
                children = <Widget>[];
                snapshot.data?.forEach((presc) {
                  children.add(prescriptionCard(presc));
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
            }));
  }
}

Widget prescriptionCard(presc) {
  return Card(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: SizedBox(
                  width: 5,
                ),
              ),
              Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'MEDICINE',
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '${presc["inventory"].toString()}',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'DIAGNOSIS',
                        style: TextStyle(fontSize: 8, color: Colors.grey),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '${presc["diagnosis"]}',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  )),
              Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: 5,
                  )),
              Expanded(
                  flex: 6,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'DOSAGE',
                          style: TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '${presc["dosage"].toString()}',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'UNITS TO BUY',
                          style: TextStyle(fontSize: 8, color: Colors.grey),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '${presc["medicine_units"]}',
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                      ]))
            ]),
      ));
}
