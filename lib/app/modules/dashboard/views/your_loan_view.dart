import 'package:as_lib/app/modules/dashboard/views/cart_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:as_lib/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:as_lib/app/modules/dashboard/views/daf_kembali_view.dart';
import 'package:as_lib/app/modules/dashboard/views/daf_pinjam_view.dart';

class YourLoanView extends StatelessWidget {
  const YourLoanView({super.key});

  @override
  Widget build(BuildContext context) {
    DashboardController controller = Get.find<DashboardController>();

    // Memanggil ulang peminjaman saat halaman ini dibuka
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.isLoading.value = true;
      controller.getPeminjaman().whenComplete(() {
        controller.isLoading.value = false;
      });
    });

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Image.network(
            'http://127.0.0.1:8000/default/logo_sekolah.png',
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
            onPressed: () {
              Get.to(() => CartView());
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: Lottie.network(
              'https://lottie.host/132abfce-757b-4136-b131-2ace5cc2304c/X4NlILeIz0.json',
              repeat: true,
              width: 100,
              height: 100,
              delegates: LottieDelegates(
                values: [
                  ValueDelegate.color(const ['**'], value: Colors.green),
                ],
              ),
            ),
          );
        }

        return Column(
          children: [
            // 🔹 Judul di bawah navbar
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              alignment: Alignment.center,
              color: Colors.green,
              child: const Text(
                'Daftar Peminjaman & Pengembalian',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            // 🔹 Konten utama
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // 2 Card (Peminjaman & Pengembalian)
                    Row(
                      children: [
                        _buildCard("Peminjaman", Icons.book, Colors.blue, () {
                          Get.to(() => const DafPinjamView());
                        }),
                        const SizedBox(width: 10),
                        _buildCard("Pengembalian", Icons.history, Colors.green,
                            () {
                          Get.to(() => const DafKembaliView());
                        }),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // List Terbaru
                    Expanded(
                      child: ListView(
                        children: [
                          _buildLatestList(
                            "Peminjaman Terbaru",
                            controller.peminjaman,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildCard(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Icon(icon, size: 40, color: color),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLatestList(String title, List data) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            data.isEmpty
                ? Center(
                    child: Text(
                      "Belum ada $title".toLowerCase(),
                      style: const TextStyle(color: Colors.grey),
                    ),
                  )
                : Column(
                    children: data.take(2).map((item) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          leading: Icon(
                            title.contains("Peminjaman")
                                ? Icons.book
                                : Icons.history,
                            color: title.contains("Peminjaman")
                                ? Colors.blue
                                : Colors.green,
                          ),
                          title: Text(
                            "No: ${item.noPeminjaman ?? '-'}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "Status: ${item.statusPinjam ?? item.statusPengembalian ?? '-'}",
                          ),
                          onTap: () {
                            if (title.contains("Pengembalian")) {
                              Get.to(
                                () => const DafKembaliView(),
                                arguments: {
                                  'status': item.statusPengembalian ?? '-',
                                },
                              );
                            } else {
                              Get.to(() => const DafPinjamView());
                            }
                          },
                        ),
                      );
                    }).toList(),
                  ),
          ],
        ),
      ),
    );
  }
}
