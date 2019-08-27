import 'package:cloud_firestore/cloud_firestore.dart';

class Room {
  final DateTime createdAt;
  final int numberOfPlayer;

  Room({this.createdAt, this.numberOfPlayer});

  Room.fromMap(Map<String, dynamic> source)
      : createdAt = (source['created_at'] as Timestamp).toDate(),
        numberOfPlayer = source['number_of_player'] {}

  Map<String, dynamic> toMap() {
    return {
      'created_at': createdAt,
      'number_of_player': numberOfPlayer,
    };
  }
}
