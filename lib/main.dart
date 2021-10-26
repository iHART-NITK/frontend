import 'package:flutter/material.dart';
import 'package:frontend/core/network/django_app.dart';
import 'package:frontend/features/home_page/pages/home_page.dart';
import 'features/google_sign_in/data/model/user_model.dart';
import 'features/login_page/pages/login_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert' as convert;

void main() async {
  //Important Hive Setup!
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  //Important Hive Setup Ended!
  //Hive usage shown below, remove this when you understand!
  await Hive.openBox('user');
  // print(box.values);
  // box.add(User(1, 'CD'));
  // print(box.values);
  //Hive usage ended
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iHART',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2)).then((value) async {
      var box = Hive.box('user');
      if (box.isEmpty) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      } else {
        DjangoApp _djangoApp = new DjangoApp();
        Map<String, dynamic> data = {"id": box.get(0).id.toString()};
        var _response =
            await _djangoApp.post(url: "/verify-token/", data: data);
        bool decodedResponse = convert.jsonDecode(_response.body) as bool;
        if (decodedResponse) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Container(
          child: Image.asset(
            "assets/anim.gif",
          ),
        ),
      ),
    );
  }
}
