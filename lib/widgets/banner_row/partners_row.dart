import 'package:flutter/material.dart';

import '../../repositories/partners_repository.dart';
import '../banners/partners_banner.dart';

class PartnersRow extends StatelessWidget {
  const PartnersRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(partners.length, (index) {
          final partner = partners[index];
          return PartnersBanner(
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
