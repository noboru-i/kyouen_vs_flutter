import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class Player extends Equatable {
  const Player({
    this.name,
  });

  final String name;
}
