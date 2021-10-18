import 'package:flutter/material.dart';
import 'package:frontend/features/google_sign_in/data/model/user_model.dart';
import 'package:frontend/features/medical_history/presentation/get_Medical-history.dart';
import 'package:frontend/features/google_sign_in/presentation/pages/google_sign_in_page.dart';
import 'package:frontend/features/login_page/pages/login_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  //Important Hive Setup!
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  //Important Hive Setup Ended!
  //Hive usage shown below, remove this when you understand!
  var box = await Hive.openBox<User>('user');
  print(box.values);
  box.add(User(1, 'CD'));
  print(box.values);
  //Hive usage ended
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iHART',
      home: MyHomePage(),
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
    Future.delayed(Duration(seconds: 2)).then((value) => Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage())));
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
