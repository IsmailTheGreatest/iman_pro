import 'package:equatable/equatable.dart';

import '../../../../data/models/merchant.dart';

abstract class MerchantState extends Equatable {
  const MerchantState();
  @override
  List<Object?> get props => [];
}
abstract class SmallMerchantState extends Equatable {
  const SmallMerchantState();
  @override
  List<Object?> get props => [];
}

class InitialMerchants extends MerchantState {}
class InitialSmallMerchants extends SmallMerchantState {}
class LoadingClosestMerchants extends MerchantState {}
class LoadingSmallMerchants extends SmallMerchantState {}
class LoadedClosestMerchants extends MerchantState {
  final List<Merchant> merchantsList;
  const LoadedClosestMerchants(this.merchantsList);
  @override
  List<Object?> get props => [merchantsList];
}
class LoadedSmallMerchants extends SmallMerchantState {
  final List<Merchant> merchantsList;
  const LoadedSmallMerchants(this.merchantsList);
  @override
  List<Object?> get props => [merchantsList];
}
class ErrorMerchants extends MerchantState {
  final String message;
  const ErrorMerchants(this.message);
  @override
  List<Object?> get props => [message];
}
class ErrorSmallMerchants extends SmallMerchantState {
  final String message;
 const  ErrorSmallMerchants(this.message);
  @override
  List<Object?> get props => [message];
}
