import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/network/django_app.dart';
import 'features/all_prescriptions/presentation/prescriptions.dart';
import 'features/medical_history/presentation/medical_history_qr_page.dart';
import 'features/home_page/pages/admin_home_page.dart';
import 'features/home_page/pages/user_home_page.dart';
import 'features/emergency/presentation/get_locations.dart';
import 'features/google_sign_in/data/model/user_model.dart';
import 'features/login_pages/pages/login_page.dart';
import 'features/medical_history/presentation/get_Medical-history.dart';
import 'features/user_profile/pages/user_page.dart';
import 'features/documents/presentation/document_page.dart';

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
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              backgroundColor: Color.fromRGBO(181, 7, 23, 1),
              centerTitle: true)),
      routes: {
        '/': (context) => MyHomePage(),
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/admin/home': (context) => AdminHomePage(),
        '/emergency': (context) => GetLocations(),
        '/medical-history': (context) => GetMed(),
        '/user-profile': (context) => UserProfilePage(),
        '/prescriptions': (context) => AllPrescriptionsPage(),
        '/qr-code': (context) => MedicalHistoryQRPage(),
        '/docs': (context) => DocumentPage()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
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

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.bounceOut,
  );
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/iHART-logo.png',
                width: 300,
              )),
        ),
      ),
    );
  }
}
