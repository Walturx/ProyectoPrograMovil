import 'package:flutter/material.dart';

import '../pages/history_page.dart';
import '../pages/profile_page.dart';
import '../pages/rewards_shop_page.dart';
import '../pages/qr_reward_page.dart';

class CustomBottomNav extends StatelessWidget {

  final int currentIndex;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
  });

  void _onItemTapped(
    BuildContext context,
    int index,
  ) {

    Widget page;

    switch (index) {

      case 0:
        page = const HistoryPage();
        break;

      case 1:
        page = const ProfilePage();
        break;

      case 2:
        page = const RewardsShopPage();
        break;

      case 3:
        page = const QRRewardPage();
        break;

      default:
        page = const ProfilePage();
    }

    Navigator.pushReplacement(

      context,

      MaterialPageRoute(
        builder: (_) => page,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return NavigationBar(

      selectedIndex: currentIndex,

      onDestinationSelected: (index) {
        _onItemTapped(context, index);
      },

      backgroundColor: Colors.white,

      indicatorColor:
          const Color(0xFFFFE082),

      destinations: const [

        NavigationDestination(
          icon: Icon(Icons.history),
          selectedIcon: Icon(Icons.history),
          label: 'Historial',
        ),

        NavigationDestination(
          icon: Icon(Icons.person_outline),
          selectedIcon: Icon(Icons.person),
          label: 'Perfil',
        ),

        NavigationDestination(
          icon:
              Icon(Icons.card_giftcard_outlined),

          selectedIcon:
              Icon(Icons.card_giftcard),

          label: 'Tienda',
        ),

        NavigationDestination(
          icon: Icon(Icons.qr_code_outlined),
          selectedIcon: Icon(Icons.qr_code),
          label: 'QR',
        ),
      ],
    );
  }
}