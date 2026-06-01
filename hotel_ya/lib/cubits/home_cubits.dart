import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_ya/cubits/home_state.dart';
import 'package:hotel_ya/models/hotel_model.dart';
import 'package:hotel_ya/services/hotel_service.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final HotelService _hotelService = HotelService();

  List<HotelModel> _allNearby = [];

  Future<void> loadHome() async {
    emit(HomeLoading());
    try {
      final hotels = await _hotelService.getHotels();
      _allNearby = hotels;
      emit(
        HomeLoaded(
          nearbyHotels: hotels,
          trendingHotels: hotels.take(3).toList(),
        ),
      );
    } catch (e) {
      emit(HomeError(error: e.toString()));
    }
  }

  void search(String query) {
    if (state is! HomeLoaded) return;
    final current = state as HomeLoaded;
    final filtered = query.trim().isEmpty
        ? _allNearby
        : _allNearby
              .where((h) => h.name.toLowerCase().contains(query.toLowerCase()))
              .toList();
    emit(current.copyWith(nearbyHotels: filtered));
  }
}
