import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kyouen_vs_flutter/entities/room.dart';

class RoomRepository {
  static final RoomRepository instance = RoomRepository();

  Future<void> addRoom(Room room) async {
    await Firestore.instance
        .collection('rooms')
        .document()
        .setData(room.toMap());
  }

  // TODO(noboru-i): change return value to exclude Firestore dependency.
  Stream<QuerySnapshot> snapshots() {
    return Firestore.instance
        .collection('rooms')
        .orderBy(
          'created_at',
          descending: true,
        )
        .snapshots();
  }

  Stream<Room> fetch(String roomId) {
    return Firestore.instance
        .collection('rooms')
        .document(roomId)
        .snapshots()
        .asyncMap((DocumentSnapshot snapshot) {
      return Room.fromMap(snapshot.data);
    });
  }

  Stream<List<Point>> fetchStones(String roomId) {
    return Firestore.instance
        .collection('rooms')
        .document(roomId)
        .collection('points')
        .snapshots()
        .asyncMap((QuerySnapshot snapshot) {
      return snapshot.documents.map((DocumentSnapshot doc) {
        return Point.fromMap(doc.data);
      }).toList();
    });
  }

  void putStone(String roomId, Point point) {
    final map = point.toMap()
      ..addAll(<String, dynamic>{
        'createdAt': FieldValue.serverTimestamp(),
      });

    Firestore.instance
        .collection('rooms')
        .document(roomId)
        .collection('points')
        .add(map);
  }
}
