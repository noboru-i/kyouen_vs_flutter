import 'package:flutter/material.dart';
import 'package:kyouen_vs_flutter/entities/room.dart';

class RoomListItem extends StatelessWidget {
  final Room room;

  RoomListItem({
    @required this.room,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(room.createdAt?.toIso8601String() ?? 'no data'),
      onTap: () => print("tap item ${room.createdAt}"),
    );
    ;
  }
}
