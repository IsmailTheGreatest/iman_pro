import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/utils/navigate_without_transition.dart';
import '../../map_screen/map_screen.dart';
import '../bloc/merchants/merchant_bloc.dart';
import '../bloc/merchants/merchant_state.dart';

class TopRowHomePage extends StatelessWidget {
  const TopRowHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Магазины",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          BlocBuilder<MerchantBloc, MerchantState>(
            builder: (context, state) {
              if (state is LoadedClosestMerchants) {
                return InkWell(
                  onTap: () {
                    navigateWithoutTransition(
                        context, MapScreen(merchants: state.merchantsList));
                  },
                  child: SvgPicture.asset(
                    'assets/icons.svg',
                    height: 26,
                    width: 26,
                  ),
                );
              }
              return SvgPicture.asset(
                'assets/icons.svg',
                height: 26,
                width: 26,
              );
            },
          ),
        ],
      ),
    );
  }
}
