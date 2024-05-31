import 'package:ai_frontend/home.dart';
import 'package:go_router/go_router.dart';

import 'join.dart';
import 'login.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/join',
      builder: (context, state) => const JoinPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
  ],
);
