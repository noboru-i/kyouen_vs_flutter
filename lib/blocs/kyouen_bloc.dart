import 'dart:async';

import 'package:kyouen_vs_flutter/entities/room.dart';
import 'package:kyouen_vs_flutter/repositories/room_repository.dart';

class KyouenBloc {
  final StreamController<Room> _roomController = StreamController<Room>();
  Stream<Room> get room => _roomController.stream;

  KyouenBloc(String roomId) {
    _roomController.addStream(RoomRepository().fetch(roomId));
  }

  dispose() {
    _roomController.close();
  }
}
