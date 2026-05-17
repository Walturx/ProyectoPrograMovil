// lib/pages/qr_reward_page.dart

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widgets/custom_bottom_nav.dart';

class QRRewardPage extends StatefulWidget {
  const QRRewardPage({super.key});

  @override
  State<QRRewardPage> createState() =>
      _QRRewardPageState();
}

class _QRRewardPageState
    extends State<QRRewardPage> {

  Map<String, dynamic>? user;

  Map<String, dynamic>? redemption;

  Map<String, dynamic>? reward;

  bool isLoading = true;

  String qrData = "";

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

    /// REDEMPTIONS
    final String redemptionResponse =
        await rootBundle.loadString(
      'assets/json/reward_redemptions.json',
    );

    final redemptionData =
        json.decode(redemptionResponse);

    /// REWARDS
    final String rewardsResponse =
        await rootBundle.loadString(
      'assets/json/rewards.json',
    );

    final rewardsData =
        json.decode(rewardsResponse);

    final currentUser =
        userData[0];

    final currentRedemption =
        redemptionData[0];

    final currentReward =
        rewardsData.firstWhere(
      (item) =>
          item["id"] ==
          currentRedemption[
              "reward_id"],
    );

    /// DATA QR
    final generatedQRData =
        jsonEncode({

      "redemption_id":
          currentRedemption["id"],

      "user_id":
          currentUser["id"],

      "reward":
          currentReward["name"],

      "stars_spent":
          currentRedemption[
              "stars_spent"],

      "status":
          currentRedemption[
              "status"],
    });

    setState(() {

      user = currentUser;

      redemption =
          currentRedemption;

      reward = currentReward;

      qrData = generatedQRData;

      isLoading = false;
    });
  }

  IconData getRewardIcon(
      String type) {

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

    final int starsSpent =
        redemption!["stars_spent"];

    final int userStars =
        user!["stars"];

    final int remainingStars =
        userStars - starsSpent;

    final String rewardType =
        reward!["type"];

    return Scaffold(

      bottomNavigationBar:
          const CustomBottomNav(
        currentIndex: 2,
      ),

      body: SafeArea(

        child: SingleChildScrollView(

          child: Padding(

            padding:
                const EdgeInsets.all(20),

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment.center,

              children: [

                const SizedBox(
                    height: 20),

                /// ICONO TOP
                Container(

                  padding:
                      const EdgeInsets.all(
                          18),

                  decoration: BoxDecoration(

                    color:
                        const Color(
                            0xFFFFF3CD),

                    borderRadius:
                        BorderRadius.circular(
                            24),
                  ),

                  child: Icon(

                    getRewardIcon(
                        rewardType),

                    size: 50,

                    color:
                        const Color(
                            0xFFD4AF37),
                  ),
                ),

                const SizedBox(
                    height: 24),

                /// TITULO
                const Text(

                  "Canje Realizado",

                  textAlign:
                      TextAlign.center,

                  style: TextStyle(
                    fontSize: 30,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                    height: 10),

                Text(

                  "Presenta este código QR\npara reclamar tu premio",

                  textAlign:
                      TextAlign.center,

                  style: TextStyle(
                    fontSize: 16,
                    color:
                        Colors.grey.shade600,
                  ),
                ),

                const SizedBox(
                    height: 30),

                /// PRODUCTO
                Container(

                  padding:
                      const EdgeInsets.all(
                          18),

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
                    children: [

                      /// ICONO
                      Container(

                        padding:
                            const EdgeInsets
                                .all(14),

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
                              rewardType),

                          size: 34,

                          color:
                              const Color(
                                  0xFFD4AF37),
                        ),
                      ),

                      const SizedBox(
                          width: 18),

                      /// TEXTOS
                      Expanded(
                        child: Column(

                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                          children: [

                            const Text(

                              "Premio Canjeado",

                              style:
                                  TextStyle(
                                color:
                                    Colors.grey,
                              ),
                            ),

                            const SizedBox(
                                height: 6),

                            Text(

                              reward!["name"],

                              style:
                                  const TextStyle(
                                fontSize: 20,

                                fontWeight:
                                    FontWeight
                                        .bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                    height: 30),

                /// QR CARD
                Container(

                  width: double.infinity,

                  padding:
                      const EdgeInsets.all(
                          24),

                  decoration: BoxDecoration(

                    color: Colors.white,

                    borderRadius:
                        BorderRadius.circular(
                            30),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black
                            .withOpacity(0.05),

                        blurRadius: 10,
                      ),
                    ],
                  ),

                  child: Column(
                    children: [

                      /// QR
                      Container(

                        padding:
                            const EdgeInsets
                                .all(20),

                        decoration:
                            BoxDecoration(

                          color:
                              const Color(
                                  0xFFF8F6F1),

                          borderRadius:
                              BorderRadius
                                  .circular(
                                      24),
                        ),

                        child: Image.network(

                          "https://api.qrserver.com/v1/create-qr-code/?size=250x250&data=$qrData",

                          width: 220,
                          height: 220,
                        ),
                      ),

                      const SizedBox(
                          height: 30),

                      /// STARS
                      Container(

                        padding:
                            const EdgeInsets
                                .symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),

                        decoration:
                            BoxDecoration(

                          color:
                              const Color(
                                  0xFFFFF8E1),

                          borderRadius:
                              BorderRadius
                                  .circular(
                                      20),
                        ),

                        child: Row(

                          mainAxisSize:
                              MainAxisSize.min,

                          children: [

                            Text(

                              "$remainingStars",

                              style:
                                  const TextStyle(
                                fontSize: 32,

                                fontWeight:
                                    FontWeight
                                        .bold,
                              ),
                            ),

                            const SizedBox(
                                width: 10),

                            const Icon(
                              Icons.star,

                              color:
                                  Colors.amber,

                              size: 34,
                            ),

                            const SizedBox(
                                width: 10),

                            Text(

                              "restantes",

                              style:
                                  TextStyle(
                                fontSize: 16,

                                color: Colors
                                    .grey
                                    .shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                    height: 24),

                /// BOTON
                SizedBox(

                  width: double.infinity,

                  child:
                      ElevatedButton.icon(

                    onPressed: () {},

                    icon: const Icon(
                      Icons.download,
                    ),

                    label: const Text(

                      "Guardar QR",

                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),

                    style:
                        ElevatedButton.styleFrom(

                      padding:
                          const EdgeInsets
                              .symmetric(
                        vertical: 18,
                      ),

                      shape:
                          RoundedRectangleBorder(

                        borderRadius:
                            BorderRadius
                                .circular(
                                    20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}