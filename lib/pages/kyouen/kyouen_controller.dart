import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kyouen_vs_flutter/entities/resource.dart';
import 'package:kyouen_vs_flutter/entities/room.dart';
import 'package:kyouen_vs_flutter/repositories/room_repository.dart';

part 'kyouen_controller.freezed.dart';

@freezed
abstract class KyouenRoom with _$KyouenRoom {
  const factory KyouenRoom({
    required Resource<RoomDocument> roomDocumentResource,
    required Resource<List<Point>> pointsResource,
  }) = _KyouenRoom;
}

class KyouenController extends ValueNotifier<KyouenRoom> {
  KyouenController(
    this._roomRepository,
    this._roomId,
  )   : assert(_roomRepository != null),
        super(const KyouenRoom(
          roomDocumentResource: Resource<RoomDocument>.loading(),
          pointsResource: Resource<List<Point>>.loading(),
        )) {
    _subscribe(_roomId);
  }

  final RoomRepository _roomRepository;
  final String _roomId;

  StreamSubscription<RoomDocument>? _roomSubscription;
  StreamSubscription<List<Point>>? _pointsSubscription;

  Future<void> _subscribe(String roomId) async {
    _roomSubscription = _roomRepository.fetch(roomId).listen(
      (RoomDocument data) {
        value =
            value.copyWith(roomDocumentResource: Resource<RoomDocument>(data));
      },
      onError: (dynamic error) {
        // TODO(noboru-i): dynamic is really ok?
        value = value.copyWith(
            roomDocumentResource:
                Resource<RoomDocument>.error(error.toString()));
      },
    );

    _pointsSubscription = _roomRepository.fetchStones(roomId).listen(
      (List<Point> data) {
        value = value.copyWith(pointsResource: Resource<List<Point>>(data));
      },
      onError: (dynamic error) {
        // TODO(noboru-i): dynamic is really ok?
        value = value.copyWith(
            pointsResource: Resource<List<Point>>.error(error.toString()));
      },
    );
  }

  void putStone(Point point) {
    _roomRepository.putStone(_roomId, point);
  }

  @override
  void dispose() {
    super.dispose();

    _roomSubscription?.cancel();
    _pointsSubscription?.cancel();
  }
}
