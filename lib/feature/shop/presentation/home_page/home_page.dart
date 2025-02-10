import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iman_invest/core/widgets/headers/header.dart';
import 'package:iman_invest/feature/shop/domain/usecases/get_banner_images_usecase.dart';
import 'package:iman_invest/feature/shop/domain/usecases/get_categories_usecase.dart';
import 'package:iman_invest/feature/shop/domain/usecases/get_partners_usecase.dart';
import 'package:iman_invest/feature/shop/domain/usecases/get_sorted_partners_usecase.dart';
import 'package:iman_invest/feature/shop/presentation/home_page/bloc/event.dart';
import 'package:iman_invest/feature/shop/presentation/home_page/bloc/homepage_bloc.dart';
import 'package:iman_invest/feature/shop/presentation/home_page/bloc/merchants/merchant_bloc.dart'
    show MerchantBloc, SmallMerchantsBloc;
import 'package:iman_invest/feature/shop/presentation/home_page/bloc/merchants/merchant_event.dart';
import 'package:iman_invest/feature/shop/presentation/home_page/widgets/banner_row/add_banner_row.dart';
import 'package:iman_invest/feature/shop/presentation/home_page/widgets/banner_row/partners_row.dart';
import 'package:iman_invest/feature/shop/presentation/home_page/widgets/banner_row/small_partners_row.dart';
import 'package:iman_invest/feature/shop/presentation/home_page/widgets/category_row_main_page.dart';
import 'package:iman_invest/feature/shop/presentation/home_page/widgets/search_bar_main_page.dart';
import 'package:iman_invest/feature/shop/presentation/home_page/widgets/top_row_home_page.dart';

/// HomePage class
class HomePage extends StatelessWidget {
  /// HomePage constructor
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CategoriesBloc>(
          create: (BuildContext context) {
            return CategoriesBloc(getCategoriesUseCase: GetCategoriesUseCase());
          },
        ),
        BlocProvider(
          create: (BuildContext context) {
            return HomePageBloc(
              getBannerImages: GetBannerImages(),
              getCategoriesUseCase: GetCategoriesUseCase(),
            );
          },
        ),
        BlocProvider(
          create: (BuildContext context) {
            return SmallMerchantsBloc(
              getPartnersUseCase: GetPartnersUseCase(),
            );
          },
        ),
        BlocProvider(
          create: (BuildContext context) {
            return MerchantBloc(
              getClosestPartnersUseCase: GetClosestPartnersUseCase(),
            );
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Builder(builder: (context) {
            return RefreshIndicator(
              backgroundColor: const Color(0xfff4f4f5),
              color: Colors.black87,
              onRefresh: () async {
                context.read<HomePageBloc>().add(FetchBannerImages());
                context.read<CategoriesBloc>().add(FetchCategories());
                context.read<MerchantBloc>().add(GetPartners());
                context.read<SmallMerchantsBloc>().add(GetPartnersSmall());
              },
              child: const SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //magazine and location icon
                      TopRowHomePage(),
                      SearchBarHomePage(),
                      SizedBox(
                        height: 10,
                      ),
                      AdBannerRow(),
                      SizedBox(
                        height: 10,
                      ),
                      CategoryRow(),
                      Header(
                        title: 'Поблизости',
                        size: 24,
                      ),
                      PartnersRow(),
                      Header(
                        title: 'Вам может понравится',
                        size: 24,
                      ),
                      SmallPartnersRow(),
                    ],
                  ),
              ),
            );
          },
          ),
        ),
      ),
    );
  }
}
