import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'room.g.dart';

@immutable
@JsonSerializable()
class Room extends Equatable {
  const Room({
    this.createdAt,
    this.numberOfPlayer,
    this.size,
  });

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);

  Map<String, dynamic> toJson() => _$RoomToJson(this);

  @JsonKey(fromJson: _dateTimeFromEpochUs, toJson: _dateTimeToEpochUs)
  final DateTime createdAt;

  final int numberOfPlayer;

  final int size;

  @override
  List<Object> get props => <dynamic>[createdAt, numberOfPlayer, size];

  static DateTime _dateTimeFromEpochUs(int us) =>
      us == null ? null : DateTime.fromMicrosecondsSinceEpoch(us);

  static int _dateTimeToEpochUs(DateTime dateTime) =>
      dateTime?.microsecondsSinceEpoch;
}

@immutable
class RoomDocument extends Equatable {
  const RoomDocument({
    this.id,
    this.room,
  });

  final String id;
  final Room room;
}

@immutable
@JsonSerializable()
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
