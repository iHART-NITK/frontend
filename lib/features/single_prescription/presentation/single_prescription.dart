import 'package:flutter/material.dart';

import '/features/single_prescription/data/get_single_prescription.dart';

class PrescriptionPage extends StatefulWidget {
  final int appointmentNo;
  PrescriptionPage({Key? key, required this.appointmentNo}) : super(key: key);
  @override
  _PrescriptionPageState createState() => _PrescriptionPageState();
}

class _PrescriptionPageState extends State<PrescriptionPage> {
  @override
  Widget build(BuildContext context) {
    final Future<List<dynamic>> _prescriptionResponse =
        GetSinglePrescription().getData(widget.appointmentNo);
    final Future<Map<String, dynamic>> _appointmentResponse =
        GetAppointmentInfo().getData(widget.appointmentNo);
    return Scaffold(
        appBar: AppBar(title: const Text('Prescription')),
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
                          Text('Date: ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('${snapshot.data?["date"]}'),
                          Spacer(),
                          Text('Doctor: Dr. ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('${snapshot.data?["doctor_name"]}')
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
                          Expanded(
                              child: Column(children: [
                            Text("DIAGNOSIS",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ))
                          ])),
                          Expanded(
                              child: Column(children: [
                            Text("MEDICATION",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ))
                          ])),
                          Expanded(
                              child: Column(children: [
                            Text("DOSAGE",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ))
                          ])),
                        ]));
                        rows.add(Divider());
                        snapshot.data?.forEach((presc) {
                          rows.add(Row(children: [
                            Expanded(
                                child: Column(
                                    children: [Text(presc["diagnosis"])])),
                            Expanded(
                                child: Column(
                                    children: [Text(presc["inventory"])])),
                            Expanded(
                                child:
                                    Column(children: [Text(presc["dosage"])])),
                          ]));
                          rows.add(SizedBox(height: 10));
                        });
                        return Row(children: [
                          Expanded(
                              child: Column(
                            children: rows,
                          ))
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
