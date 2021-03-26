import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kyouen_vs_flutter/entities/room.dart';

class RoomRepository {
  static final RoomRepository instance = RoomRepository();

  Future<void> addRoom(Room room) async {
    final map = room.toJson()
      ..addAll(<String, dynamic>{
        'created_at': FieldValue.serverTimestamp(),
      });

    await FirebaseFirestore.instance.collection('rooms').doc().set(map);
  }

  Stream<RoomDocument> fetch(String roomId) {
    return FirebaseFirestore.instance
        .collection('rooms')
        .doc(roomId)
        .snapshots()
        .asyncMap((DocumentSnapshot snapshot) {
      return RoomDocument(
        id: snapshot.id,
        room: Room.fromJson(snapshot.data() as Map<String, dynamic>),
      );
    });
  }

  Stream<List<RoomDocument>> fetchRooms() {
    return FirebaseFirestore.instance
        .collection('rooms')
        .orderBy(
          'created_at',
          descending: true,
        )
        .snapshots()
        .asyncMap((QuerySnapshot snapshot) {
      return snapshot.docs.map((DocumentSnapshot snapshot) {
        return RoomDocument(
          id: snapshot.id,
          // TODO(noboru-i): Check it later about "!".
          room: Room.fromJson(snapshot.data() as Map<String, dynamic>),
        );
      }).toList();
    });
  }

  Stream<List<Point>> fetchStones(String roomId) {
    return FirebaseFirestore.instance
        .collection('rooms')
        .doc(roomId)
        .collection('points')
        .snapshots()
        .asyncMap((QuerySnapshot snapshot) {
      return snapshot.docs.map((DocumentSnapshot snapshot) {
        // TODO(noboru-i): Check it later about "!".
        return Point.fromJson(snapshot.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  void putStone(String roomId, Point point) {
    final map = point.toJson()
      ..addAll(<String, dynamic>{
        'created_at': FieldValue.serverTimestamp(),
      });

    FirebaseFirestore.instance
        .collection('rooms')
        .doc(roomId)
        .collection('points')
        .add(map);
  }
}
