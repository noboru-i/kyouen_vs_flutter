import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'login_user.dart';

part 'player.freezed.dart';
part 'player.g.dart';

@freezed
abstract class Player with _$Player {
  const factory Player({
    String uid,
    String name,
  }) = _Player;

  factory Player.fromLoginUser(LoginUser loginUser) =>
      Player(uid: loginUser.uid, name: loginUser.name);

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
}
