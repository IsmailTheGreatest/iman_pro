import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// ListOfStoreItemShimmer class
class ListOfStoreItemShimmer extends StatelessWidget {
  /// ListOfStoreItemShimmer constructor
  const ListOfStoreItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
      child: Row(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: 20,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 20,
              height: 20,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
