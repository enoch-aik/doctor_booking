import 'package:flutter/material.dart';

class OnBoardingPageIndicator extends StatelessWidget {
  const OnBoardingPageIndicator({
    Key? key,
    required this.currentPage,
    required this.totalPages,
  }) : super(key: key);
  final int currentPage;
  final int totalPages;

  @override
  Widget build(BuildContext context) {
    Color getColor(index) => index == currentPage
        ? Theme.of(context).primaryColor
        : const Color(0xffD9D9D9);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        totalPages,
        (index) => TabPageSelectorIndicator(
          backgroundColor: getColor(index),
          size: 8,
          borderColor: getColor(index),
        ),
      ),
    );
  }
}
