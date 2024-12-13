import 'package:cute_hamong/components/login_button.dart';
import 'package:cute_hamong/components/toast.dart';
import 'package:cute_hamong/state/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLoginButton extends ConsumerWidget {
  const GoogleLoginButton({super.key});

  Future<bool> signInWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? account = await googleSignIn.signIn();
    if (account == null) {
      print('로그인 실패');
      return false;
    }

    GoogleSignInAuthentication authentication = await account.authentication;
    OAuthCredential googleCredential = GoogleAuthProvider.credential(
      idToken: authentication.idToken,
      accessToken: authentication.accessToken,
    );
    UserCredential credential =
        await FirebaseAuth.instance.signInWithCredential(googleCredential);
    if (credential.user == null) {
      print('파이어베이스 연동 실패');
      return false;
    }
    final user = credential.user;
    print('로그인 성공 ${user!.displayName}');
    return true;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LoginButton(
      text: '구글로 로그인하기',
      image: 'lib/assets/images/google.png',
      backgroundColor: Colors.white,
      onPressed: () async {
        ref.read(loginProgressBarProvider.notifier).state = true;
        final result = await signInWithGoogle();
        ref.read(loginProgressBarProvider.notifier).state = false;
        if (result && context.mounted) {
          context.go('/home');
        } else {
          ToastMessage.show('로그인에 실패했습니다. 다시 시도해주세요.');
        }
      },
    );
  }
}
