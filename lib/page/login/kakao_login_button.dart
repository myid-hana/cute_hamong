import 'package:cute_hamong/components/login_button.dart';
import 'package:cute_hamong/components/toast.dart';
import 'package:cute_hamong/state/login.dart';
import 'package:cute_hamong/style/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class KakaoLoginButton extends ConsumerWidget {
  const KakaoLoginButton({super.key});

  Future<bool> signInWithKakao() async {
    try {
      OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
      var provider = OAuthProvider('oidc.kakao_login');
      var kakaocredential = provider.credential(
        idToken: token.idToken,
        accessToken: token.accessToken,
      );
      UserCredential credential =
          await FirebaseAuth.instance.signInWithCredential(kakaocredential);
      final user = credential.user;
      print('로그인 성공 ${user!.displayName}');
      return true;
    } catch (error) {
      print('카카오계정으로 로그인 실패 $error');
      return false;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LoginButton(
      text: '카카오톡으로 로그인하기',
      image: 'lib/assets/images/kakaotalk.png',
      backgroundColor: AppColors.kakaoYellow,
      onPressed: () async {
        ref.read(loginProgressBarProvider.notifier).state = true;
        final result = await signInWithKakao();
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
