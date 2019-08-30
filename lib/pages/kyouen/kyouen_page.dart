import 'package:flutter/material.dart';
import 'package:kyouen_vs_flutter/entities/room.dart';

class KyouenPageArguments {
  final Room room;

  KyouenPageArguments(this.room);
}

class KyouenPage extends StatelessWidget {
  static const routeName = '/kyouen';

  @override
  Widget build(BuildContext context) {
    final KyouenPageArguments args = ModalRoute.of(context).settings.arguments;
    final room = args.room;

    return Scaffold(
      appBar: AppBar(
        title: Text("Kyouen"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _KyouenView(
            room: room,
          ),
        ],
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
            final state = index % 2 == 0 ? StoneState.Black : StoneState.White;
            return _StoneView(
              state: state,
            );
          },
        ),
      ),
    );
  }
}

class _StoneView extends StatelessWidget {
  final StoneState state;

  _StoneView({
    this.state = StoneState.None,
  });

  @override
  Widget build(BuildContext context) {
    if (state == StoneState.None) {
      return Container();
    }

    final isBlack = state == StoneState.Black;
    return ClipOval(
      child: Material(
        color: isBlack ? Colors.black87 : Colors.white, // button color
        child: InkWell(
          splashColor:
              isBlack ? Colors.white60 : Colors.black45, // inkwell color
          onTap: () {},
        ),
      ),
    );
  }
}

enum StoneState {
  None,
  Black,
  White,
}
