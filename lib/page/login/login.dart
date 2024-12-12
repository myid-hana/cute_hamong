import 'package:cute_hamong/components/login_button.dart';
import 'package:cute_hamong/page/login/image_slider.dart';
import 'package:cute_hamong/style/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  Future<void> signInWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? account = await googleSignIn.signIn();
    if (account == null) {
      print('로그인 실패');
      return;
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
      return;
    }
    final user = credential.user;
    print('로그인 성공 ${user!.displayName}');
  }

  Future<void> signInWithKakao() async {
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
    } catch (error) {
      print('카카오계정으로 로그인 실패 $error');
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
              onPressed: () => signInWithKakao(),
            ),
            const SizedBox(height: 10),
            LoginButton(
              text: '구글로 로그인하기',
              image: 'lib/assets/images/google.png',
              backgroundColor: Colors.white,
              onPressed: () => signInWithGoogle(),
            ),
          ],
        ),
      ),
    );
  }
}