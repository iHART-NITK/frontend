import 'package:flutter/material.dart';
import 'features/emergency/presentation/get_locations.dart';
import 'features/google_sign_in/data/model/user_model.dart';
import 'features/home_page/pages/home_page.dart';
import 'features/login_page/pages/login_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'features/user_profile/pages/user_page.dart';

void main() async {
  //Important Hive Setup!
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  //Important Hive Setup Ended!
  //Hive usage shown below, remove this when you understand!
  // var box = await Hive.openBox<User>('user');
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
    Future.delayed(Duration(seconds: 2)).then((value) =>
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage())));
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
