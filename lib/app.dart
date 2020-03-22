import 'package:flutter/material.dart';
import 'package:kyouen_vs_flutter/models/login_controller.dart';
import 'package:kyouen_vs_flutter/pages/home/home_page.dart';
import 'package:kyouen_vs_flutter/pages/kyouen/kyouen_page.dart';
import 'package:kyouen_vs_flutter/pages/room_list/room_list_page.dart';
import 'package:kyouen_vs_flutter/repositories/login_repository.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
}
