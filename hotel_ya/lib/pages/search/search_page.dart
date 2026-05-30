//hotel_ya/lib/pages/search/search_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'search_controller.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SearchPageController controller = Get.put(SearchPageController());

    return Scaffold(
      appBar: AppBar(title: const Text("Buscar hoteles")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// BUSCADOR
            TextField(
              onChanged: controller.updateSearch,
              decoration: InputDecoration(
                hintText: "Buscar hotel...",
                prefixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).primaryColor,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),

            const SizedBox(height: 20),

            /// LISTA DE HOTELES
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.filteredHotels.isEmpty) {
                  return const Center(
                    child: Text(
                      "No se encontraron hoteles",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: controller.filteredHotels.length,
                  itemBuilder: (context, index) {
                    final hotel = controller.filteredHotels[index];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
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
                              hotel.coverImageUrl,
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 90,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: const Icon(
                                    Icons.hotel,
                                    size: 40,
                                    color: Colors.grey,
                                  ),
                                );
                              },
                            ),
                          ),

                          const SizedBox(width: 16),

                          /// INFO
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// NOMBRE
                                Text(
                                  hotel.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 6),

                                /// DESCRIPCION
                                Text(
                                  hotel.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade600,
                                  ),
                                ),

                                const SizedBox(height: 8),

                                /// ESTRELLAS + ESTADO
                                Row(
                                  children: [
                                    /// ESTRELLAS
                                    Row(
                                      children: List.generate(
                                        hotel.stars,
                                        (i) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 18,
                                        ),
                                      ),
                                    ),

                                    const Spacer(),

                                    /// ESTADO
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: hotel.isActive
                                            ? Colors.green.shade50
                                            : Colors.red.shade50,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        hotel.isActive ? "Activo" : "Inactivo",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: hotel.isActive
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
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
