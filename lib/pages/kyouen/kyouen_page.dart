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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              room.createdAt.toIso8601String(),
            ),
          ],
        ),
      ),
    );
  }
}
