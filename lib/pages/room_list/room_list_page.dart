import 'package:flutter/material.dart';
import 'package:kyouen_vs_flutter/entities/player.dart';
import 'package:kyouen_vs_flutter/entities/room.dart';
import 'package:kyouen_vs_flutter/models/room_model.dart';
import 'package:kyouen_vs_flutter/pages/kyouen/kyouen_page.dart';
import 'package:kyouen_vs_flutter/pages/room_list/room_list_item.dart';
import 'package:kyouen_vs_flutter/repositories/room_repository.dart';
import 'package:provider/provider.dart';

class RoomListPage extends StatelessWidget {
  static const String routeName = '/room_list';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RoomModel>(
      create: (_) => RoomModel(RoomRepository.instance),
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
    final RoomModel model = Provider.of<RoomModel>(context, listen: false);
    model.addRoom(const Room(
      owner: Player(name: 'owner'), // TODO(noboru-i): implement later.
      isOwnerFirstMove: true,
      size: 6,
    ));
  }
}

class RoomListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<RoomModel>(
      builder: (BuildContext context, RoomModel model, _) {
        return model.value.when(
            (RoomList value) => ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    final RoomDocument roomDocument = value.data[index];
                    return RoomListItem(
                      room: roomDocument.room,
                      onTap: () => _onTapItem(context, roomDocument.id),
                    );
                  },
                  itemCount: value.data.length,
                ),
            loading: () => const Text('Loading...'),
            error: (String error) => Text('Error: $error'));
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
