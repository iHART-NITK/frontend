import 'package:flutter/material.dart';

import '/features/home_page/data/fetchNumEmergency.dart';
import '/features/home_page/data/fetchNumAppointments.dart';
import '/features/home_page/data/fetchNumTransactions.dart';

class AdminHomePage extends StatefulWidget {
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    final Future<int> allAppointments = FetchAllAppointments().get();
    final Future<int> allTransactions = FetchAllTransactions().get();
    final Future<int> allEmergency = FetchAllEmergency().get();
    return Scaffold(
      drawer: Drawer(
          child: ListView(
        children: [
          DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/iHART-logo.png'))),
              child: Stack(children: <Widget>[
                Positioned(
                    bottom: 12.0,
                    left: 16.0,
                    child: Text("iHART",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500))),
              ])),
          ListTile(
              title: Text('Medical History'),
              onTap: () {
                Navigator.pushNamed(context, '/medical-history');
              }),
          ListTile(
              title: Text('Documents'),
              onTap: () {
                Navigator.pushNamed(context, '/docs');
              })
        ],
      )),
      appBar: AppBar(
        title: Text("iHART ADMIN"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/user-profile');
            },
            icon: Icon(Icons.person_rounded),
            tooltip: "View Profile",
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                print("Appointment Page in progress!");
              },
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                        title: Text("Appointments"),
                        subtitle: FutureBuilder(
                            future: allAppointments,
                            builder: (BuildContext context,
                                AsyncSnapshot<int> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return LinearProgressIndicator();
                              }
                              Text output =
                                  new Text("No appointments scheduled!");
                              if (snapshot.hasData) {
                                output = Text(
                                    "${snapshot.data} appointment(s) were scheduled");
                              } else if (snapshot.hasError) {
                                output =
                                    Text("Error while fetching appointments!");
                              }
                              return output;
                            }))
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                print("Transaction Page in progress!");
              },
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                        title: Text("Transactions"),
                        subtitle: FutureBuilder(
                            future: allTransactions,
                            builder: (BuildContext context,
                                AsyncSnapshot<int> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return LinearProgressIndicator();
                              }
                              Text output =
                                  new Text("No recorded transactions!");
                              if (snapshot.hasData) {
                                output = Text(
                                    "${snapshot.data} transactions(s) have been made with the HCC");
                              } else if (snapshot.hasError) {
                                output =
                                    Text("Error while fetching transactions!");
                              }
                              return output;
                            }))
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                print("Emergency Page in progress!");
              },
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                        title: Text("Emergencies"),
                        subtitle: FutureBuilder(
                            future: allEmergency,
                            builder: (BuildContext context,
                                AsyncSnapshot<int> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return LinearProgressIndicator();
                              }
                              Text output =
                                  new Text("No recorded emergencies!");
                              if (snapshot.hasData) {
                                output = Text(
                                    "${snapshot.data} emergency requests(s) have been made to the HCC!");
                              } else if (snapshot.hasError) {
                                output =
                                    Text("Error while fetching emergencies!");
                              }
                              return output;
                            }))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/emergency')
              .then((_) => {setState(() {})});
        },
        child: Icon(Icons.health_and_safety),
        backgroundColor: Colors.redAccent[700],
      ),
    );
  }
}
