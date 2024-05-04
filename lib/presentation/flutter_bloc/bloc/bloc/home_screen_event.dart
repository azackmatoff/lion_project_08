part of 'home_screen_bloc.dart';

sealed class HomeScreenEvent {}

class GetCrypto extends HomeScreenEvent {
  final String currency;

  GetCrypto({required this.currency});
}
