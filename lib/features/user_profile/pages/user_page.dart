import 'package:flutter/material.dart';

import '/features/user_profile/data/fetch_user.dart';
import '/core/network/django_app.dart';
import '/features/google_sign_in/data/google_oauth.dart';

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
      appBar: AppBar(title: Text("User Page")),
      body: FutureBuilder(
          future: _response,
          builder: (BuildContext context,
              AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
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
                              child: Image.network(
                                snapshot.data?["photo"],
                                fit: BoxFit.cover,
                              ),
                            ),
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 2.0),
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
                                    fontWeight: FontWeight.bold, fontSize: 18),
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
          }),
      floatingActionButton: IconButton(
          onPressed: () async {
            DjangoApp _djangoApp = new DjangoApp();
            await _djangoApp.post(url: '/logout/', data: {});
            await GoogleOAuth().handleSignOut();
            Navigator.pushNamedAndRemoveUntil(
                context, '/login', (route) => false);
          },
          icon: Icon(Icons.logout)),
    );
  }
}
