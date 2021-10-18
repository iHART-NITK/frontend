import 'package:flutter/material.dart';
import 'package:frontend/features/user_profile/data/fetch_user.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    FetchUserData _fetchUserData = new FetchUserData();
    final Future<Map<String, dynamic>> _response = _fetchUserData.getData();
    return Scaffold(
        appBar: AppBar(
          title: Text("User Page"),
          backgroundColor: Color.fromRGBO(181, 7, 23, 1),
        ),
        body: FutureBuilder(
            future: _response,
            builder: (BuildContext context,
                AsyncSnapshot<Map<String, dynamic>> snapshot) {
              return Container(
                  margin: EdgeInsets.all(10),
                  child: Center(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(150),
                                child: Image.asset('assets/lol.png'),
                              ),
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black, width: 2.0),
                                  borderRadius: BorderRadius.circular(150)),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                ('${snapshot.data?["full_name"]}'),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 40),
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Email Address",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Text(snapshot.data?["email"] ?? "")
                              ],
                            ),
                            Column(
                              children: [
                                Text("Phone Number",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                                Text(snapshot.data?["phone"] ?? "")
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ));
            }));
  }
}
