import 'package:cute_hamong/page/home.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/home',
      builder: (context, state) => const MyHomePage(title: 'Home Page'),
    ),
  ],
);
