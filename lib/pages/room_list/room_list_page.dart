import 'package:flutter/material.dart';
import 'package:kyouen_vs_flutter/entities/player.dart';
import 'package:kyouen_vs_flutter/entities/room.dart';
import 'package:kyouen_vs_flutter/pages/kyouen/kyouen_page.dart';
import 'package:kyouen_vs_flutter/pages/room_list/room_list_controller.dart';
import 'package:kyouen_vs_flutter/pages/room_list/room_list_item.dart';
import 'package:kyouen_vs_flutter/repositories/room_repository.dart';
import 'package:provider/provider.dart';

class RoomListPage extends StatelessWidget {
  static const String routeName = '/room_list';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RoomListController>(
      create: (_) => RoomListController(RoomRepository.instance),
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
    Provider.of<RoomListController>(context, listen: false).addRoom(
      const Room(
        owner: Player(name: 'owner'), // TODO(noboru-i): implement later.
        isOwnerFirstMove: true,
        size: 6,
      ),
    );
  }
}

class RoomListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<RoomListController>(
      builder: (BuildContext context, RoomListController controller, _) {
        return controller.value.when(
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
