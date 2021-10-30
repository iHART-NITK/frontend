import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/network/django_app.dart';
import 'features/home_page/pages/admin_home_page.dart';
import 'features/home_page/pages/user_home_page.dart';
import 'features/emergency/presentation/get_locations.dart';
import 'features/google_sign_in/data/model/user_model.dart';
import 'features/login_pages/pages/login_page.dart';
import 'features/medical_history/presentation/get_Medical-history.dart';
import 'features/user_profile/pages/user_page.dart';

void main() async {
  // Hive Setup
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());

  await Hive.openBox('user');
  // Uncomment the line to clear the token on startup (debug only)
  // await Hive.box('user').clear();
  //Hive usage ended
  runApp(IHARTApp());
}

class IHARTApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iHART',
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/admin/home': (context) => AdminHomePage(),
        '/emergency': (context) => GetLocations(),
        '/medical-history': (context) => GetMed(),
        '/user-profile': (context) => UserProfilePage()
      },
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
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        DjangoApp _djangoApp = new DjangoApp();
        Map<String, dynamic> data = {"id": box.get(0).id.toString()};
        var _response =
            await _djangoApp.post(url: "/verify-token/", data: data);
        if (_response.statusCode != 200) {
          Navigator.pushReplacementNamed(context, '/login');
          return;
        }
        bool decodedResponse = convert.jsonDecode(_response.body) as bool;
        if (decodedResponse) {
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          Navigator.pushReplacementNamed(context, '/login');
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
