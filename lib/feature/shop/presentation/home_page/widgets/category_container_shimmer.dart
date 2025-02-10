import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

///
class CategoryContainerShimmer extends StatelessWidget {
  ///
  const CategoryContainerShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
     padding: EdgeInsets.zero,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xffF4F4F5),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: 50,
                width: 50,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: SizedBox(
              width: 80,
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 12,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
