import 'package:carousel_slider/carousel_slider.dart';
import 'package:cute_hamong/style/color.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class LoginImageSlider extends StatefulWidget {
  const LoginImageSlider({super.key});

  @override
  State<LoginImageSlider> createState() => _LoginImageSliderState();
}

class _LoginImageSliderState extends State<LoginImageSlider> {
  int _current = 0;
  final List<String> subTitles = [
    '큐트하몽에 로그인하면 하몽이 사진을 등록, 저장할 수 있어요',
    '다른 사람이 올린 하몽이의 사진을 볼 수 있어요',
    '소중한 하몽이의 사진을 다른 사람들과 공유할 수 있어요',
    '올린 하몽이 사진의 개수에 따라 하몽이 뱃지를 받을 수 있어요',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: List.from(
            List.generate(
              4,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Image.asset(
                        'lib/assets/images/login_$index.png',
                        fit: BoxFit.fitHeight,
                        width: 300,
                        height: 300,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      '큐트하몽',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: AppColors.gray500),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      subTitles[index],
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          options: CarouselOptions(
            height: 450.0,
            autoPlay: true,
            aspectRatio: 16 / 9,
            viewportFraction: 1,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        AnimatedSmoothIndicator(
          activeIndex: _current,
          count: 4,
          effect: const ScrollingDotsEffect(
            dotWidth: 8.0,
            dotHeight: 8.0,
            activeDotColor: AppColors.black,
            dotColor: AppColors.gray400,
          ),
        ),
      ],
    );
  }
}
