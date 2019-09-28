import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:kyouen_vs_flutter/repositories/login_repository.dart';

class LoginBloc {
  LoginBloc() {
    _loginController.stream.listen((_) {
      LoginRepository.instance.login();
    });
  }
  final StreamController<void> _loginController = StreamController<void>();
  final StreamController<LoginUser> _loginUserController =
      StreamController<LoginUser>();

  // input
  Sink<void> get login => _loginController.sink;

  // output
  // TODO(noboru-i): implement later
  Stream<LoginUser> get loginUser => _loginUserController.stream;

  void dispose() {
    _loginController.close();
    _loginUserController.close();
  }
}

@immutable
class LoginUser extends Equatable {
  const LoginUser({
    this.name,
  });

  final String name;

  @override
  List<Object> get props => <Object>[name];
}
