import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kyouen_vs_flutter/entities/room.dart';
import 'package:kyouen_vs_flutter/repositories/room_repository.dart';

class RoomBloc {
  RoomBloc() {
    _addController.stream.listen(_addRoomListener);
  }

  final StreamController<Room> _addController = StreamController<Room>();

  // input
  Sink<Room> get addRoom => _addController.sink;

  // output
  // TODO(noboru-i): change type to exclude Firestore dependency.
  Stream<QuerySnapshot> get roomList => RoomRepository.instance.snapshots();

  void dispose() {
    _addController.close();
  }

  void _addRoomListener(Room room) {
    RoomRepository.instance.addRoom(room);
  }
}
