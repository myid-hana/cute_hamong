import 'package:cute_hamong/components/progress_bar.dart';
import 'package:cute_hamong/page/login/google_login_button.dart';
import 'package:cute_hamong/page/login/image_slider.dart';
import 'package:cute_hamong/page/login/kakao_login_button.dart';
import 'package:cute_hamong/state/login.dart';
import 'package:cute_hamong/style/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showProgressBar = ref.watch(loginProgressBarProvider);

    return Scaffold(
      body: Stack(
        children: [
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoginImageSlider(),
                SizedBox(height: 70),
                KakaoLoginButton(),
                SizedBox(height: 10),
                GoogleLoginButton(),
              ],
            ),
          ),
          if (showProgressBar)
            Container(
              width: double.infinity,
              height: double.infinity,
              color: AppColors.black.withOpacity(0.3),
            ),
          if (showProgressBar) const ProgressBar(),
        ],
      ),
    );
  }
}
