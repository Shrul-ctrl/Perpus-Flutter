import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:as_lib/app/modules/dashboard/controllers/dashboard_controller.dart';

class RiwayatView extends GetView<DashboardController> {
  const RiwayatView({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardController controller = Get.put(DashboardController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Peminjaman'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (controller.isLoadingKriwayatbuku.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.riwayatbuku.isEmpty) {
            return const Center(child: Text("Tidak ada riwayat peminjaman"));
          }

          return ListView.builder(
            itemCount: controller.riwayatbuku.length,
            itemBuilder: (context, index) {
              final riwayat = controller.riwayatbuku[index];
              // final peminjaman = riwayat.peminjaman;

              if (riwayat.statusKembali != "disetujui") {
                return const SizedBox(); // Jika status bukan "dikembalikan", tidak ditampilkan
              }

              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        "Tanggal Pengembalian: ${riwayat.tanggalPenggembalian ?? "Belum dikembalikan"}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const Divider(),
                      const Text(
                        "Buku yang Dikembalikan:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
