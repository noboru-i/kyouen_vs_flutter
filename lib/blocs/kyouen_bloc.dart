import 'dart:async';

import 'package:kyouen_vs_flutter/entities/room.dart';
import 'package:kyouen_vs_flutter/repositories/room_repository.dart';

class KyouenBloc {
  KyouenBloc(String roomId) {
    _roomController.addStream(RoomRepository().fetch(roomId));
  }

  final StreamController<Room> _roomController = StreamController<Room>();

  Stream<Room> get room => _roomController.stream;

  void dispose() {
    _roomController.close();
  }
}
