import 'package:cute_hamong/components/login_button.dart';
import 'package:cute_hamong/components/toast.dart';
import 'package:cute_hamong/page/login/image_slider.dart';
import 'package:cute_hamong/style/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LoginImageSlider(),
            const SizedBox(height: 70),
            LoginButton(
                text: '카카오톡으로 로그인하기',
                image: 'lib/assets/images/kakaotalk.png',
                backgroundColor: AppColors.kakaoYellow,
                onPressed: () async {
                  final result = await signInWithKakao();
                  if (result && context.mounted) {
                    context.go('/home');
                  } else {
                    ToastMessage.show('로그인에 실패했습니다. 다시 시도해주세요.');
                  }
                }),
            const SizedBox(height: 10),
            LoginButton(
                text: '구글로 로그인하기',
                image: 'lib/assets/images/google.png',
                backgroundColor: Colors.white,
                onPressed: () async {
                  final result = await signInWithGoogle();
                  if (result && context.mounted) {
                    context.go('/home');
                  } else {
                    ToastMessage.show('로그인에 실패했습니다. 다시 시도해주세요.');
                  }
                }),
          ],
        ),
      ),
    );
  }
}
