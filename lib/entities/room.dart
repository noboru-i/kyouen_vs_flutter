import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kyouen_vs_flutter/entities/player.dart';
import 'package:meta/meta.dart';

part 'room.freezed.dart';
part 'room.g.dart';

// TODO(noboru-i): remove dependency to firestore
DateTime dateTimeFromTimestamp(Timestamp timestamp) =>
    timestamp == null ? null : timestamp.toDate();

@freezed
abstract class Room with _$Room {
  const factory Room({
    @required Player owner,
    @required bool isOwnerFirstMove,
    @required int size,
    Player attendee,
    @JsonKey(fromJson: dateTimeFromTimestamp) DateTime createdAt,
  }) = _Room;

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
}

@freezed
abstract class RoomDocument with _$RoomDocument {
  const factory RoomDocument({
    String id,
    Room room,
  }) = _RoomDocument;
}

@freezed
abstract class Point with _$Point {
  const factory Point({
    int x,
    int y,
  }) = _Point;

  factory Point.fromIndex(int size, int index) {
    return Point(x: index % size, y: index ~/ size);
  }

  factory Point.fromJson(Map<String, dynamic> json) => _$PointFromJson(json);
}

enum StoneState {
  none,
  black,
  white,
}
