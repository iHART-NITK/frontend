import 'package:flutter/material.dart';

import '/features/all_prescriptions/data/get_all_prescriptions.dart';
import '/features/single_prescription/presentation/single_prescription.dart';

class AllPrescriptionsPage extends StatefulWidget {
  @override
  _AllPrescriptionsPageState createState() => _AllPrescriptionsPageState();
}

class _AllPrescriptionsPageState extends State<AllPrescriptionsPage> {
  @override
  Widget build(BuildContext context) {
    final Future<List<dynamic>> _response =
        GetPrescriptionAppointments().getData();
    return Scaffold(
        appBar: AppBar(title: const Text('All Prescriptions')),
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
                        'No Prescriptions to show!',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ];
                } else {
                  children = <Widget>[];
                  snapshot.data?.forEach((appointment) {
                    if (appointment["has_prescriptions"])
                      children.add(Card(
                          child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                        child: Column(children: <Widget>[
                          Column(
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ListTile(
                                leading: Icon(
                                  Icons.date_range,
                                  size: 30,
                                ),
                                title: Text('${appointment["date"]}'),
                                subtitle: Text(
                                    'Doctor: Dr. ${appointment["doctor_name"]}'),
                                trailing: IconButton(
                                  onPressed: () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PrescriptionPage(
                                                  appointmentNo:
                                                      appointment["id"],
                                                )));
                                  },
                                  icon: Icon(Icons.arrow_forward_ios_rounded),
                                ),
                              ),
                            ],
                          ),
                        ]),
                      )));
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
            }));
  }
}
