import 'package:flutter/material.dart';
import 'package:kyouen_vs_flutter/blocs/kyouen_bloc.dart';
import 'package:kyouen_vs_flutter/entities/room.dart';
import 'package:kyouen_vs_flutter/pages/kyouen/stone_view.dart';
import 'package:provider/provider.dart';

class KyouenPageArguments {
  final String roomId;

  KyouenPageArguments(this.roomId);
}

class KyouenPage extends StatelessWidget {
  static const routeName = '/kyouen';

  @override
  Widget build(BuildContext context) {
    final KyouenPageArguments args = ModalRoute.of(context).settings.arguments;
    final roomId = args.roomId;

    return Scaffold(
      appBar: AppBar(
        title: Text("Kyouen"),
      ),
      body: Provider<KyouenBloc>(
        builder: (_) => KyouenBloc(roomId),
        dispose: (_, bloc) => bloc.dispose(),
        child: Builder(
          builder: (context) {
            return StreamBuilder<Room>(
                stream: Provider.of<KyouenBloc>(context).room,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.active) {
                    return Text("please wait...");
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
  final Room room;

  _KyouenView({@required this.room});

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
          itemBuilder: (context, index) {
            final state = room.stage[index];
            return StoneView(
              state: state,
              onTap: () => _onTapStone(index),
            );
          },
        ),
      ),
    );
  }

  _onTapStone(int index) {}
}
