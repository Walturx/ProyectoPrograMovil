import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_ya/cubits/auth_cubit.dart';
import 'package:hotel_ya/pages/splash_screen/splash_screen_page.dart';
import 'package:hotel_ya/pages/login/login_page.dart';
import 'package:hotel_ya/pages/profile/profile_page.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreenPage()),
    GoRoute(
      path: '/login',
      builder: (context, state) =>
          BlocProvider(create: (context) => AuthCubit(), child: LoginPage()),
    ),
    GoRoute(path: '/home', builder: (context, state) => ProfilePage()),
  ],
);
