import 'dart:async';

import 'package:kyouen_vs_flutter/entities/room.dart';
import 'package:kyouen_vs_flutter/repositories/room_repository.dart';

class KyouenBloc {
  KyouenBloc(String roomId) {
    _roomController.addStream(RoomRepository().fetch(roomId));
    _pointsController.addStream(RoomRepository().fetchStones(roomId));

    _putStoneController.stream.listen((Point point) {
      RoomRepository().putStone(roomId, point);
    });
  }

  final StreamController<Point> _putStoneController = StreamController<Point>();

  final StreamController<Room> _roomController = StreamController<Room>();
  final StreamController<List<Point>> _pointsController =
      StreamController<List<Point>>();

  // input
  Sink<Point> get putStone => _putStoneController.sink;

  // output
  Stream<Room> get room => _roomController.stream;
  Stream<List<Point>> get points => _pointsController.stream;

  void dispose() {
    _putStoneController.close();
    _roomController.close();
  }
}
