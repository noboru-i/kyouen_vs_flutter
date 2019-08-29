import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kyouen_vs_flutter/blocs/room_bloc.dart';
import 'package:kyouen_vs_flutter/entities/room.dart';
import 'package:kyouen_vs_flutter/pages/kyouen/kyouen_page.dart';
import 'package:kyouen_vs_flutter/pages/room_list/room_list_item.dart';
import 'package:provider/provider.dart';

class RoomListPage extends StatelessWidget {
  static const routeName = '/room_list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Room list"),
      ),
      body: RoomListWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createRoom(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _createRoom(BuildContext context) async {
    final bloc = Provider.of<RoomBloc>(context);
    bloc.addRoom.add(Room(
      createdAt: DateTime.now(),
      numberOfPlayer: 0,
    ));
  }
}

class RoomListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<RoomBloc>(context);
    return StreamBuilder<QuerySnapshot>(
      stream: bloc.roomList,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Text('Loading...');
          default:
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                final room = Room.fromMap(snapshot.data.documents[index].data);
                return RoomListItem(
                  room: room,
                  onTap: () => _onTapItem(context, room),
                );
              },
              itemCount: snapshot.data.documents.length,
            );
        }
      },
    );
  }

  void _onTapItem(BuildContext context, Room room) {
    Navigator.pushNamed(
      context,
      KyouenPage.routeName,
      arguments: KyouenPageArguments(room),
    );
  }
}
