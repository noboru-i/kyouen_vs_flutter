import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kyouen_vs_flutter/entities/room.dart';

class RoomRepository {
  static final RoomRepository instance = RoomRepository();

  Future<void> addRoom(Room room) async {
    await Firestore.instance
        .collection('rooms')
        .document()
        .setData(room.toJson());
  }

  Stream<RoomDocument> fetch(String roomId) {
    return Firestore.instance
        .collection('rooms')
        .document(roomId)
        .snapshots()
        .asyncMap((DocumentSnapshot snapshot) {
      return RoomDocument(
        id: snapshot.documentID,
        room: Room.fromJson(snapshot.data),
      );
    });
  }

  Stream<List<RoomDocument>> fetchRooms() {
    return Firestore.instance
        .collection('rooms')
        .orderBy(
          'created_at',
          descending: true,
        )
        .snapshots()
        .asyncMap((QuerySnapshot snapshot) {
      return snapshot.documents.map((DocumentSnapshot doc) {
        return RoomDocument(id: doc.documentID, room: Room.fromJson(doc.data));
      }).toList();
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
    final Map<String, dynamic> map = point.toMap()
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
