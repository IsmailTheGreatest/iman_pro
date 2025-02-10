import 'package:equatable/equatable.dart';

import 'package:iman_invest/feature/shop/data/models/merchant.dart';
///
abstract class MerchantState extends Equatable {
  ///
  const MerchantState();
  @override
  List<Object?> get props => [];
}
///
abstract class SmallMerchantState extends Equatable {
  ///
  const SmallMerchantState();
  @override
  List<Object?> get props => [];
}

///
class InitialMerchants extends MerchantState {}
///
class InitialSmallMerchants extends SmallMerchantState {}
///
class LoadingClosestMerchants extends MerchantState {}
///
class LoadingSmallMerchants extends SmallMerchantState {}
///
class LoadedClosestMerchants extends MerchantState {
  ///
  const LoadedClosestMerchants(this.merchantsList);
  ///
  final List<Merchant> merchantsList;
  @override
  List<Object?> get props => [merchantsList];
}
///
class LoadedSmallMerchants extends SmallMerchantState {
  ///
  const LoadedSmallMerchants(this.merchantsList);
  ///
  final List<Merchant> merchantsList;
  @override
  List<Object?> get props => [merchantsList];
}
///
class ErrorMerchants extends MerchantState {
  ///
  const ErrorMerchants(this.message);
  ///
  final String message;
  @override
  List<Object?> get props => [message];
}
///
class ErrorSmallMerchants extends SmallMerchantState {
  ///
 const  ErrorSmallMerchants(this.message);
 ///
  final String message;
  @override
  List<Object?> get props => [message];
}
