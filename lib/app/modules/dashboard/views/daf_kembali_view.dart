import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../controllers/dashboard_controller.dart';

class DafKembaliView extends StatelessWidget {
  const DafKembaliView({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardController controller = Get.put(DashboardController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getPengembalian();
    });

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

          if (controller.pengembalian.isEmpty) {
            return _emptyState();
          }

          return RefreshIndicator(
            onRefresh: controller.getPengembalian,
            child: ListView.builder(
              itemCount: controller.pengembalian.length,
              itemBuilder: (context, index) {
                final pengembalian = controller.pengembalian[index];
                return ReturnCard(pengembalian: pengembalian);
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
    final Color cardColor = Colors.green.shade50;
    final Color titleColor = Colors.green.shade800;

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: cardColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.library_books_rounded, color: Colors.green),
                const SizedBox(width: 8),
                Text(
                  "No. Peminjaman: ${pengembalian.noPeminjaman}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: titleColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(thickness: 1.2),

            ReturnInfoRow(
              icon: Icons.calendar_today,
              title: "Tanggal Pengembalian",
              value: pengembalian.tanggalPengembalian ?? "-",
            ),
            ReturnInfoRow(
              icon: Icons.attach_money,
              title: "Denda",
              value:
                  pengembalian.denda == 0
                      ? "Tidak ada denda"
                      : "Rp ${pengembalian.denda}",
              highlight: pengembalian.denda != 0,
            ),

            // Ganti status Denda dengan badge
            _buildStatusBadge(
              icon: Icons.info_outline,
              label: "Status Denda",
              status:
                  pengembalian.denda == 0
                      ? 'tidak ada'
                      : pengembalian.statusDenda,
            ),

            // Ganti status Kembali dengan badge
            _buildStatusBadge(
              icon: Icons.check_circle,
              label: "Status Kembali",
              status: pengembalian.statusKembali,
            ),

            ReturnInfoRow(
              icon: Icons.notes_rounded,
              title: "Alasan Kembali",
              value: pengembalian.alasanKembali ?? "-",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge({
    required IconData icon,
    required String label,
    required String status,
  }) {
    Color bgColor;
    Color textColor;
    IconData statusIcon;

    switch (status.toLowerCase()) {
      case 'disetujui':
        bgColor = Colors.green.shade100;
        textColor = Colors.green.shade800;
        statusIcon = Icons.check_circle_outline;
        break;
      case 'ditolak':
        bgColor = Colors.red.shade100;
        textColor = Colors.red.shade800;
        statusIcon = Icons.cancel_outlined;
        break;
      case 'menunggu':
      default:
        bgColor = Colors.orange.shade100;
        textColor = Colors.orange.shade800;
        statusIcon = Icons.hourglass_top;
        break;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.green.shade700),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(statusIcon, size: 16, color: textColor),
                const SizedBox(width: 6),
                Text(
                  status.capitalizeFirst ?? status,
                  style: TextStyle(
                    fontSize: 13,
                    color: textColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ReturnInfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final bool highlight;

  const ReturnInfoRow({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.green.shade700),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: highlight ? Colors.red : Colors.grey.shade800,
              fontWeight: highlight ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
