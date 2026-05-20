import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_ya/router/app_router.dart';
import 'package:hotel_ya/theme/app_theme.dart';
import 'package:hotel_ya/pages/rewards_shop/rewards_shop_controller.dart';
import 'package:hotel_ya/cubits/auth_cubit.dart';

void main() {
  Get.put(RewardsShopController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp.router(
        title: 'HotelYa',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
      ),
    );
  }
}
