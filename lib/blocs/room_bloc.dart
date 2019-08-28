import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kyouen_vs_flutter/entities/room.dart';
import 'package:kyouen_vs_flutter/repositories/room_repository.dart';

class RoomBloc {
  final StreamController<Room> _addController = StreamController();

  // input
  Sink<Room> get addRoom => _addController.sink;

  // output
  // TODO change type to exclude Firestore dependency.
  Stream<QuerySnapshot> get roomList => RoomRepository.instance.snapshots();

  RoomBloc() {
    _addController.stream.listen(_addRoomListener);
  }

  void dispose() {
    _addController.close();
  }

  void _addRoomListener(Room room) {
    RoomRepository.instance.addRoom(room);
  }
}
