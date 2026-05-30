import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_ya/cubits/login_cubit.dart';
import 'package:hotel_ya/pages/history/history_page.dart';
import 'package:hotel_ya/pages/home/home_page.dart';
import 'package:hotel_ya/pages/hotel/hotel_page.dart';
import 'package:hotel_ya/pages/login/login_page.dart';
import 'package:hotel_ya/pages/profile/profile_page.dart';
import 'package:hotel_ya/pages/qr_reward/qr_reward_page.dart';
import 'package:hotel_ya/pages/recovery/forgot_password.dart';
import 'package:hotel_ya/pages/reservation/reservation_page.dart';
import 'package:hotel_ya/pages/rewards_shop/rewards_shop_page.dart';
import 'package:hotel_ya/pages/rooms/rooms_page.dart';
import 'package:hotel_ya/models/room_model.dart';
import 'package:hotel_ya/models/hotel_model.dart';
import 'package:hotel_ya/pages/search/search_page.dart';
import 'package:hotel_ya/pages/splash_screen/splash_screen_page.dart';

import '../pages/reservation_details/reservation_details_page.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreenPage()),
    GoRoute(
      path: '/login',
      builder: (context, state) =>
          BlocProvider(create: (_) => AuthCubit(), child: LoginPage()),
    ),
    GoRoute(
      path: '/forgot_password',
      builder: (context, state) => ForgotPassword(),
    ),

    GoRoute(path: '/home', builder: (context, state) => const HomePage()),

    GoRoute(path: '/search', builder: (context, state) => const SearchPage()),

    GoRoute(
      path: '/hotel',
      builder: (context, state) {
        final hotel = state.extra as Map<String, dynamic>;
        return HotelPage(hotel: hotel);
      },
    ),

    GoRoute(
      path: '/rooms',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return RoomPage(
          room: RoomModel.fromJson(extra['room'] as Map<String, dynamic>),
          hotel: HotelModel.fromJson(extra['hotel'] as Map<String, dynamic>),
        );
      },
    ),

    GoRoute(
      path: '/reservation',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;

        if (extra == null) {
          return const Scaffold(body: Center(child: Text('Extra viene null')));
        }

        return ReservationPage(
          hotel: extra['hotel'],

          room: extra['room'],

          roomType: extra['roomType'],
        );
      },
    ),

    GoRoute(
      path: '/reservation/details',

      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;

        return ReservationDetailsPage(
          hotelName: extra['hotelName'],

          roomNumber: extra['roomNumber'],

          guests: extra['guests'],

          checkIn: extra['checkIn'],

          checkInHour: extra['checkInHour'],

          checkOut: extra['checkOut'],

          checkOutHour: extra['checkOutHour'],

          pricePerNight: extra['pricePerNight'],
        );
      },
    ),

    GoRoute(path: '/qr', builder: (context, state) => QRRewardPage()),

    GoRoute(path: '/profile', builder: (context, state) => ProfilePage()),

    GoRoute(path: '/history', builder: (context, state) => HistoryPage()),

    GoRoute(path: '/rewards', builder: (context, state) => RewardsShopPage()),
  ],
);
