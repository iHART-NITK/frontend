import 'package:flutter/material.dart';
import 'package:frontend/core/network/django_app.dart';
import 'package:frontend/features/google_sign_in/data/model/user_model.dart';
import 'package:frontend/features/home_page/pages/admin_home_page.dart';
import 'package:frontend/features/home_page/pages/home_page.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'dart:convert' as convert;

class GoogleOAuth {
  GoogleSignIn googleSignIn = GoogleSignIn();

  GoogleOAuth({required this.googleSignIn});

  String checkUserType(String email) {
    RegExp rollNoRegex = new RegExp('[1-9][0-9][0-9][a-z]{2}[0-9]{3}');
    String username = email.split('@')[0];
    String domain = email.split('@').last;
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

      var _response =
          await _djangoApp.postAnonymous(url: "/verify-user/", data: _data);
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
          // Todo: Make a separate view to get this info
          String username = "temp";
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
          String phone = "+919900512512";
          String email = googleSignIn.currentUser!.email;
          String photoURL = googleSignIn.currentUser!.photoUrl ??
              "https://www.gravatar.com/avatar/?d=mp";
          String customerId = googleSignIn.currentUser!.id;
          String gender = "M";
          String userType = checkUserType(email);

          Map<String, dynamic> data = {
            "username": username,
            "password": password,
            "phone": phone,
            "email": email,
            "first_name": firstName,
            "middle_name": middleName,
            "last_name": lastName,
            "gender": gender,
            "customer_id": customerId,
            "user_type": userType,
            "photo": photoURL
          };
          var _regResponse =
              await _djangoApp.postAnonymous(url: '/register/', data: data);

          Map<String, dynamic> decodedRegResponse =
              convert.jsonDecode(_regResponse.body) as Map<String, dynamic>;

          print(decodedRegResponse);
          await box.clear();
          box.add(User(decodedRegResponse["id"], decodedRegResponse["token"],
              decodedRegResponse["user_type"]));
          print("Added to box!");
        }
        if (box.get(0).type == "Stu" || box.get(0).type == "Fac")
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        else
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => AdminHomePage()));
      }
      return left(null);
    } catch (error) {
      print(error);
      return right(error);
    }
  }

  Future<void> _handleSignOut() => googleSignIn.disconnect();
}
