import 'dart:async';

import 'package:kyouen_vs_flutter/entities/room.dart';
import 'package:kyouen_vs_flutter/repositories/room_repository.dart';

class RoomBloc {
  RoomBloc() {
    _roomListController.addStream(RoomRepository.instance.fetchRooms());

    _addController.stream.listen(_addRoomListener);
  }

  final StreamController<Room> _addController = StreamController<Room>();

  final StreamController<List<Room>> _roomListController =
      StreamController<List<Room>>();

  // input
  Sink<Room> get addRoom => _addController.sink;

  // output
  Stream<List<Room>> get roomList => _roomListController.stream;

  void dispose() {
    _addController.close();
  }

  void _addRoomListener(Room room) {
    RoomRepository.instance.addRoom(room);
  }
}
