import 'package:hotel_ya/models/hotel_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<HotelModel> nearbyHotels;
  final List<HotelModel> trendingHotels;

  HomeLoaded({required this.nearbyHotels, required this.trendingHotels});

  HomeLoaded copyWith({
    List<HotelModel>? nearbyHotels,
    List<HotelModel>? trendingHotels,
  }) =>
      HomeLoaded(
        nearbyHotels: nearbyHotels ?? this.nearbyHotels,
        trendingHotels: trendingHotels ?? this.trendingHotels,
      );
}

class HomeError extends HomeState {
  final String error;
  HomeError({required this.error});
}
