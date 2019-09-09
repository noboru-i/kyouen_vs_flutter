import 'package:flutter/material.dart';
import 'package:kyouen_vs_flutter/entities/room.dart';

@immutable
class RoomListItem extends StatelessWidget {
  const RoomListItem({
    @required this.room,
    @required this.onTap,
  });

  final Room room;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(room.createdAt?.toIso8601String() ?? ''),
      onTap: onTap,
    );
  }
}
