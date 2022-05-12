import 'package:client/canvas/graph.dart';
import 'package:client/canvas/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorSchemeSeed: Colors.blueGrey,
        brightness: Brightness.dark,
      ),
      initialRoute: HomeCanvas.routeName,
      routes: {
        HomeCanvas.routeName: (context) => const HomeCanvas(),
        GraphCanvas.routeName: (context) => const GraphCanvas(),
      },
    );
  }
}
