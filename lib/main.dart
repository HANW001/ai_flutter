import 'package:ai_frontend/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'login.dart';
import 'router.dart';

void main() {
  runApp(
    Provider.value(
      value: router, // Your GoRouter instance from router.dart
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthState(),
        ),
        ChangeNotifierProvider(
          create: (context) => UrlState(),
        ),
        ChangeNotifierProvider(
          create: (context) => AccessState(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerConfig: router,
        // home: const LoginPage(),
      ),
    );
  }
}
