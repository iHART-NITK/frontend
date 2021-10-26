import 'package:flutter/material.dart';
import 'package:frontend/features/medical_history/presentation/get_Medical-history.dart';
import '/features/home_page/data/fetchNumEmergency.dart';
import '/features/home_page/data/fetchNumAppointments.dart';
import '/features/home_page/data/fetchNumTransactions.dart';
import '/features/user_profile/pages/user_page.dart';
import '/features/emergency/presentation/get_locations.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final Future<int> numAppointments = FetchNumAppointments().get();
    final Future<int> numTransactions = FetchNumTransactions().get();
    final Future<int> numEmergency = FetchNumEmergency().get();
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
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => GetMed()));
            },
          )
        ],
      )),
      appBar: AppBar(
        title: Text("iHART"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(181, 7, 23, 1),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserProfilePage()));
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
                            future: numAppointments,
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
                                    "${snapshot.data} appointment(s) scheduled");
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
                            future: numTransactions,
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
                                    "${snapshot.data} transactions(s) made with the HCC");
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
                            future: numEmergency,
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
                                    "${snapshot.data} emergency requests(s) made to the HCC");
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
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GetLocations()))
              .then((_) => {setState(() {})});
        },
        child: Icon(Icons.health_and_safety),
        backgroundColor: Colors.redAccent[700],
      ),
    );
  }
}
