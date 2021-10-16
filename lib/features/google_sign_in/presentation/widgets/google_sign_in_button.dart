import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:frontend/features/google_sign_in/data/google_oauth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:frontend/features/emergency/data/locations.dart';

class GoogleSignInButton extends StatefulWidget {
  const GoogleSignInButton({Key? key}) : super(key: key);

  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  @override
  Widget build(BuildContext context) {
    GoogleOAuth googleOAuth = new GoogleOAuth(
      googleSignIn: new GoogleSignIn(),
    );
    return SignInButton(
      Buttons.Google,
      onPressed: () async {
        print('Google Sign in Button Pressed!');
        // googleOAuth.signInAction();
        Location location = new Location();
        location.getLocations();
      },
    );
  }
}
