import 'package:as_lib/app/modules/pengembalian/controllers/pengembalian_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailPengembalianView extends StatelessWidget {
  final PengembalianController controller = Get.put(PengembalianController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Form Pengembalian Buku'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Detail Peminjaman
            Obx(
              () => Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "No Peminjaman: ${controller.noPeminjaman.value}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Jumlah Pinjam: ${controller.jumlahPinjam.value}",
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 10),

            // List Buku Dipinjam
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.bukuDipinjam.length,
                  itemBuilder: (context, index) {
                    var buku = controller.bukuDipinjam[index];

                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              buku['judul'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildCounterField(
                                  "Jumlah Kembali",
                                  controller.jumlahKembali,
                                  index,
                                ),
                                _buildCounterField(
                                  "Buku Rusak",
                                  controller.bukuRusak,
                                  index,
                                ),
                                _buildCounterField(
                                  "Buku Hilang",
                                  controller.bukuHilang,
                                  index,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            SizedBox(height: 20),
            Obx(
              () =>
                  controller.isLoading.value
                      ? Center(child: CircularProgressIndicator())
                      : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: controller.addPengembalian,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: Text(
                            "Kirim Pengembalian",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCounterField(String label, RxList<int> list, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Row(
          children: [
            IconButton(
              onPressed: () {
                if (list[index] > 0) {
                  list[index]--;
                  list.refresh();
                }
              },
              icon: Icon(Icons.remove, color: Colors.red),
            ),
            Obx(
              () => Text(
                list[index].toString(),
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
              onPressed: () {
                int total =
                    controller.jumlahKembali[index] +
                    controller.bukuRusak[index] +
                    controller.bukuHilang[index];

                if (total < controller.bukuDipinjam[index]['jumlah']) {
                  list[index]++;
                  list.refresh();
                }
              },
              icon: Icon(Icons.add, color: Colors.green),
            ),
          ],
        ),
      ],
    );
  }
}
