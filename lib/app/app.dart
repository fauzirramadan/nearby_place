import 'package:flutter/material.dart';

import '../views/pages/home.dart';

final GlobalKey<ScaffoldMessengerState> notifKey = GlobalKey();
final GlobalKey<NavigatorState> navKey = GlobalKey();

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: notifKey,
      navigatorKey: navKey,
      title: 'Nearby Places',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.deepPurple,
      ),
      home: HomePage(),
    );
  }
}
