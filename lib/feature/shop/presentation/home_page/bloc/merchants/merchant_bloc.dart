import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iman_invest/feature/shop/domain/usecases/get_sorted_partners_usecase.dart';
import 'package:iman_invest/feature/shop/presentation/home_page/bloc/merchants/merchant_state.dart';
import 'package:iman_invest/feature/shop/presentation/home_page/bloc/merchants/merchant_event.dart';

import '../../../../domain/usecases/get_partners_usecase.dart';
import '../../../../services/app_location.dart';

class MerchantBloc extends Bloc<MerchantEvent, MerchantState> {
  final GetClosestPartnersUseCase getClosestPartnersUseCase;

  MerchantBloc( {required this.getClosestPartnersUseCase}) : super(InitialMerchants()){

    on<GetPartners>((event, emit) async {
      AppLocation appLocation = LocationService();
      emit(LoadingClosestMerchants());
      try {
        final userLocation = await appLocation.getCurrentLocation();

        final result = await getClosestPartnersUseCase.call(userLocation);
        result.fold((l) => emit(ErrorMerchants(l.toString())), (r) => emit(LoadedClosestMerchants(r)));

      } catch (e) {
        emit(ErrorMerchants(e.toString()));
      }
    });


}}
class SmallMerchantsBloc extends Bloc<MerchantEvent, SmallMerchantState> {
  final GetPartnersUseCase getPartnersUseCase;
  SmallMerchantsBloc({ required this.getPartnersUseCase} ): super(InitialSmallMerchants()) {
    on<GetPartnersSmall>((event, emit) async {

      emit(LoadingSmallMerchants());
      try {
        final userLocation = await LocationService().getCurrentLocation();

        final result = await getPartnersUseCase.call(userLocation);
        result.fold((l) => emit(ErrorSmallMerchants(l.toString())), (r) => emit(LoadedSmallMerchants(r)));
      } catch (e) {
        emit(ErrorSmallMerchants(e.toString()));
      }
    });
  }}