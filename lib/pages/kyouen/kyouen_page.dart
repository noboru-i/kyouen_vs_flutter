import 'package:flutter/material.dart';
import 'package:kyouen_vs_flutter/blocs/kyouen_bloc.dart';
import 'package:kyouen_vs_flutter/entities/room.dart';
import 'package:kyouen_vs_flutter/pages/kyouen/stone_view.dart';
import 'package:provider/provider.dart';

class KyouenPageArguments {
  KyouenPageArguments(this.roomId);

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
            return StreamBuilder<Room>(
                stream: Provider.of<KyouenBloc>(context).room,
                builder: (BuildContext context, AsyncSnapshot<Room> snapshot) {
                  if (snapshot.connectionState != ConnectionState.active) {
                    return const Text('please wait...');
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      _KyouenView(
                        room: snapshot.data,
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

class _KyouenView extends StatelessWidget {
  const _KyouenView({@required this.room});

  final Room room;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Container(
        color: Colors.green,
        child: GridView.builder(
          itemCount: 6 * 6,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6,
          ),
          itemBuilder: (BuildContext context, int index) {
            final StoneState state = room.stage[index];
            return StoneView(
              state: state,
              onTap: () => _onTapStone(index),
            );
          },
        ),
      ),
    );
  }

  void _onTapStone(int index) {}
}
