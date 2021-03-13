import 'package:flutter/material.dart';
import 'package:kyouen_vs_flutter/entities/player.dart';
import 'package:kyouen_vs_flutter/entities/resource.dart';
import 'package:kyouen_vs_flutter/entities/room.dart';
import 'package:kyouen_vs_flutter/pages/kyouen/kyouen_controller.dart';
import 'package:kyouen_vs_flutter/pages/kyouen/stone_view.dart';
import 'package:kyouen_vs_flutter/repositories/room_repository.dart';
import 'package:provider/provider.dart';

@immutable
class KyouenPageArguments {
  const KyouenPageArguments(this.roomId);

  final String roomId;
}

class KyouenPage extends StatelessWidget {
  static const String routeName = '/kyouen';

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as KyouenPageArguments;
    final roomId = args.roomId;

    return ChangeNotifierProvider<KyouenController>(
      create: (_) => KyouenController(RoomRepository.instance, roomId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Kyouen'),
        ),
        body: Builder(
          builder: (BuildContext context) {
            return Selector<KyouenController, Resource<RoomDocument>>(
              selector: (_, KyouenController controller) {
                return controller.value.roomDocumentResource;
              },
              builder: (BuildContext context,
                  Resource<RoomDocument> roomDocumentResource, _) {
                return roomDocumentResource.when(
                  (RoomDocument roomDocument) => Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      _PlayerContainerView(
                        room: roomDocument.room,
                      ),
                      _KyouenView(
                        room: roomDocument.room,
                      ),
                    ],
                  ),
                  loading: () => const Text('please wait...'),
                  error: (String error) => Text('Error: $error'),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _PlayerContainerView extends StatelessWidget {
  const _PlayerContainerView({
    required this.room,
  });

  final Room room;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const <Widget>[
        // TODO(noboru-i): create Player from Room.
        _PlayerView(player: Player(name: 'You')),
        _PlayerView(player: Player(name: 'Rival')),
      ],
    );
  }
}

class _PlayerView extends StatelessWidget {
  const _PlayerView({
    required this.player,
  });

  final Player player;

  @override
  Widget build(BuildContext context) {
    // TODO(noboru-i): show which player is thinking.
    return Text(player.name);
  }
}

class _KyouenView extends StatelessWidget {
  const _KyouenView({
    required this.room,
  });

  final Room room;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Container(
        color: Colors.green,
        child: Selector<KyouenController, Resource<List<Point>>>(
          selector: (_, KyouenController controller) {
            return controller.value.pointsResource;
          },
          builder:
              (BuildContext context, Resource<List<Point>> pointsResource, _) {
            return pointsResource.when(
              (List<Point> points) => GridView.builder(
                itemCount: room.size * room.size,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: room.size,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final Point indexPoint = Point.fromIndex(room.size, index);
                  final bool hasStone = points.contains(indexPoint);
                  final StoneState state =
                      hasStone ? StoneState.black : StoneState.none;

                  return StoneView(
                    state: state,
                    onTap: () => _onTapStone(context, index, state),
                  );
                },
              ),
              loading: () => Container(),
              error: (String error) => Container(),
            );
          },
        ),
      ),
    );
  }

  void _onTapStone(BuildContext context, int index, StoneState state) {
    if (state == StoneState.black) {
      // already put stone
      return;
    }

    Provider.of<KyouenController>(context, listen: false).putStone(
      Point.fromIndex(
        room.size,
        index,
      ),
    );
  }
}
