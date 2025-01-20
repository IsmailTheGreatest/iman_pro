import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class AdBannerRow extends StatelessWidget {
  const AdBannerRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/partners.png',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/partners.png'),
          )
        ],
        options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 335 / 130,
            enlargeCenterPage: false,
            viewportFraction: 0.90,
            scrollDirection: Axis.horizontal));
  }
}