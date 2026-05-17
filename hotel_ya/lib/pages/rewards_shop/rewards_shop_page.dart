// lib/pages/rewards_shop_page.dart

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widgets/custom_bottom_nav.dart';
import '../qr_reward/qr_reward_page.dart';

class RewardsShopPage extends StatefulWidget {
  const RewardsShopPage({super.key});

  @override
  State<RewardsShopPage> createState() =>
      _RewardsShopPageState();
}

class _RewardsShopPageState
    extends State<RewardsShopPage> {

  Map<String, dynamic>? user;

  List<dynamic> rewards = [];

  bool isLoading = true;

  /// SOLO UN REWARD
  int? selectedIndex;

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future<void> loadData() async {

    /// USER
    final String userResponse =
        await rootBundle.loadString(
      'assets/json/users.json',
    );

    final userData =
        json.decode(userResponse);

    /// REWARDS
    final String rewardsResponse =
        await rootBundle.loadString(
      'assets/json/rewards.json',
    );

    final rewardsData =
        json.decode(rewardsResponse);

    setState(() {

      user = userData[0];

      rewards = rewardsData;

      isLoading = false;
    });
  }

  IconData getRewardIcon(String type) {

    switch (type) {

      case "food":
        return Icons.icecream;

      case "drink":
        return Icons.local_drink;

      case "hotel":
        return Icons.hotel;

      default:
        return Icons.card_giftcard;
    }
  }

  @override
  Widget build(BuildContext context) {

    if (isLoading) {

      return const Scaffold(
        body: Center(
          child:
              CircularProgressIndicator(),
        ),
      );
    }

    final int userStars =
        user!["stars"];

    int remainingStars =
        userStars;

    int selectedCost = 0;

    if (selectedIndex != null) {

      selectedCost =
          rewards[selectedIndex!]
              ["stars_cost"];

      remainingStars =
          userStars -
          selectedCost;
    }

    return Scaffold(

      bottomNavigationBar:
          const CustomBottomNav(
        currentIndex: 2,
      ),

      body: SafeArea(

        child: Padding(

          padding:
              const EdgeInsets.all(20),

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              const SizedBox(height: 10),

              /// TITULO
              const Text(

                "Tienda de Estrellas",

                style: TextStyle(
                  fontSize: 32,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 28),

              /// CARD ESTRELLAS
              Container(

                width: double.infinity,

                padding:
                    const EdgeInsets.all(
                        24),

                decoration: BoxDecoration(

                  gradient:
                      const LinearGradient(
                    colors: [
                      Color(0xFFFFE082),
                      Color(0xFFFFF3CD),
                    ],
                  ),

                  borderRadius:
                      BorderRadius.circular(
                          28),
                ),

                child: Row(

                  mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,

                  children: [

                    /// DISPONIBLES
                    Column(

                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                      children: [

                        Text(

                          "Disponibles",

                          style: TextStyle(
                            color: Colors
                                .grey.shade700,

                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(
                            height: 12),

                        Row(
                          children: [

                            Text(

                              "$userStars",

                              style:
                                  const TextStyle(
                                fontSize: 42,

                                fontWeight:
                                    FontWeight
                                        .bold,
                              ),
                            ),

                            const SizedBox(
                                width: 8),

                            const Icon(
                              Icons.star,

                              color:
                                  Colors.amber,

                              size: 34,
                            ),
                          ],
                        ),
                      ],
                    ),

                    /// RESTANTES
                    Column(

                      crossAxisAlignment:
                          CrossAxisAlignment
                              .end,

                      children: [

                        Text(

                          "Restantes",

                          style: TextStyle(
                            color: Colors
                                .grey.shade700,

                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(
                            height: 12),

                        Row(
                          children: [

                            Text(

                              "$remainingStars",

                              style:
                                  const TextStyle(
                                fontSize: 42,

                                fontWeight:
                                    FontWeight
                                        .bold,
                              ),
                            ),

                            const SizedBox(
                                width: 8),

                            const Icon(
                              Icons.star,

                              color:
                                  Colors.amber,

                              size: 34,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              /// SUBTITLE
              const Text(

                "Premios disponibles",

                style: TextStyle(
                  fontSize: 22,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              /// LISTA
              Expanded(

                child: ListView.builder(

                  itemCount:
                      rewards.length,

                  itemBuilder:
                      (context, index) {

                    final reward =
                        rewards[index];

                    final bool isSelected =
                        selectedIndex ==
                            index;

                    final bool canAfford =
                        userStars >=
                            reward[
                                "stars_cost"];

                    return GestureDetector(

                      onTap: canAfford
                          ? () {

                              setState(() {

                              if (selectedIndex == index) {

                                /// DESELECCIONAR
                                selectedIndex = null;

                              } else {

                                /// SELECCIONAR
                                selectedIndex = index;
                              }
                            });
                            }
                          : null,

                      child: Container(

                        margin:
                            const EdgeInsets.only(
                                bottom: 20),

                        padding:
                            const EdgeInsets
                                .all(20),

                        decoration:
                            BoxDecoration(

                          color:
                              Colors.white,

                          borderRadius:
                              BorderRadius
                                  .circular(
                                      26),

                          border: Border.all(

                            color: isSelected
                                ? const Color(
                                    0xFFD4AF37)
                                : Colors
                                    .transparent,

                            width: 2.5,
                          ),

                          boxShadow: [
                            BoxShadow(
                              color: Colors
                                  .black
                                  .withOpacity(
                                      0.05),

                              blurRadius: 10,

                              offset:
                                  const Offset(
                                      0, 4),
                            ),
                          ],
                        ),

                        child: Row(
                          children: [

                            /// ICONO
                            Container(

                              padding:
                                  const EdgeInsets
                                      .all(16),

                              decoration:
                                  BoxDecoration(

                                color:
                                    const Color(
                                        0xFFFFF3CD),

                                borderRadius:
                                    BorderRadius
                                        .circular(
                                            18),
                              ),

                              child: Icon(

                                getRewardIcon(
                                  reward["type"],
                                ),

                                size: 34,

                                color:
                                    const Color(
                                        0xFFD4AF37),
                              ),
                            ),

                            const SizedBox(
                                width: 18),

                            /// INFO
                            Expanded(
                              child: Column(

                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,

                                children: [

                                  Text(

                                    reward[
                                        "name"],

                                    style:
                                        const TextStyle(
                                      fontSize:
                                          24,

                                      fontWeight:
                                          FontWeight
                                              .bold,
                                    ),
                                  ),

                                  const SizedBox(
                                      height:
                                          8),

                                  Text(

                                    reward[
                                        "description"],

                                    style:
                                        TextStyle(
                                      fontSize:
                                          16,

                                      color: Colors
                                          .grey
                                          .shade600,
                                    ),
                                  ),

                                  const SizedBox(
                                      height:
                                          14),

                                  Row(
                                    children: [

                                      const Icon(
                                        Icons.star,

                                        color:
                                            Colors
                                                .amber,

                                        size:
                                            22,
                                      ),

                                      const SizedBox(
                                          width:
                                              6),

                                      Text(

                                        "${reward["stars_cost"]} estrellas",

                                        style:
                                            const TextStyle(
                                          fontSize:
                                              16,

                                          fontWeight:
                                              FontWeight
                                                  .bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            /// CHECK
                            if (isSelected)

                              const Icon(
                                Icons.check_circle,

                                color: Color(
                                    0xFFD4AF37),

                                size: 34,
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              /// FOOTER
              Container(

                padding:
                    const EdgeInsets.all(
                        20),

                decoration: BoxDecoration(

                  color: Colors.white,

                  borderRadius:
                      BorderRadius.circular(
                          24),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          .withOpacity(0.05),

                      blurRadius: 10,
                    ),
                  ],
                ),

                child: Row(

                  mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,

                  children: [

                    /// TOTAL
                    Column(

                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                      children: [

                        Text(

                          "Total Gastado",

                          style: TextStyle(
                            color: Colors
                                .grey.shade600,
                          ),
                        ),

                        const SizedBox(
                            height: 8),

                        Row(
                          children: [

                            Text(

                              "$selectedCost",

                              style:
                                  const TextStyle(
                                fontSize: 34,

                                fontWeight:
                                    FontWeight
                                        .bold,
                              ),
                            ),

                            const SizedBox(
                                width: 8),

                            const Icon(
                              Icons.star,

                              color:
                                  Colors.amber,

                              size: 30,
                            ),
                          ],
                        ),
                      ],
                    ),

                    /// BUTTON
                    ElevatedButton.icon(

                      onPressed:
                          selectedIndex ==
                                  null
                              ? null
                              : () {

                                  Navigator.push(

                                    context,

                                    MaterialPageRoute(

                                      builder:
                                          (context) {

                                        return const QRRewardPage();
                                      },
                                    ),
                                  );
                                },

                      icon: const Icon(
                        Icons.qr_code,
                      ),

                      label: const Text(
                        "Continuar",
                      ),

                      style:
                          ElevatedButton.styleFrom(

                        padding:
                            const EdgeInsets
                                .symmetric(
                          horizontal: 26,
                          vertical: 18,
                        ),

                        shape:
                            RoundedRectangleBorder(

                          borderRadius:
                              BorderRadius
                                  .circular(
                                      18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}