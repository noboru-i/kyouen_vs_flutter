import 'package:flutter/material.dart';
import 'package:kyouen_vs_flutter/blocs/login_bloc.dart';
import 'package:kyouen_vs_flutter/pages/room_list/room_list_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () => _signIn(context),
              child: const Text(
                'Sign in anonymously',
              ),
            ),
            RaisedButton(
              onPressed: () => _moveToRoomList(context),
              child: const Text(
                'Move to room list',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _signIn(BuildContext context) async {
    Provider.of<LoginBloc>(context).login.add(null);
  }

  void _moveToRoomList(BuildContext context) {
    Navigator.pushNamed(context, RoomListPage.routeName);
  }
}
