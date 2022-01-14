import 'package:flutter/material.dart';
import 'package:enum_to_string/enum_to_string.dart';

// ignore: must_be_immutable
class RegisterPage extends StatefulWidget {
  late Map<String, dynamic> _body;
  RegisterPage({Key? key, required Map<String, dynamic> body})
      : super(key: key) {
    _body = body;
  }

  @override
  _RegisterPageState createState() => _RegisterPageState(body: _body);
}

enum Gender { M, F, O, N }

class _RegisterPageState extends State<RegisterPage> {
  String? phone = "", username = "";
  late Map<String, dynamic> _body;
  Gender? _gender = Gender.M;

  _RegisterPageState({required Map<String, dynamic> body}) {
    _body = body;
  }
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
        appBar: AppBar(title: Text("Registration")),
        body: Center(
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "You're almost there!",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                    child: TextFormField(
                      initialValue: phone,
                      decoration: InputDecoration(
                          icon: Icon(Icons.phone),
                          hintText: "What's your phone number?",
                          labelText: "Phone Number",
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return "Form is not valid!";
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      onSaved: (value) {
                        phone = value;
                      },
                      onChanged: (value) {
                        phone = value;
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                    child: TextFormField(
                      initialValue: username,
                      decoration: InputDecoration(
                          icon: Icon(Icons.person),
                          hintText: "What's your username?",
                          labelText: "Username",
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return "Form is not valid!";
                        return null;
                      },
                      onSaved: (value) {
                        username = value;
                      },
                      onChanged: (value) {
                        username = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Radio<Gender>(
                              value: Gender.M,
                              groupValue: _gender,
                              onChanged: (value) {
                                setState(() {
                                  _gender = value;
                                });
                              },
                            ),
                            const Text("Male")
                          ],
                        ),
                        Column(children: [
                          Radio<Gender>(
                            value: Gender.F,
                            groupValue: _gender,
                            onChanged: (value) {
                              setState(() {
                                _gender = value;
                              });
                            },
                          ),
                          const Text("Female")
                        ]),
                        Column(
                          children: [
                            Radio<Gender>(
                              value: Gender.O,
                              groupValue: _gender,
                              onChanged: (value) {
                                setState(() {
                                  _gender = value;
                                });
                              },
                            ),
                            const Text("Other")
                          ],
                        ),
                        Column(
                          children: [
                            Radio<Gender>(
                              value: Gender.N,
                              groupValue: _gender,
                              onChanged: (value) {
                                setState(() {
                                  _gender = value;
                                });
                              },
                            ),
                            const Text("Would not like to disclose")
                          ],
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton.icon(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          _body.addAll({
                            "username": username,
                            "phone": phone,
                            "gender": EnumToString.convertToString(_gender)
                          });
                          Navigator.pop(context);
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromRGBO(181, 7, 23, 1))),
                      icon: Icon(Icons.navigate_next),
                      label: Text("Submit"))
                ],
              )),
        ));
  }
}
