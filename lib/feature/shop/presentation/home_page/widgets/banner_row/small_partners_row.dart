import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iman_invest/feature/shop/presentation/home_page/bloc/merchants/merchant_bloc.dart';
import 'package:iman_invest/feature/shop/presentation/home_page/bloc/merchants/merchant_state.dart';
import '../../../../../../core/utils/navigate_without_transition.dart';
import '../../../map_screen/map_screen.dart';
import '../../bloc/merchants/merchant_event.dart';
import '../banners/partners_small_banner.dart';
import '../banners/partners_small_banner_shimmer.dart';

class SmallPartnersRow extends StatelessWidget {
  const SmallPartnersRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    context.read<SmallMerchantsBloc>().add(GetPartnersSmall());
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: BlocBuilder<SmallMerchantsBloc, SmallMerchantState>(
          builder: (context, state) {
        if (state is InitialSmallMerchants || state is LoadingSmallMerchants) {
          return Row(children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 243),
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const PartnersSmallBannerShimmer();
                },
              ),
            )
          ]);
        }
        if (state is ErrorSmallMerchants) {
          return Center(child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            height: 175,
            width: 175,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xff4059E6).withOpacity(0.1),
            ),

            padding: const EdgeInsets.all(8),
            child: const Icon(Icons.error, color: Colors.grey,  size: 30,),
          ));
        }
        if (state is LoadedSmallMerchants) {
          return Row(children: [
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 237,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: state.merchantsList.length,
                itemBuilder: (context, index) {
                  return PartnersSmallBanner(
                    onTap: () {
                      navigateWithoutTransition(
                          context,
                          MapScreen(
                            merchants: [state.merchantsList[index]],
                          ));
                    },
                    imageUrl: state.merchantsList[index].logo,
                    title: state.merchantsList[index].name,
                    distance: state.merchantsList[index].address.distance,
                  );
                },
              ),
            ),
          ]);
        }
        return const SizedBox();
      }),
    );
  }
}
