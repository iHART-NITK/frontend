import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '/features/google_sign_in/data/google_oauth.dart';

class GoogleSignInButton extends StatefulWidget {
  const GoogleSignInButton({Key? key}) : super(key: key);

  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  @override
  Widget build(BuildContext context) {
    GoogleOAuth googleOAuth = new GoogleOAuth(
      googleSignIn: new GoogleSignIn(scopes: [
        'email',
        'https://www.googleapis.com/auth/userinfo.profile',
        'https://www.googleapis.com/auth/user.phonenumbers.read',
        'https://www.googleapis.com/auth/user.gender.read',
        'https://www.googleapis.com/auth/user.birthday.read',
      ]),
    );
    return SignInButton(Buttons.Google, onPressed: () async {
      print('Google Sign in Button Pressed!');
      await googleOAuth.signInAction(context);
    });
  }
}
