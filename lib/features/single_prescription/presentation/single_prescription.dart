import 'package:flutter/material.dart';
import 'package:frontend/features/single_prescription/data/get_single_prescription.dart';

class PrescriptionPage extends StatefulWidget {
  final int appointment_no;
  PrescriptionPage({Key? key, required this.appointment_no}) : super(key: key);
  @override
  _PrescriptionPageState createState() => _PrescriptionPageState();
}

class _PrescriptionPageState extends State<PrescriptionPage> {
  @override
  Widget build(BuildContext context) {
    final Future<List<dynamic>> _prescriptionResponse =
        GetSinglePrescription().getData(widget.appointment_no);
    final Future<Map<String, dynamic>> _appointmentResponse =
        GetAppointmentInfo().getData(widget.appointment_no);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Prescription'),
          backgroundColor: Color.fromRGBO(181, 7, 23, 1),
        ),
        body: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            child: Center(
                child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Health Care Center NITK",
                      style: TextStyle(fontSize: 30),
                    )
                  ],
                ),
                Divider(),
                SizedBox(height: 20),
                (FutureBuilder(
                    future: _appointmentResponse,
                    builder: (BuildContext context,
                        AsyncSnapshot<Map<String, dynamic>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Row(
                          children: [Text("Fetching Data...")],
                        );
                      }
                      if (snapshot.hasData) {
                        return Row(children: [
                          Text('Date: ${snapshot.data?["date"]}'),
                          Spacer(),
                          Text('Doctor: ${snapshot.data?["doctor_name"]}'),
                        ]);
                      } else if (snapshot.hasError) {
                        return Row(children: [
                          Text("Error while fetching information!"),
                        ]);
                      }
                      return Row(children: [
                        Text("No valid data."),
                      ]);
                    })),
                SizedBox(
                  height: 10,
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                (FutureBuilder(
                    future: _prescriptionResponse,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<dynamic>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Row(
                          children: [Text("Fetching Data...")],
                        );
                      }
                      if (snapshot.hasData) {
                        List<Widget> rows = <Widget>[];
                        rows.add(Row(children: [
                          Container(
                              width: 200,
                              child: Text("DIAGNOSIS",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ))),
                          Container(
                              width: 200,
                              child: Text("MEDICATION",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ))),
                          Container(
                              width: 200,
                              child: Text("DOSAGE",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ))),
                        ]));
                        rows.add(Divider());
                        snapshot.data?.forEach((presc) {
                          rows.add(Row(children: [
                            Container(
                                width: 200, child: Text(presc["diagnosis"])),
                            Container(
                                width: 200, child: Text(presc["inventory"])),
                            Container(width: 200, child: Text(presc["dosage"])),
                          ]));
                        });
                        return Row(children: [
                          Column(
                            children: rows,
                          )
                        ]);
                      } else if (snapshot.hasError) {
                        return Row(children: [
                          Text("Error while fetching information!")
                        ]);
                      } else {
                        return Row(children: [Text("No valid data.")]);
                      }
                    }))
              ],
            ))));
  }
}
  /*
        FutureBuilder<List<dynamic>>(
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
                  */