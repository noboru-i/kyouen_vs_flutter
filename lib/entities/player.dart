import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'player.freezed.dart';
part 'player.g.dart';

@freezed
abstract class Player with _$Player {
  const factory Player({String name}) = _Player;
  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
}
