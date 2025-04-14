import 'package:as_lib/app/data/buku_response.dart';
import 'package:as_lib/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:as_lib/app/modules/dashboard/views/book_detail_view.dart';
import 'package:as_lib/app/modules/dashboard/views/cart_view.dart';
import 'package:as_lib/app/modules/koleksi/controllers/koleksi_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class IndexView extends GetView {
  const IndexView({super.key});

  @override
  Widget build(BuildContext context) {
    DashboardController controller = Get.put(DashboardController());
    KoleksiController controllerkoleksi = Get.put(KoleksiController());
    final String? idUser = GetStorage().read('token');
    if (idUser == null) {
      return Scaffold(
        body: Center(child: Text("User tidak ditemukan, silakan login ulang.")),
      );
    }
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
                  'https://lottie.host/132abfce-757b-4136-b131-2ace5cc2304c/X4NlILeIz0.json',
                  repeat: true,
                  width: 100, // Ukuran kecil, bisa kamu sesuaikan
                  height: 100,
                  delegates: LottieDelegates(
                    values: [
                      ValueDelegate.color(
                        const ['**'], // Bintang dua untuk semua elemen
                        value: Colors.green,
                      ),
                    ],
                  ),
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
                                'http://127.0.0.1:8000/img/${buku.foto}',
                                // 'http://192.168.1.7:8000/img/${buku.foto}',
                                fit: BoxFit.cover,
                                height: 250,
                                width: double.infinity,
                                errorBuilder: (context, error, stackTrace) {
                                  return const SizedBox(
                                    height: 180,
                                    child: Center(
                                      child: Text('Image not found'),
                                    ),
                                  );
                                },
                              ),
                            ),
                            // Positioned(
                            //   top: 8,
                            //   right: 8,
                            //   child: CircleAvatar(
                            //     backgroundColor: Colors.white,
                            //     child: Obx(() {
                            //       // Gunakan Obx agar UI terupdate otomatis
                            //       bool isFavorite = controllerkoleksi
                            //           .favoriteBookIds
                            //           .contains(buku.id);
                            //       return IconButton(
                            //         icon: Icon(
                            //           isFavorite
                            //               ? Icons.favorite
                            //               : Icons.favorite_border,
                            //           color: Colors.red,
                            //         ),
                            //         onPressed: () {
                            //           if (isFavorite) {
                            //             controllerkoleksi.removeFromKoleksi(
                            //               buku.id!,
                            //             );
                            //           } else {
                            //             controllerkoleksi.addKoleksi(
                            //               idUser,
                            //               buku.id.toString(),
                            //             );
                            //           }
                            //         },
                            //       );
                            //     }),
                            //   ),
                            // ),
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
