import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
///
class PartnersSmallBannerShimmer extends StatelessWidget {
  ///
  const PartnersSmallBannerShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 145,
            width: 145,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 20,
            width: 100,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 20,
            width: 150,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
