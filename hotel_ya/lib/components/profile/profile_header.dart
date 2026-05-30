// lib/components/profile/profile_header.dart

import 'package:flutter/material.dart';

/// MODEL
import '../../models/user_model.dart';

class ProfileHeader extends StatelessWidget {
  final UserModel user;
  final VoidCallback onEdit;
  const ProfileHeader({super.key, required this.user, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(24),

      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFF3CD), Color(0xFFFFE082)],
        ),

        borderRadius: BorderRadius.circular(30),
      ),

      child: Column(
        children: [
          /// AVATAR
          Stack(
            children: [
              CircleAvatar(
                radius: 55,

                backgroundColor: Colors.grey.shade200,

                backgroundImage: user.avatarUrl.isNotEmpty
                    ? NetworkImage(user.avatarUrl)
                    : null,

                child: user.avatarUrl.isEmpty
                    ? const Icon(Icons.person, size: 50)
                    : null,
              ),

              Positioned(
                bottom: 0,

                right: 0,

                child: GestureDetector(
                  onTap: onEdit,

                  child: Container(
                    padding: const EdgeInsets.all(8),

                    decoration: BoxDecoration(
                      color: Colors.blue,

                      shape: BoxShape.circle,

                      border: Border.all(color: Colors.white, width: 3),
                    ),

                    child: const Icon(
                      Icons.camera_alt,

                      color: Colors.white,

                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          /// USER NAME
          Text(
            "${user.name} ${user.lastname}",

            textAlign: TextAlign.center,

            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 14),

          /// STARS
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),

            decoration: BoxDecoration(
              color: Colors.white,

              borderRadius: BorderRadius.circular(30),
            ),

            child: const Row(
              mainAxisSize: MainAxisSize.min,

              children: [
                Icon(Icons.star, color: Colors.amber),

                SizedBox(width: 8),

                Text(
                  "HotelYa Rewards",

                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
