import 'dart:async';
import 'package:cute_hamong/config/router.dart';
import 'package:cute_hamong/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runZonedGuarded(() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    KakaoSdk.init(
      nativeAppKey: '361236e911593a4582642984d1cafbd9',
    );
  }, (_, stackTrace) {});

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'CUTE HAMONG',
      theme: appTheme,
    );
  }
}
