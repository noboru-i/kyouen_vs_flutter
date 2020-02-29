import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'player.g.dart';

@immutable
@JsonSerializable()
class Player extends Equatable {
  const Player({
    this.name,
  });

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerToJson(this);

  final String name;

  @override
  List<Object> get props => [name];
}
