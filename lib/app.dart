import 'package:flutter/material.dart';
import 'package:kyouen_vs_flutter/pages/home/home_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kyouen VS',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => HomePage(),
      },
    );
  }
}
