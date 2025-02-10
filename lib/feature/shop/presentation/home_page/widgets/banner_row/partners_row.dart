import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iman_invest/core/utils/navigate_without_transition.dart';
import 'package:iman_invest/feature/shop/presentation/home_page/bloc/merchants/merchant_bloc.dart';
import 'package:iman_invest/feature/shop/presentation/home_page/bloc/merchants/merchant_event.dart';
import 'package:iman_invest/feature/shop/presentation/home_page/bloc/merchants/merchant_state.dart';
import 'package:iman_invest/feature/shop/presentation/home_page/widgets/banners/partners_banner.dart';
import 'package:iman_invest/feature/shop/presentation/home_page/widgets/banners/partners_banner_shimmer.dart';
import 'package:iman_invest/feature/shop/presentation/map_screen/map_screen.dart';

///
class PartnersRow extends StatelessWidget {
  ///
  const PartnersRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    context.read<MerchantBloc>().add(GetPartners());
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: BlocBuilder<MerchantBloc, MerchantState>(
        builder: (context, state) {
          if (state is InitialMerchants || state is LoadingClosestMerchants) {
            return Row(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 243,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return const PartnersBannerShimmer();
                    },
                  ),
                ),
              ],
            );
          }

          if (state is ErrorMerchants) {
            return Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                height: 175,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xff4059E6).withValues(alpha: 0.1),
                ),
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.error,
                  color: Colors.grey,
                  size: 30,
                ),
              ),
            );
          }

          if (state is LoadedClosestMerchants) {
            return Row(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 237,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: state.merchantsList.length,
                    itemBuilder: (context, index) {
                      return PartnersBanner(
                        onTap: () {
                          navigateWithoutTransition(
                            context,
                            MapScreen(
                              merchants: [state.merchantsList[index]],
                            ),
                          );
                        },
                        imageUrl: state.merchantsList[index].logo,
                        title: state.merchantsList[index].name,
                        distance: state.merchantsList[index].address.distance,
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
