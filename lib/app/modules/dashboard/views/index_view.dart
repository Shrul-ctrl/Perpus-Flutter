import 'package:as_lib/app/data/buku_response.dart';
import 'package:as_lib/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:as_lib/app/modules/dashboard/views/book_detail_view.dart';
import 'package:as_lib/app/modules/dashboard/views/cart_view.dart';
import 'package:as_lib/app/utils/api.dart';
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
    final String? idUser = GetStorage().read('token');

    if (idUser == null) {
      return Scaffold(
        body: Center(child: Text("User tidak ditemukan, silakan login ulang.")),
      );
    }

    return FutureBuilder<BukuResponse>(
      future: controller.getBuku(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: Lottie.network(
                'https://lottie.host/132abfce-757b-4136-b131-2ace5cc2304c/X4NlILeIz0.json',
                width: 100,
                height: 100,
                repeat: true,
                delegates: LottieDelegates(
                  values: [
                    ValueDelegate.color(['**'], value: Colors.green),
                  ],
                ),
              ),
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data!.bukus!.isEmpty) {
          return Scaffold(body: Center(child: Text("Tidak ada data")));
        }

        final bukus = snapshot.data!.bukus!;

        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            leading: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Image.network(
                 '${BaseUrl.logoPath}/logo_sekolah.png',
                width: 40,
                height: 40,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.image_not_supported);
                },
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.shopping_cart, color: Colors.black),
                onPressed: () => Get.to(() => CartView()),
              ),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                alignment: Alignment.center,
                color: Colors.green,
                child: const Text(
                  'Daftar Buku',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await controller.getBuku();  // Refresh data buku
                  },
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.50,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: bukus.length,
                    itemBuilder: (context, index) {
                      final buku = bukus[index];
                      return ZoomTapAnimation(
                        onTap: () => Get.to(() => BookDetailView(buku: buku)),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                                child: Image.network(
                                  '${BaseUrl.imagePath}/${buku.foto}',
                                  fit: BoxFit.cover,
                                  height: 160,
                                  width: double.infinity,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const SizedBox(
                                      height: 160,
                                      child: Center(
                                        child: Text('Image not found'),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        buku.judul ?? '',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'ISBN Buku: ${buku.isbn ?? "Tidak diketahui"}',
                                        style: const TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${buku.jumlahBuku} Buku tersedia',
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
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
              ),
            ],
          ),
        );
      },
    );
  }
}
