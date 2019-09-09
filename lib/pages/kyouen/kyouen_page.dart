import 'package:flutter/material.dart';
import 'package:kyouen_vs_flutter/blocs/kyouen_bloc.dart';
import 'package:kyouen_vs_flutter/entities/player.dart';
import 'package:kyouen_vs_flutter/entities/room.dart';
import 'package:kyouen_vs_flutter/pages/kyouen/stone_view.dart';
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
    final KyouenPageArguments args = ModalRoute.of(context).settings.arguments;
    final String roomId = args.roomId;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kyouen'),
      ),
      body: Provider<KyouenBloc>(
        builder: (_) => KyouenBloc(roomId),
        dispose: (_, KyouenBloc bloc) => bloc.dispose(),
        child: Builder(
          builder: (BuildContext context) {
            return StreamBuilder<RoomDocument>(
                stream: Provider.of<KyouenBloc>(context).room,
                builder: (BuildContext context,
                    AsyncSnapshot<RoomDocument> snapshot) {
                  if (snapshot.connectionState != ConnectionState.active) {
                    return const Text('please wait...');
                  }
                  final Room room = snapshot.data.room;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      _PlayerContainerView(
                        room: room,
                      ),
                      _KyouenView(
                        room: room,
                      ),
                    ],
                  );
                });
          },
        ),
      ),
    );
  }
}

class _PlayerContainerView extends StatelessWidget {
  const _PlayerContainerView({
    @required this.room,
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
    @required this.player,
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
    @required this.room,
  });

  final Room room;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Container(
        color: Colors.green,
        child: StreamBuilder<List<Point>>(
          stream: Provider.of<KyouenBloc>(context).points,
          builder: (BuildContext context, AsyncSnapshot<List<Point>> snapshot) {
            if (snapshot.connectionState != ConnectionState.active) {
              return Container();
            }

            final List<Point> points = snapshot.data ?? <Point>[];
            return GridView.builder(
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

    final KyouenBloc bloc = Provider.of<KyouenBloc>(context);

    bloc.putStone.add(Point.fromIndex(
      room.size,
      index,
    ));
  }
}
