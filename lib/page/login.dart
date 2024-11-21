import 'package:cute_hamong/components/login_button.dart';
import 'package:cute_hamong/style/color.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/images/splash.png',
              width: 300,
              height: 300,
              fit: BoxFit.contain,
            ),
            Text(
              '큐트하몽',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: AppColors.gray500),
            ),
            const SizedBox(height: 20),
            LoginButton(
              text: '카카오톡으로 로그인하기',
              image: 'lib/assets/images/kakaotalk.png',
              backgroundColor: AppColors.kakaoYellow,
              onPressed: () {},
            ),
            const SizedBox(height: 10),
            LoginButton(
              text: '구글로 로그인하기',
              image: 'lib/assets/images/google.png',
              backgroundColor: Colors.white,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
