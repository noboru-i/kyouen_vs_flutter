import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kyouen_vs_flutter/pages/room_list/room_list_page.dart';

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
              onPressed: _signIn,
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

  Future<FirebaseUser> _signIn() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    // TODO(noboru-i): Sign in with Twitter is crashed. So temporally login anonymously.
    final AuthResult result = await _auth.signInAnonymously();

    print('signed in ${result.user.uid}');

    return result.user;
  }

  void _moveToRoomList(BuildContext context) {
    Navigator.pushNamed(context, RoomListPage.routeName);
  }
}
