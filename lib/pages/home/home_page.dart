import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
}
