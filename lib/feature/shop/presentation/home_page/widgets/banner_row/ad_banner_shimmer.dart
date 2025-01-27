

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AdBannerShimmer extends StatelessWidget {
  const AdBannerShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 11),
              decoration: const BoxDecoration(
                borderRadius:  BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                color:  Colors.white,
              ),
              width: 14,
              height: 130,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 11),
              decoration:  BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              width: 335,
              height: 130,

            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 11),
              decoration: const  BoxDecoration(
                borderRadius:  BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                color: Colors.white,
              ),
              width: 13.7,
              height: 130,
            ),
          ],
        ));
  }
}
