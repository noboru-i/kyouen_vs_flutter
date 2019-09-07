import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class Room extends Equatable {
  const Room({
    this.createdAt,
    this.numberOfPlayer,
    this.size,
    this.points,
  });

  Room.fromMap(Map<String, dynamic> source)
      : createdAt = (source['created_at'] is Timestamp)
            ? source['created_at'].toDate()
            : null,
        numberOfPlayer = source['number_of_player'],
        size = source['size'],
        // TODO(noboru-i): fix later.
        points = <Point>[];

  final DateTime createdAt;
  final int numberOfPlayer;
  final int size;
  final List<Point> points;

  List<StoneState> get stage => generateStage();

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'created_at': createdAt,
      'number_of_player': numberOfPlayer,
      'size': size,
      'points': points,
    };
  }

  List<StoneState> generateStage() {
    final List<StoneState> list =
        List<StoneState>.generate(size * size, (int i) => StoneState.none);
    for (final Point p in points) {
      final int index = p.x + p.y * size;
      list[index] = StoneState.black;
    }
    return list;
  }

  @override
  List<Object> get props => <dynamic>[createdAt, numberOfPlayer, size, points];
}

@immutable
class Point extends Equatable {
  const Point({
    this.x,
    this.y,
  });

  Point.fromMap(Map<String, dynamic> source)
      : x = source['x'],
        y = source['y'];

  const Point.fromIndex(int size, int index)
      : x = index % size,
        y = index ~/ size;

  final int x;
  final int y;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'x': x,
      'y': y,
    };
  }

  @override
  List<Object> get props => <dynamic>[x, y];
}

enum StoneState {
  none,
  black,
  white,
}
