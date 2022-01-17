import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '/core/network/django_app.dart';
import '/features/emergency/data/locations.dart';

class GetLocations extends StatefulWidget {
  @override
  _GetLocationsState createState() => _GetLocationsState();
}

class _GetLocationsState extends State<GetLocations> {
  ValueNotifier currentLocationSelected = ValueNotifier("");
  TextEditingController _controller = new TextEditingController();

  Future<Map<String, String>> getLocations() {
    Location location = new Location();
    final Future<Map<String, String>> _hash = location.getLocations();
    return _hash;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Emergency Locations')),
      body: FutureBuilder<Map<String, String>>(
          future:
              getLocations(), // a previously-obtained Future<String> or null
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              List<DropdownMenuItem<String>> list =
                  new List.empty(growable: true);

              snapshot.data.forEach((key, label) {
                currentLocationSelected.value = key;
                list.add(DropdownMenuItem<String>(
                  child: Text(label.toString()),
                  value: key,
                ));
              });

              children = <Widget>[
                ValueListenableBuilder(
                  valueListenable: currentLocationSelected,
                  builder: (context, _, __) {
                    return DropdownButton<String>(
                      value: currentLocationSelected.value,
                      items: list,
                      hint: Text('Select Location'),
                      onChanged: (value) {
                        currentLocationSelected.value = value;
                      },
                    );
                  },
                ),
                TextFormField(
                  controller: _controller,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  minLines: 1,
                  maxLines: 5,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter a reason.'),
                ),
                ElevatedButton(
                    onPressed: () async {
                      final response = await DjangoApp()
                          .post(url: "/emergency/create/", data: {
                        "location": currentLocationSelected.value,
                        "reason": _controller.text,
                        "status": "R"
                      });
                      if (response.statusCode == 200) {
                        showTopSnackBar(
                            context,
                            CustomSnackBar.success(
                                message: "Emergency has been raised."));
                      } else {
                        showTopSnackBar(
                            context,
                            CustomSnackBar.error(
                                message: "Some error occurred. Call HCC."));
                      }
                      Navigator.pop(context);
                    },
                    child: Text("Raise Emergency"))
              ];
            } else if (snapshot.hasError) {
              children = <Widget>[
                const Icon(
                  Icons.error_outline,
                  color: Color.fromRGBO(181, 7, 23, 1),
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text('Error: ${snapshot.error}'),
                )
              ];
            } else {
              children = const <Widget>[
                SizedBox(
                  child: CircularProgressIndicator(),
                  width: 60,
                  height: 60,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Awaiting result...'),
                )
              ];
            }
            return Column(
              children: children,
            );
          }),
    );
  }
}
