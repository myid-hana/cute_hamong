import 'package:cute_hamong/style/color.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final VoidCallback onPressed;
  final String image;

  const LoginButton({
    required this.text,
    required this.backgroundColor,
    required this.onPressed,
    required this.image,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: AppColors.black,
        textStyle: Theme.of(context).textTheme.bodyMedium,
        maximumSize: const Size(300, 50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            width: 20,
            height: 20,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 10),
          Text(text),
        ],
      ),
    );
  }
}
