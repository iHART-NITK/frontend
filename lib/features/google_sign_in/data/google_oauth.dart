import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'dart:convert' as convert;

import '/features/login_pages/pages/register_page.dart';
import '/features/google_sign_in/data/model/user_model.dart';
import '/core/network/django_app.dart';

class GoogleOAuth {
  GoogleSignIn googleSignIn = new GoogleSignIn(scopes: [
    'email',
    'https://www.googleapis.com/auth/userinfo.profile',
  ]);

  String checkUserType(String email) {
    RegExp rollNoRegex = new RegExp('[1-9][0-9][0-9][a-z]{2}[0-9]{3}');
    String username = email.split('@')[0];
    String domain = email.split('@').last;
    // if (username == "nishantnayak2001") {
    //   return "Sta";
    // }
    if (domain != "nitk.edu.in") {
      return "";
    }
    String rollNumber = username.split('.').last;
    if (rollNoRegex.hasMatch(rollNumber))
      return "Stu";
    else
      return "Fac";
  }

  Future<Either<void, dynamic>> signInAction(BuildContext context) async {
    DjangoApp _djangoApp = new DjangoApp();
    var box = Hive.box('user');
    try {
      await googleSignIn.signIn();
      print('Signed in successful!');
      Map<String, String> _data = {
        "email": googleSignIn.currentUser!.email,
        "customer_id": googleSignIn.currentUser!.id
      };

      var _response = await _djangoApp.post(
          url: "/verify-user/", data: _data, isAnonymous: true);
      Map<String, dynamic> decodedResponse =
          convert.jsonDecode(_response.body) as Map<String, dynamic>;

      if (_response.statusCode == 403) {
        print(decodedResponse["error_msg"]);
      } else {
        if (decodedResponse["verified"]) {
          print("Returning user, logging in...");
          if (box.isEmpty) {
            box.add(User(decodedResponse["id"], decodedResponse["token"],
                decodedResponse["user_type"]));
          } else {
            print(box.get(0).id);
            box.putAt(
                0,
                User(decodedResponse["id"], decodedResponse["token"],
                    decodedResponse["user_type"]));
          }
          print("Added to box!");
        } else {
          String? displayName = googleSignIn.currentUser!.displayName;
          late String firstName, middleName, lastName;
          if (displayName != null) {
            List<String> nameList = displayName.split(" ");
            firstName = nameList[0];
            lastName = nameList[nameList.length - 1];
            if (nameList.length >= 3) {
              middleName = nameList[1];
            } else {
              middleName = "";
            }
          }
          String password = googleSignIn.currentUser!.id;
          String email = googleSignIn.currentUser!.email;
          String photoURL = googleSignIn.currentUser!.photoUrl ??
              "https://www.gravatar.com/avatar/?d=mp";
          String customerId = googleSignIn.currentUser!.id;
          // Todo: Add Gender radio button
          String userType = checkUserType(email);

          Map<String, dynamic> data = {
            "password": password,
            "email": email,
            "first_name": firstName,
            "middle_name": middleName,
            "last_name": lastName,
            "customer_id": customerId,
            "user_type": userType,
            "photo": photoURL
          };
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RegisterPage(body: data)));

          var _regResponse = await _djangoApp.post(
              url: '/register/', data: data, isAnonymous: true);

          Map<String, dynamic> decodedRegResponse =
              convert.jsonDecode(_regResponse.body) as Map<String, dynamic>;

          await box.clear();
          box.add(User(decodedRegResponse["id"], decodedRegResponse["token"],
              decodedRegResponse["user_type"]));
          print("Added to box!");
        }
        if (box.get(0).type == "Stu" || box.get(0).type == "Fac")
          Navigator.pushReplacementNamed(context, '/home');
        else
          Navigator.pushReplacementNamed(context, '/admin/home');
      }
      return left(null);
    } catch (error) {
      print(error);
      return right(error);
    }
  }

  Future<void> handleSignOut() async {
    googleSignIn.disconnect();
    await Hive.box('user').clear();
  }
}
