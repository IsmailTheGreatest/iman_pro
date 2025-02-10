import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iman_invest/feature/shop/presentation/home_page/bloc/event.dart'
    show FetchBannerImages;
import 'package:iman_invest/feature/shop/presentation/home_page/bloc/homepage_bloc.dart';
import 'package:iman_invest/feature/shop/presentation/home_page/bloc/state.dart';
import 'package:iman_invest/feature/shop/presentation/home_page/widgets/banner_row/ad_banner_shimmer.dart';

///
class AdBannerRow extends StatelessWidget {
  ///
  const AdBannerRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    context.read<HomePageBloc>().add(FetchBannerImages());
    return BlocBuilder<HomePageBloc, AddBannerState>(
      builder: (context, state) {
        if (state is Initial || state is LoadingAd) {
          return const AdBannerShimmer();
        } else if (state is LoadedAd) {
          return CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 335 / 130,
              viewportFraction: 0.90,
            ),
            items: state.bannerImagesList.map((image) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }).toList(),
          );
        } else if (state is Error) {
          return Center(child: Text(state.message));
        }
        return const SizedBox();
      },
    );
  }
}
