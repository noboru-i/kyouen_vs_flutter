import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class LoginRepository {
  static final LoginRepository instance = LoginRepository();

  Future<FirebaseUser> signInAnonymously() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    // TODO(noboru-i): Sign in with Twitter is crashed. So temporally login anonymously.
    final AuthResult result = await _auth.signInAnonymously();

    print('signed in ${result.user.uid}');

    return result.user;
  }

  Future<FirebaseUser> currentUser() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    return await _auth.currentUser();
  }
}
