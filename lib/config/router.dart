import 'package:cute_hamong/page/home.dart';
import 'package:cute_hamong/page/login.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/login', //TODO fix
  routes: [
    GoRoute(
      path: '/home',
      builder: (context, state) => const MyHomePage(title: 'Home Page'),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
  ],
);
