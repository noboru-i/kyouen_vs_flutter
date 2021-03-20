import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kyouen_vs_flutter/entities/resource.dart';
import 'package:kyouen_vs_flutter/repositories/login_repository.dart';

part 'login_controller.freezed.dart';

@freezed
abstract class LoginUser with _$LoginUser {
  const factory LoginUser({
    required String name,
  }) = _LoginUser;
}

class LoginController extends ValueNotifier<Resource<LoginUser>> {
  LoginController(this._loginRepository)
      : super(const Resource<LoginUser>.loading()) {
    _initialFetch();
  }

  final LoginRepository _loginRepository;

  Future<void> _initialFetch() async {
    final currentUser = await _loginRepository.currentUser();
    _updateLoginUserState(currentUser);
  }

  void _updateLoginUserState(User? firebaseUser) {
    if (firebaseUser == null) {
      value = const Resource<LoginUser>.error('not logged in');
      return;
    }
    // TODO(noboru-i): we need to add more variables.
    value = Resource<LoginUser>(LoginUser(name: firebaseUser.uid));
  }

  Future<void> signInAnonymously() async {
    final firebaseUser = await _loginRepository.signInAnonymously();
    _updateLoginUserState(firebaseUser);
  }
}
