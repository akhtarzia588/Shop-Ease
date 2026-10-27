import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSign {
  bool _initialized = false;

  _init() async {
    if (_initialized) return;
    await GoogleSignIn.instance.initialize();
    _initialized = true;
  }

  Future<UserCredential> signInWithGoogle() async {
    await _init();

    final googleuser = await GoogleSignIn.instance.authenticate();
    final googleauth = await googleuser.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: googleauth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    await GoogleSignIn.instance.signOut();
    await FirebaseAuth.instance.signOut();
  }
}
