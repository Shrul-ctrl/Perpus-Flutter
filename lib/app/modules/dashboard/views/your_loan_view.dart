import 'package:as_lib/app/modules/cart/views/cart_view.dart';
import 'package:as_lib/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:as_lib/app/modules/dashboard/views/detail_pengembalian_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class YourLoanView extends GetView {
  const YourLoanView({super.key});

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
        child: Obx(() {
          if (controller.peminjaman.isEmpty) {
            return const Center(child: Text("Tidak ada data peminjaman"));
          }
          return ListView.builder(
            itemCount: controller.peminjaman.length,
            itemBuilder: (context, index) {
              final peminjaman = controller.peminjaman[index];

              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  children: [
                    ExpansionTile(
                      title: Text(
                        "No. Peminjaman: ${peminjaman.noPeminjaman}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Status: ${peminjaman.statusPinjam}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color:
                                      peminjaman.statusPinjam == "disetujui"
                                          ? Colors.green
                                          : Colors.red,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Tanggal Pinjam: ${peminjaman.tanggalPinjam}",
                                style: const TextStyle(fontSize: 14),
                              ),
                              Text(
                                "Batas Pinjam: ${peminjaman.batasPinjam}",
                                style: const TextStyle(fontSize: 14),
                              ),
                              const Divider(),
                              const Text(
                                "Buku yang Dipinjam:",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              ...peminjaman.peminjamanDetails!.map((detail) {
                                return ListTile(
                                  title: Text(
                                    detail.buku?.judul ??
                                        "Judul tidak tersedia",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    "Jumlah: ${detail.jumlahPinjam}",
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(
                              () => DetailPengembalianView(),
                              arguments: {
                                'no_peminjaman': peminjaman.noPeminjaman,
                                'jumlah_pinjam': peminjaman.peminjamanDetails!
                                    .fold(
                                      0,
                                      (sum, detail) =>
                                          sum + (detail.jumlahPinjam ?? 0),
                                    ),
                                'buku_dipinjam':
                                    peminjaman.peminjamanDetails!.map((detail) {
                                      return {
                                        'id': detail.buku?.id ?? 0,
                                        'judul':
                                            detail.buku?.judul ??
                                            "Judul tidak tersedia",
                                        'jumlah': detail.jumlahPinjam ?? 0,
                                      };
                                    }).toList(),
                              },
                            );
                          },

                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                          ),
                          child: const Text(
                            "Selesai Pinjam",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
