import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class Room extends Equatable {
  final DateTime createdAt;
  final int numberOfPlayer;
  final int size;
  final List<Point> points;

  List<StoneState> get stage => generateStage();

  Room({
    this.createdAt,
    this.numberOfPlayer,
    this.size,
    this.points,
  }) : super([createdAt, numberOfPlayer, size, points]);

  Room.fromMap(Map<String, dynamic> source)
      : createdAt = (source['created_at'] as Timestamp).toDate(),
        numberOfPlayer = source['number_of_player'],
        size = source['size'],
        // TODO
        points = [] {}

  Map<String, dynamic> toMap() {
    return {
      'created_at': createdAt,
      'number_of_player': numberOfPlayer,
      'size': size,
      'points': points,
    };
  }

  List<StoneState> generateStage() {
    var list = List.generate(size * size, (i) => StoneState.none);
    for (final p in points) {
      final index = p.x + p.y * size;
      list[index] = StoneState.black;
    }
    return list;
  }
}

@immutable
class Point extends Equatable {
  final int x;
  final int y;

  Point({
    this.x,
    this.y,
  });
}

enum StoneState {
  none,
  black,
  white,
}
