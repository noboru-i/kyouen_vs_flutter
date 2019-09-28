import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kyouen_vs_flutter/entities/player.dart';
import 'package:meta/meta.dart';

part 'room.g.dart';

@immutable
@JsonSerializable()
class Room extends Equatable {
  const Room({
    @required this.owner,
    @required this.isOwnerFirstMove,
    @required this.size,
    this.attendee,
    this.createdAt,
  });

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);

  Map<String, dynamic> toJson() => _$RoomToJson(this);

  final Player owner;

  final bool isOwnerFirstMove;

  final int size;

  final Player attendee;

  @JsonKey(fromJson: _dateTimeFromTimestamp)
  final DateTime createdAt;

  @override
  List<Object> get props =>
      <dynamic>[owner, isOwnerFirstMove, size, attendee, createdAt];

  // TODO(noboru-i): remove dependency to firestore
  static DateTime _dateTimeFromTimestamp(Timestamp timestamp) =>
      timestamp == null ? null : timestamp.toDate();
}

@immutable
class RoomDocument extends Equatable {
  const RoomDocument({
    this.id,
    this.room,
  });

  final String id;
  final Room room;

  @override
  List<Object> get props => <dynamic>[id, room];
}

@immutable
@JsonSerializable()
class Point extends Equatable {
  const Point({
    this.x,
    this.y,
  });

  const Point.fromIndex(int size, int index)
      : x = index % size,
        y = index ~/ size;

  factory Point.fromJson(Map<String, dynamic> json) => _$PointFromJson(json);

  Map<String, dynamic> toJson() => _$PointToJson(this);

  final int x;
  final int y;

  @override
  List<Object> get props => <dynamic>[x, y];
}

enum StoneState {
  none,
  black,
  white,
}
