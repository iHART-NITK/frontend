import 'package:google_sign_in/google_sign_in.dart';
import 'package:dartz/dartz.dart';

class GoogleOAuth {
  final GoogleSignIn googleSignIn;

  GoogleOAuth({required this.googleSignIn});

  Future<Either<void, dynamic>> signInAction() async {
    try {
      await googleSignIn.signIn();
      print('Signed in with Google');
      print(googleSignIn.currentUser!.displayName);
      return left(null);
    } catch (error) {
      print(error);
      return right(error);
    }
  }

  Future<void> _handleSignOut() => googleSignIn.disconnect();
}
