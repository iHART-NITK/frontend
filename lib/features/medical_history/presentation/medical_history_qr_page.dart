import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '/core/network/django_app.dart';

class MedicalHistoryQRPage extends StatefulWidget {
  const MedicalHistoryQRPage({Key? key}) : super(key: key);

  @override
  _MedicalHistoryQRPageState createState() => _MedicalHistoryQRPageState();
}

class _MedicalHistoryQRPageState extends State<MedicalHistoryQRPage> {
  Future<List<dynamic>> getQR(bool flag) async {
    await Hive.openBox('user');
    var box = Hive.box('user');
    var bytes1 = utf8.encode(box.get(0).token);
    var digest1 = sha256.convert(bytes1);

    String userId = box.get(0).id.toString();
    if (flag) return [digest1, userId];
    final response =
        await http.post(Uri.parse("https://ihart-qr.herokuapp.com/"), body: {
      "data":
          "http://${DjangoApp.host}:${DjangoApp.port}/api/user/$userId/medical-history/html?token=${digest1.toString()}",
      "ecl": "L",
      "test": "true"
    });
    debugPrint(
        "[API REQ] [POST] https://ihart-qr.herokuapp.com/ ${response.statusCode}");
    Map<String, dynamic> jsonSvg = jsonDecode(response.body);
    return jsonSvg["final_svg"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('QR')),
      body: FutureBuilder(
        future: getQR(true),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return Center(
                child: SvgPicture.network(
              "https://api.qrserver.com/v1/create-qr-code/?size=400x400&format=svg&data=http://${DjangoApp.host}:${DjangoApp.port}/api/user/${snapshot.data![1]}/medical-history/html?token=${snapshot.data![0].toString()}",
              placeholderBuilder: (context) {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text("Fetching QR...")
                  ],
                ));
              },
            ));
          } else
            return Center(child: Text('There was some error!'));
        },
      ),
    );
  }
}
