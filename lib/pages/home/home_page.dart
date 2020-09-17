import 'package:flutter/material.dart';
import 'package:kyouen_vs_flutter/entities/login_user.dart';
import 'package:kyouen_vs_flutter/entities/resource.dart';
import 'package:kyouen_vs_flutter/models/login_controller.dart';
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
            Consumer<LoginController>(
              builder:
                  (BuildContext context, LoginController loginController, _) {
                final String name = loginController.value.maybeMap(
                    (Data<LoginUser> v) => v.value.name,
                    orElse: () => 'not logged in');
                return Text('user name: $name');
              },
            ),
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
    Provider.of<LoginController>(context, listen: false).signInAnonymously();
  }

  void _moveToRoomList(BuildContext context) {
    Navigator.pushNamed(context, RoomListPage.routeName);
  }
}
