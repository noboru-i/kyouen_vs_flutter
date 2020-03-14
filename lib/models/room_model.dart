import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kyouen_vs_flutter/entities/resource.dart';
import 'package:kyouen_vs_flutter/entities/room.dart';
import 'package:kyouen_vs_flutter/repositories/room_repository.dart';

class RoomModel extends ValueNotifier<Resource<RoomList>> {
  RoomModel(this.roomRepository)
      : assert(roomRepository != null),
        super(const Resource<RoomList>.loading()) {
    _subscribe();
  }

  final RoomRepository roomRepository;

  StreamSubscription<List<RoomDocument>> _subscription;

  Future<void> _subscribe() async {
    _subscription =
        roomRepository.fetchRooms().listen((List<RoomDocument> data) {
      value = Resource<RoomList>(RoomList(data: data));
    }, onError: (dynamic error) {
      // TODO(noboru-i): dynamic is really ok?
      value = Resource<RoomList>.error(error.toString());
    });
  }

  Future<void> addRoom(Room room) async {
    await roomRepository.addRoom(room);
  }

  @override
  void dispose() {
    super.dispose();

    _subscription?.cancel();
  }
}
