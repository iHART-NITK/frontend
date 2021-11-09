import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_html/flutter_html.dart';
import '/core/network/django_app.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class MedicalHistoryQRPage extends StatefulWidget {
  const MedicalHistoryQRPage({Key? key}) : super(key: key);

  @override
  _MedicalHistoryQRPageState createState() => _MedicalHistoryQRPageState();
}

class _MedicalHistoryQRPageState extends State<MedicalHistoryQRPage> {
  Future<String> getQR() async {
    await Hive.openBox('user');
    var box = Hive.box('user');
    var bytes1 = utf8.encode(box.get(0).token);
    var digest1 = sha256.convert(bytes1);

    String userId = box.get(0).id.toString();
    print('req going');
    final response =
        await http.post(Uri.parse("https://ihart-qr.herokuapp.com/"), body: {
      "data":
          "http://localhost:8000/api/user/$userId/medical-history/html?token=${digest1.toString()}",
      "ecl": "L",
      "test": "true"
    });
    print(response.body);
    debugPrint(
        "[API REQ] [POST] http://localhost:3000/ ${response.statusCode}");
    Map<String, dynamic> jsonSvg = jsonDecode(response.body);
    return jsonSvg["final_svg"];
    // DrawableRoot svgRoot =
    //     await svg.fromSvgString(jsonSvg["final_svg"], jsonSvg["final_svg"]);
    // print('H1');
    // final directory = await getApplicationDocumentsDirectory();
    // print('H1');
    // print(directory);
    // final Picture picture = svgRoot.toPicture();
    // return (svgRoot.toPicture().toImage(500, 500));
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('QR'),
          backgroundColor: Color.fromRGBO(181, 7, 23, 1),
          centerTitle: true),
      body: FutureBuilder(
        future: getQR(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasData) {
            String svgFound = snapshot.data.toString();
            // print(svgFound);
            int index = svgFound.indexOf('width="100%" height="100%"');
            // print(index);
            String s1 = svgFound.substring(0, index);
            int newindex = s1.indexOf("<svg");
            s1 = s1.substring(0, newindex + 4) +
                ' width="500px" height="500px"' +
                s1.substring(newindex + 4);
            String s2 = svgFound.substring(index + 27);
            // print(s1 + s2);
            return Padding(
              padding: const EdgeInsets.only(left: 500),
              child: Center(child: Html(data: s1 + s2)),
            );
          } else
            return Center(child: Text('There was some error!'));
        },
      ),
    );
  }
}
