import 'package:as_lib/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class KoleksiView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DashboardController controller = Get.put(DashboardController());

    // Panggil API untuk mengambil koleksi sesuai user login
    controller.getKoleksiBuku();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Koleksi Buku'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoadingKoleksi.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.koleksiBuku.isEmpty) {
          return const Center(child: Text("Tidak ada buku dalam koleksi"));
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Dua kolom dalam satu baris
            childAspectRatio: 0.6, // Rasio aspek untuk menyesuaikan tinggi dan lebar
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: controller.koleksiBuku.length,
          itemBuilder: (context, index) {
            final koleksi = controller.koleksiBuku[index];
            return ZoomTapAnimation(
              onTap: () {},
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
                            'https://picsum.photos/id/${koleksi.id}/200/300',
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
                                Icons.favorite,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                controller.removeFromKoleksi(koleksi.id!);
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
                            koleksi.buku?.judul ?? "Judul tidak tersedia",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'ISBN Buku: ${koleksi.buku?.isbn ?? "Tidak diketahui"}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${koleksi.buku?.jumlahBuku ?? 0} Buku tersedia',
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
      }),
    );
  }
}