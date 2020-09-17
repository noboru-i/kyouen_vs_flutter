import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_user.freezed.dart';

@freezed
abstract class LoginUser with _$LoginUser {
  const factory LoginUser({
    @required String uid,
    @required String name,
  }) = _LoginUser;

  factory LoginUser.fromFirebaseUser(FirebaseUser firebaseUser) =>
      LoginUser(uid: firebaseUser.uid, name: firebaseUser.uid);
}
