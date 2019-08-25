import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kyouen_vs_flutter/pages/room_list/room_list_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: _signIn,
              child: Text(
                'Sign in anonymously',
              ),
            ),
            RaisedButton(
              onPressed: _moveToRoomList,
              child: Text(
                'Move to room list',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<FirebaseUser> _signIn() async {
    final _auth = FirebaseAuth.instance;
    // TODO Sign in with Twitter is crashed. So temporally login anonymously.
    final result = await _auth.signInAnonymously();

    print("signed in ${result.user.uid}");

    return result.user;
  }

  void _moveToRoomList() async {
    Navigator.pushNamed(context, RoomListPage.routeName);
  }
}
