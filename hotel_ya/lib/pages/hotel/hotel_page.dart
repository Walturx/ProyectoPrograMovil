//hotel_ya/lib/pages/hotel/hotel_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'hotel_controller.dart';

class HotelPage extends StatelessWidget {
  final Map<String, dynamic> hotel;

  const HotelPage({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    final HotelPageController controller = Get.put(HotelPageController());
    controller.hotel.value = hotel;
    controller.loadHotelData(hotel['id'].toString());

    return Scaffold(
      appBar: AppBar(
        title: Text(hotel['name']),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context..go('/home'),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return CustomScrollView(
          slivers: [
            /// HEADER CON IMAGEN
            SliverAppBar(
              expandedHeight: 280,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      hotel['cover_image_url'],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey.shade300,
                          child: const Icon(
                            Icons.hotel,
                            size: 80,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black54],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// CONTENIDO
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// ESTRELLAS + RATING
                    Row(
                      children: [
                        /// ESTRELLAS DEL HOTEL
                        Row(
                          children: List.generate(
                            hotel['stars'],
                            (i) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 22,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),

                        /// RATING PROMEDIO
                        if (controller.reviews.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF3CD),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Color(0xFFD4AF37),
                                  size: 18,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  controller.averageRating.toStringAsFixed(1),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFD4AF37),
                                  ),
                                ),
                                Text(
                                  " (${controller.reviews.length})",
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        const Spacer(),

                        /// ESTADO
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: hotel['is_active']
                                ? Colors.green.shade50
                                : Colors.red.shade50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            hotel['is_active'] ? "Activo" : "Inactivo",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: hotel['is_active']
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    /// DESCRIPCION
                    Text(
                      hotel['description'],
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade700,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// ================================
                    /// FOTOS DEL HOTEL (habitaciones)
                    /// ================================
                    const Text(
                      "Fotos del Hotel",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 16),

                    SizedBox(
                      height: 160,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.rooms.length,
                        itemBuilder: (context, index) {
                          final room = controller.rooms[index];
                          return Container(
                            width: 220,
                            margin: const EdgeInsets.only(right: 14),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.network(
                                    room['image_url'],
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.grey.shade200,
                                        child: const Icon(
                                          Icons.image,
                                          size: 40,
                                          color: Colors.grey,
                                        ),
                                      );
                                    },
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.transparent,
                                            Colors.black87,
                                          ],
                                        ),
                                      ),
                                      child: Text(
                                        "${room['type_name']} - Hab. ${room['room_number']}",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// ================================
                    /// HABITACIONES DISPONIBLES
                    /// ================================
                    Row(
                      children: [
                        const Text(
                          "Habitaciones Disponibles",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF3CD),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "${controller.availableRoomsCount}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFD4AF37),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    ListView.builder(
                      itemCount: controller.rooms.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final room = controller.rooms[index];
                        final bool isAvailable = room['is_available'];

                        return GestureDetector(
                          onTap: () {

                            if (!isAvailable) {

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Esta habitación no está disponible'),
                                  backgroundColor: Colors.red,
                                ),
                              );

                              return;
                            }

                            context.push(
                              '/reservation',
                              extra: {
                                'hotel': hotel,
                                'room': room,
                                'roomType': room,
                              },
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(
                                color: isAvailable
                                    ? Colors.transparent
                                    : Colors.red.shade100,
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                /// IMAGEN
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: Image.network(
                                    room['image_url'],
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 80,
                                        height: 80,
                                        color: Colors.grey.shade200,
                                        child: const Icon(
                                          Icons.bed,
                                          color: Colors.grey,
                                        ),
                                      );
                                    },
                                  ),
                                ),

                                const SizedBox(width: 14),

                                /// INFO
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        room['type_name'],
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "Piso ${room['floor']} · Hab. ${room['room_number']}",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.people,
                                            size: 16,
                                            color: Colors.grey.shade500,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            "${room['capacity']} personas",
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey.shade500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                /// PRECIO + ESTADO
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "\$${room['base_price'].toStringAsFixed(0)}",
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFD4AF37),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "/noche",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade500,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isAvailable
                                            ? Colors.green.shade50
                                            : Colors.red.shade50,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        isAvailable ? "Disponible" : "Ocupada",
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color: isAvailable
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 30),

                    /// ================================
                    /// SERVICIOS DEL HOTEL
                    /// ================================
                    const Text(
                      "Servicios del Hotel",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 16),

                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 14,
                            mainAxisSpacing: 14,
                            childAspectRatio: 1.3,
                          ),
                      itemCount: controller.services.length,
                      itemBuilder: (context, index) {
                        final service = controller.services[index];

                        return Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// ICONO
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFF3CD),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Icon(
                                  _getServiceIcon(service['name']),
                                  color: const Color(0xFFD4AF37),
                                  size: 24,
                                ),
                              ),

                              const SizedBox(height: 10),

                              /// NOMBRE
                              Text(
                                service['name'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),

                              const SizedBox(height: 4),

                              /// PRECIO
                              Text(
                                service['price'] == 0
                                    ? "Gratis"
                                    : "\$${service['price'].toStringAsFixed(0)}",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: service['price'] == 0
                                      ? Colors.green
                                      : const Color(0xFFD4AF37),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 30),

                    /// ================================
                    /// INFORMACIÓN DE CONTACTO
                    /// ================================
                    const Text(
                      "Información de Contacto",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 16),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          /// TELÉFONO
                          _buildContactRow(
                            Icons.phone,
                            "Teléfono",
                            hotel['phone'],
                          ),

                          const Divider(height: 28),

                          /// EMAIL
                          _buildContactRow(
                            Icons.email,
                            "Email",
                            hotel['email'],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// ================================
                    /// RESEÑAS
                    /// ================================
                    if (controller.reviews.isNotEmpty) ...[
                      Row(
                        children: [
                          const Text(
                            "Reseñas",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF3CD),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              "${controller.reviews.length}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFD4AF37),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      ListView.builder(
                        itemCount: controller.reviews.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final review = controller.reviews[index];

                          return Container(
                            margin: const EdgeInsets.only(bottom: 14),
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    /// AVATAR
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundColor: const Color(0xFFFFF3CD),
                                      child: Text(
                                        review['user_name'][0],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFD4AF37),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 12),

                                    /// NOMBRE + FECHA
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            review['user_name'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text(
                                            review['created_at'],
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey.shade500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    /// ESTRELLAS
                                    Row(
                                      children: List.generate(
                                        review['rating'],
                                        (i) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 12),

                                Text(
                                  review['comment'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade700,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 10),
                    ],

                    /// ================================
                    /// BOTON CALIFICAR
                    /// ================================
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _showRatingDialog(context);
                        },
                        icon: const Icon(Icons.rate_review),
                        label: const Text(
                          "Calificar Hotel",
                          style: TextStyle(fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  /// HELPER: Icono para servicios
  IconData _getServiceIcon(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('desayuno') ||
        lower.contains('comida') ||
        lower.contains('room service')) {
      return Icons.restaurant;
    } else if (lower.contains('spa') || lower.contains('masaje')) {
      return Icons.spa;
    } else if (lower.contains('traslado') || lower.contains('transporte')) {
      return Icons.airport_shuttle;
    } else if (lower.contains('lavandería') || lower.contains('lavado')) {
      return Icons.local_laundry_service;
    } else if (lower.contains('tour')) {
      return Icons.explore;
    } else if (lower.contains('gimnasio')) {
      return Icons.fitness_center;
    } else if (lower.contains('piscina')) {
      return Icons.pool;
    } else if (lower.contains('acuática') || lower.contains('bote')) {
      return Icons.sailing;
    }
    return Icons.room_service;
  }

  /// HELPER: Fila de contacto
  Widget _buildContactRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF3CD),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, color: const Color(0xFFD4AF37), size: 24),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }

  /// DIALOG: Calificar hotel
  void _showRatingDialog(BuildContext context) {
    int selectedRating = 0;
    final commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, dialogSetState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              title: const Text(
                "Calificar Hotel",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// ESTRELLAS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return GestureDetector(
                        onTap: () {
                          dialogSetState(() {
                            selectedRating = index + 1;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Icon(
                            index < selectedRating
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber,
                            size: 40,
                          ),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 20),

                  /// COMENTARIO
                  TextField(
                    controller: commentController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "Escribe tu comentario...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancelar"),
                ),
                ElevatedButton(
                  onPressed: selectedRating > 0
                      ? () {
                          Navigator.pop(context);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "¡Gracias! Calificaste con $selectedRating estrellas.",
                              ),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          );
                        }
                      : null,
                  child: const Text("Enviar"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
