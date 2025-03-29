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
        
          return ListView.builder(
          
            itemBuilder: (context, index) {

              // final peminjaman = riwayat.peminjaman;

             

              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
          
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
