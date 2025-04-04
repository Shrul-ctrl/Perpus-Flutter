import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:as_lib/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:as_lib/app/modules/dashboard/views/daf_kembali_view.dart';
import 'package:as_lib/app/modules/dashboard/views/daf_pinjam_view.dart';

class YourLoanView extends GetView<DashboardController> {
  const YourLoanView({super.key});

  @override
  Widget build(BuildContext context) {
    DashboardController controller = Get.put(DashboardController());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Riwayat Peminjaman & Pengembalian',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 🔹 2 Card (Peminjaman & Pengembalian)
            Row(
              children: [
                _buildCard("Peminjaman", Icons.book, Colors.blue, () {
                  Get.to(() => const DafPinjamView());
                }),
                const SizedBox(width: 10),
                _buildCard("Pengembalian", Icons.history, Colors.green, () {
                  Get.to(() => const DafKembaliView());
                }),
              ],
            ),
            const SizedBox(height: 20),

            // 🔹 Daftar Peminjaman & Pengembalian Terbaru (Limit 5)
            Expanded(
              child: Obx(() {
                return ListView(
                  children: [
                    _buildLatestList(
                      "Peminjaman Terbaru",
                      controller.peminjaman,
                    )
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Fungsi untuk membuat Card utama
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

  // 🔹 Fungsi untuk menampilkan daftar terbaru (Limit 5)
  Widget _buildLatestList(String title, List<dynamic> data) {
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
                    style: TextStyle(color: Colors.grey),
                  ),
                )
                : Column(
                  children:
                      data.take(2).map((item) {
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
                              color:
                                  title.contains("Peminjaman")
                                      ? Colors.blue
                                      : Colors.green,
                            ),
                            title: Text(
                              "No: ${item.noPeminjaman ?? '-'}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              "Status: ${item.statusPinjam ?? item.statusPengembalian ?? '-'}",
                            ),
                            onTap: () {
                              if (title.contains("Pengembalian")) {
                                Get.to(
                                  () => DafKembaliView(),
                                  arguments: {
                                    'status': item.statusPengembalian ?? '-',
                                  },
                                );
                              } else {
                                Get.to(() => DafPinjamView());
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
