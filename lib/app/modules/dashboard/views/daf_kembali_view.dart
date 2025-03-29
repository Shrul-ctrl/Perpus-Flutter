import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';

class DafKembaliView extends GetView<DashboardController> {
  const DafKembaliView({super.key});

  @override
  Widget build(BuildContext context) {
    DashboardController controller = Get.put(DashboardController());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pengembalian',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (controller.pengembalian.isEmpty) {
            return _emptyState();
          }
          return ListView.builder(
            itemCount: controller.pengembalian.length,
            itemBuilder: (context, index) {
              final pengembalian = controller.pengembalian[index];
              return ReturnCard(pengembalian: pengembalian);
            },
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
          Icon(Icons.assignment_return, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 10),
          const Text(
            "Belum ada riwayat pengembalian",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class ReturnCard extends StatelessWidget {
  final dynamic pengembalian;
  const ReturnCard({super.key, required this.pengembalian});

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
              "ID Peminjaman: ${pengembalian.idPeminjaman}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            ReturnInfoRow(
              title: "Tanggal Pengembalian",
              value: pengembalian.tanggalPenggembalian ?? "-",
            ),
            ReturnInfoRow(
              title: "Denda",
              value: pengembalian.denda == 0 ? "Tidak ada denda" : "Rp ${pengembalian.denda}",
            ),
            ReturnInfoRow(
              title: "Status Denda",
              value: pengembalian.statusDenda,
            ),
            ReturnInfoRow(
              title: "Status Kembali",
              value: pengembalian.statusKembali,
            ),
            ReturnInfoRow(
              title: "Alasan Kembali",
              value: pengembalian.alasanKembali ?? "-",
            ),
          ],
        ),
      ),
    );
  }
}

class ReturnInfoRow extends StatelessWidget {
  final String title;
  final String value;
  const ReturnInfoRow({super.key, required this.title, required this.value});

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
