import 'package:flutter/material.dart';

import '../../repositories/partners_repository.dart';
import '../banners/partners_small_banner.dart';
class SmallPartnersRow extends StatelessWidget {
  const SmallPartnersRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(smallPartners.length, (index) {
          final partner = smallPartners[index];
          return PartnersSmallBanner(
            imageUrl: partner.imageUrl,
            title: partner.title,
            distance: partner.distance,
            storeIconImgUrl: partner.storeIconImgUrl,
          );
        }),
      ),
    );
  }
}
