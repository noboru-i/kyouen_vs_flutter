import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kyouen_vs_flutter/models/login_controller.dart';
import 'package:kyouen_vs_flutter/pages/home/home_page.dart';
import 'package:kyouen_vs_flutter/pages/kyouen/kyouen_page.dart';
import 'package:kyouen_vs_flutter/pages/room_list/room_list_page.dart';
import 'package:kyouen_vs_flutter/repositories/login_repository.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool _initialized = false;
  bool _error = false;

  @override
  void initState() {
    _initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      return const Text('error');
    }

    if (!_initialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return ChangeNotifierProvider<LoginController>(
      create: (_) => LoginController(LoginRepository.instance),
      child: MaterialApp(
        title: 'Kyouen VS',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        initialRoute: HomePage.routeName,
        routes: <String, WidgetBuilder>{
          HomePage.routeName: (BuildContext context) => HomePage(),
          RoomListPage.routeName: (BuildContext context) => RoomListPage(),
          KyouenPage.routeName: (BuildContext context) => KyouenPage(),
        },
      ),
    );
  }

  Future<void> _initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } on Exception catch (e) {
      print(e);
      setState(() {
        _error = true;
      });
    }
  }
}
