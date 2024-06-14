import 'dart:async';
import 'package:flutter/material.dart';
import '../../../utilis/app_colors.dart';
import '../../../utilis/app_images.dart';


class MySlider extends StatefulWidget {
  const MySlider({super.key});

  @override
  _MySliderState createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  final List<String> promoImages = [
    AppImages.imgFirst,
    AppImages.imgSecond,
    AppImages.imgThird,
  ];

  final PageController _pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    startSlider();
  }

  void startSlider() {
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (currentIndex < promoImages.length - 1) {
        currentIndex++;
      } else {
        currentIndex = 0;
      }
      _pageController.animateToPage(
        currentIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return SizedBox(
      height: size.width*0.54,
      child: PageView.builder(
        controller: _pageController,
        itemCount: promoImages.length,
        itemBuilder: (context, index) {
          return SingleChildScrollView(
            child: Column(
              children: [
                PromoCard(promoImage: promoImages[index]),
                buildDots(index)
              ],
            ),
          );
        },
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }

  Widget buildDots(_currentPage) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3, // Replace with the actual number of images
            (index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentPage == index ? AppColors.primary: AppColors.greyB2AFAF,
            ),
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class PromoCard extends StatelessWidget {
  final String promoImage;

  const PromoCard({super.key, required this.promoImage});

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return SizedBox(
      height: size.height*0.23,
      width: double.infinity,
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            color: AppColors.primary,
            child: Opacity(
              opacity: 0.5,
              child: Image.asset(
                promoImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}




