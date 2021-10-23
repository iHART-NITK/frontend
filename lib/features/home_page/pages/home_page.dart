import 'package:flutter/material.dart';
import 'package:frontend/features/home_page/data/fetchNumAppointments.dart';
import 'package:frontend/features/user_profile/pages/user_page.dart';
import '/features/emergency/presentation/get_locations.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Future<int> numAppointments = FetchNumAppointments().get();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => GetLocations()));
        },
        child: Icon(Icons.health_and_safety),
        backgroundColor: Colors.redAccent[700],
      ),
    );
  }
}
