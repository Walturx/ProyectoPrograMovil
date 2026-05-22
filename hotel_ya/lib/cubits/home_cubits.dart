import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_ya/cubits/home_state.dart';
import 'package:hotel_ya/models/hotel_model.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  List<HotelModel> _allNearby = [];

  Future<void> loadHome() async {
    emit(HomeLoading());
    try {
      await Future.delayed(const Duration(milliseconds: 800));
      _allNearby = HotelModel.mockList();
      emit(HomeLoaded(
        nearbyHotels: _allNearby,
        trendingHotels: HotelModel.mockTrendingList(),
      ));
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
