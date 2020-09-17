import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kyouen_vs_flutter/entities/login_user.dart';
import 'package:kyouen_vs_flutter/entities/resource.dart';
import 'package:kyouen_vs_flutter/repositories/login_repository.dart';

class LoginController extends ValueNotifier<Resource<LoginUser>> {
  LoginController(this._loginRepository)
      : assert(_loginRepository != null),
        super(const Resource<LoginUser>.loading()) {
    _initialFetch();
  }

  final LoginRepository _loginRepository;

  Future<void> _initialFetch() async {
    final FirebaseUser currentUser = await _loginRepository.currentUser();
    _updateLoginUserState(currentUser);
  }

  void _updateLoginUserState(FirebaseUser firebaseUser) {
    if (firebaseUser == null) {
      value = const Resource<LoginUser>.error('not logged in');
      return;
    }
    // TODO(noboru-i): we need to add more variables.
    value = Resource<LoginUser>(LoginUser.fromFirebaseUser(firebaseUser));
  }

  Future<void> signInAnonymously() async {
    final FirebaseUser firebaseUser =
        await _loginRepository.signInAnonymously();
    _updateLoginUserState(firebaseUser);
  }
}
