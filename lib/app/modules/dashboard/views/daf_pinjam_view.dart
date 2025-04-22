import 'package:as_lib/app/modules/cart/views/cart_view.dart';
import 'package:as_lib/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:as_lib/app/modules/dashboard/views/detail_pengembalian_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class DafPinjamView extends GetView<DashboardController> {
  const DafPinjamView({super.key});

  @override
  Widget build(BuildContext context) {
    DashboardController controller = Get.put(DashboardController());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Peminjaman',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Get.to(() => CartView()),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
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
          if (controller.peminjaman.isEmpty) {
            return _emptyState();
          }

          // Membungkus ListView dengan RefreshIndicator
          return RefreshIndicator(
            onRefresh: () async {
              // Panggil fungsi untuk mengambil ulang data peminjaman
              await controller.refresh();
            },
            child: ListView.builder(
              itemCount: controller.peminjaman.length,
              itemBuilder: (context, index) {
                final peminjaman = controller.peminjaman[index];
                return LoanCard(peminjaman: peminjaman);
              },
            ),
          );
        }),
      ),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.library_books, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 10),
          const Text(
            "Belum ada riwayat peminjaman",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}


class LoanCard extends StatelessWidget {
  final dynamic peminjaman;
  const LoanCard({super.key, required this.peminjaman});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "No. Peminjaman: ${peminjaman.noPeminjaman}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            LoanStatus(status: peminjaman.statusPinjam),
            const SizedBox(height: 5),
            LoanInfoRow(
              title: "Tanggal Pinjam",
              value: peminjaman.tanggalPinjam,
            ),
            LoanInfoRow(title: "Batas Pinjam", value: peminjaman.batasPinjam),
            const Divider(),
            const Text(
              "Buku yang Dipinjam:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ...?peminjaman.peminjamanDetails?.map((detail) {
              return ListTile(
                leading: Icon(Icons.book, color: Colors.blue.shade700),
                title: Text(
                  detail.buku?.judul ?? "Judul tidak tersedia",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Jumlah: ${detail.jumlahPinjam}"),
              );
            }).toList(),
            if (peminjaman.statusPinjam == "disetujui")
              LoanReturnButton(peminjaman: peminjaman),
          ],
        ),
      ),
    );
  }
}

class LoanStatus extends StatelessWidget {
  final String status;
  const LoanStatus({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color statusColor = Colors.orange;
    if (status == "disetujui") statusColor = Colors.green;
    if (status == "ditolak") statusColor = Colors.red;

    return Row(
      children: [
        Icon(Icons.info, color: statusColor, size: 18),
        const SizedBox(width: 5),
        Text(
          "Status: $status",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: statusColor,
          ),
        ),
      ],
    );
  }
}

class LoanInfoRow extends StatelessWidget {
  final String title;
  final String value;
  const LoanInfoRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          Text(value, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        ],
      ),
    );
  }
}

class LoanReturnButton extends StatelessWidget {
  final dynamic peminjaman;
  const LoanReturnButton({super.key, required this.peminjaman});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: ElevatedButton(
        onPressed: () {
          Get.to(
            () => DetailPengembalianView(),
            arguments: {
              'no_peminjaman': peminjaman.noPeminjaman,
              'jumlah_pinjam':
                  peminjaman.peminjamanDetails?.fold(
                    0,
                    (sum, detail) => sum + (detail.jumlahPinjam ?? 0),
                  ) ??
                  0,
              'buku_dipinjam':
                  peminjaman.peminjamanDetails?.map((detail) {
                    return {
                      'id': detail.buku?.id ?? 0,
                      'judul': detail.buku?.judul ?? "Judul tidak tersedia",
                      'jumlah': detail.jumlahPinjam ?? 0,
                    };
                  }).toList() ??
                  [],
            },
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        ),
        child: const Text(
          "Selesai Pinjam",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
