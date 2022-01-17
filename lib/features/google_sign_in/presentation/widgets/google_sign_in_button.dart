import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import '/features/google_sign_in/data/google_oauth.dart';

class GoogleSignInButton extends StatefulWidget {
  const GoogleSignInButton({Key? key}) : super(key: key);

  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  @override
  Widget build(BuildContext context) {
    return SignInButton(Buttons.Google, onPressed: () async {
      print('Google Sign in Button Pressed!');
      await GoogleOAuth().signInAction(context);
    });
  }
}
