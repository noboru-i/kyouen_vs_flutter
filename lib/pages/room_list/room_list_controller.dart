import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kyouen_vs_flutter/entities/resource.dart';
import 'package:kyouen_vs_flutter/entities/room.dart';
import 'package:kyouen_vs_flutter/repositories/room_repository.dart';

class RoomListController extends ValueNotifier<Resource<RoomList>> {
  RoomListController(this._roomRepository)
      : assert(_roomRepository != null),
        super(const Resource<RoomList>.loading()) {
    _subscribe();
  }

  final RoomRepository _roomRepository;

  StreamSubscription<List<RoomDocument>> _subscription;

  Future<void> _subscribe() async {
    _subscription =
        _roomRepository.fetchRooms().listen((List<RoomDocument> data) {
      value = Resource<RoomList>(RoomList(data: data));
    }, onError: (dynamic error) {
      // TODO(noboru-i): dynamic is really ok?
      value = Resource<RoomList>.error(error.toString());
    });
  }

  Future<void> addRoom(Room room) async {
    await _roomRepository.addRoom(room);
  }

  @override
  void dispose() {
    super.dispose();

    _subscription?.cancel();
  }
}
