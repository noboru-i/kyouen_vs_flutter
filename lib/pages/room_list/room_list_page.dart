import 'package:flutter/material.dart';
import 'package:kyouen_vs_flutter/blocs/room_bloc.dart';
import 'package:kyouen_vs_flutter/entities/player.dart';
import 'package:kyouen_vs_flutter/entities/room.dart';
import 'package:kyouen_vs_flutter/pages/kyouen/kyouen_page.dart';
import 'package:kyouen_vs_flutter/pages/room_list/room_list_item.dart';
import 'package:provider/provider.dart';

class RoomListPage extends StatelessWidget {
  static const String routeName = '/room_list';

  @override
  Widget build(BuildContext context) {
    return Provider<RoomBloc>(
      builder: (_) => RoomBloc(),
      dispose: (_, RoomBloc bloc) => bloc.dispose(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Room list'),
        ),
        body: RoomListWidget(),
        floatingActionButton: Builder(
          builder: (BuildContext context) => FloatingActionButton(
            onPressed: () => _createRoom(context),
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  Future<void> _createRoom(BuildContext context) async {
    final RoomBloc bloc = Provider.of<RoomBloc>(context);
    bloc.addRoom.add(const Room(
      owner: Player(name: 'owner'), // TODO(noboru-i): implement later.
      isOwnerFirstMove: true,
      size: 6,
    ));
  }
}

class RoomListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RoomBloc bloc = Provider.of<RoomBloc>(context);
    return StreamBuilder<List<RoomDocument>>(
      stream: bloc.roomList,
      builder:
          (BuildContext context, AsyncSnapshot<List<RoomDocument>> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }
        if (snapshot.data.isEmpty) {
          return const Text('There is no rooms.');
        }

        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            final RoomDocument roomDocument = snapshot.data[index];
            return RoomListItem(
              room: roomDocument.room,
              onTap: () => _onTapItem(context, roomDocument.id),
            );
          },
          itemCount: snapshot.data.length,
        );
      },
    );
  }

  void _onTapItem(BuildContext context, String roomId) {
    Navigator.pushNamed(
      context,
      KyouenPage.routeName,
      arguments: KyouenPageArguments(roomId),
    );
  }
}
