import 'package:as_lib/app/data/buku_response.dart';
import 'package:as_lib/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:as_lib/app/modules/dashboard/views/book_detail_view.dart';
import 'package:as_lib/app/modules/dashboard/views/cart_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class IndexView extends GetView {
  const IndexView({super.key});

  @override
  Widget build(BuildContext context) {
    DashboardController controller = Get.put(DashboardController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Buku'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart), // Icon Cart
            onPressed: () {
              Get.to(() => CartView()); // Pindah ke halaman Cart saat ditekan
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<BukuResponse>(
          future: controller.getBuku(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Lottie.network(
                  'https://gist.githubusercontent.com/olipiskandar/4f08ac098c81c32ebc02c55f5b11127b/raw/6e21dc500323da795e8b61b5558748b5c7885157/loading.json',
                  repeat: true,
                  width: MediaQuery.of(context).size.width / 1,
                ),
              );
            }
            if (snapshot.data!.bukus!.isEmpty) {
              return const Center(child: Text("Tidak ada data"));
            }
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Dua kolom dalam satu baris
                childAspectRatio:
                    0.6, // Rasio aspek untuk menyesuaikan tinggi dan lebar
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: snapshot.data!.bukus!.length,
              itemBuilder: (context, index) {
                final buku = snapshot.data!.bukus![index];
                return ZoomTapAnimation(
                  onTap: () {
                    Get.to(() => BookDetailView(buku: buku));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                              child: Image.network(
                                'https://picsum.photos/id/${buku.id}/200/300',
                                fit: BoxFit.cover,
                                height: 250,
                                width: double.infinity,
                                errorBuilder: (context, error, stackTrace) {
                                  return const SizedBox(
                                    height: 150,
                                    child: Center(
                                      child: Text('Image not found'),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.favorite_border,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    // Tambahkan aksi like di sini
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                buku.judul!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'ISBN Buku: ${buku.isbn ?? "Tidak diketahui"}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${buku.jumlahBuku} Buku tersedia',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

