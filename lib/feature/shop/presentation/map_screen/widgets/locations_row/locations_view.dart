import 'package:flutter/material.dart';

import 'package:iman_invest/feature/shop/data/models/merchant.dart';
import 'package:iman_invest/feature/shop/presentation/map_screen/widgets/view_location/view_location.dart';

///
class LocationsRow extends StatelessWidget {
  ///
  const LocationsRow({
    required this.merchants,
    super.key,
  });

  ///
  final List<Merchant> merchants;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10,
      left: 0,
      right: 0,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 149,
          ),
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: merchants.length,
            itemBuilder: (context, index) => ViewLocation(
              merchant: merchants[index],
            ),
          ),
        ),
      ),
    );
  }
}
