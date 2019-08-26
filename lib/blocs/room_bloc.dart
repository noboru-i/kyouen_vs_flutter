import 'dart:async';

import 'package:kyouen_vs_flutter/entities/room.dart';
import 'package:kyouen_vs_flutter/repositories/room_repository.dart';

class RoomBloc {
  final StreamController<Room> _addController = StreamController();

  // input
  Sink<Room> get addRoom => _addController.sink;

  // output
//  Stream<List<Room>> get roomList => _roomListController.stream;

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
