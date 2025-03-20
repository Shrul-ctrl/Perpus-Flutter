import 'package:as_lib/app/modules/pengembalian/controllers/pengembalian_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailPengembalianView extends StatefulWidget {
  @override
  _DetailPengembalianViewState createState() => _DetailPengembalianViewState();
}

class _DetailPengembalianViewState extends State<DetailPengembalianView> {
  final PengembalianController controller = Get.put(PengembalianController());

  final Map<String, dynamic> peminjamanData = Get.arguments;
  final List<TextEditingController> jumlahKembaliControllers = [];
  final List<TextEditingController> bukuHilangControllers = [];
  final List<TextEditingController> bukuRusakControllers = [];

  @override
  void initState() {
    super.initState();
    for (var buku in peminjamanData['buku_dipinjam']) {
      jumlahKembaliControllers.add(TextEditingController(text: "0"));
      bukuHilangControllers.add(TextEditingController(text: "0"));
      bukuRusakControllers.add(TextEditingController(text: "0"));
    }
  }

  @override
  void dispose() {
    for (var controller in jumlahKembaliControllers) {
      controller.dispose();
    }
    for (var controller in bukuHilangControllers) {
      controller.dispose();
    }
    for (var controller in bukuRusakControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void submitPengembalian() {
    List<int> idBuku = [];
    List<int> jumlahKembali = [];
    List<int> bukuHilang = [];
    List<int> bukuRusak = [];
    List<int> dendaHilang = [];
    List<int> dendaRusak = [];

    for (int i = 0; i < peminjamanData['buku_dipinjam'].length; i++) {
      var buku = peminjamanData['buku_dipinjam'][i];
      int totalDipinjam = buku['jumlah'] ?? 0;
      int kembali = int.tryParse(jumlahKembaliControllers[i].text) ?? 0;
      int hilang = int.tryParse(bukuHilangControllers[i].text) ?? 0;
      int rusak = int.tryParse(bukuRusakControllers[i].text) ?? 0;

      // Validasi jumlah total pengembalian tidak boleh melebihi jumlah dipinjam
      if (kembali + hilang + rusak > totalDipinjam) {
        Get.snackbar("Kesalahan",
            "Total pengembalian buku '${buku['judul']}' melebihi jumlah yang dipinjam",
            backgroundColor: Colors.red, colorText: Colors.white);
        return;
      }

      idBuku.add(buku['id']);
      jumlahKembali.add(kembali);
      bukuHilang.add(hilang);
      bukuRusak.add(rusak);
      dendaHilang.add(hilang > 0 ? 50000 * hilang : 0);
      dendaRusak.add(rusak > 0 ? 20000 * rusak : 0);
    }

    // Panggil API untuk submit data
    controller.addPengembalian(
      idPeminjaman: peminjamanData['no_peminjaman'],
      idBuku: idBuku,
      jumlahKembali: jumlahKembali,
      bukuHilang: bukuHilang,
      bukuRusak: bukuRusak,
      dendaHilang: dendaHilang,
      dendaRusak: dendaRusak,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Pengembalian')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("No Peminjaman: ${peminjamanData['no_peminjaman']}"),
            Text("Tanggal Pinjam: ${peminjamanData['tanggal_pinjam']}"),
            Text("Batas Pinjam: ${peminjamanData['batas_pinjam']}"),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: peminjamanData['buku_dipinjam'].length,
                itemBuilder: (context, index) {
                  var buku = peminjamanData['buku_dipinjam'][index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Judul: ${buku['judul']}",
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text("Jumlah Dipinjam: ${buku['jumlah']}"),
                          TextField(
                            controller: jumlahKembaliControllers[index],
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(labelText: "Jumlah Kembali"),
                          ),
                          TextField(
                            controller: bukuHilangControllers[index],
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(labelText: "Buku Hilang"),
                          ),
                          TextField(
                            controller: bukuRusakControllers[index],
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(labelText: "Buku Rusak"),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Obx(() => ElevatedButton(
                  onPressed: controller.isLoading.value ? null : submitPengembalian,
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator()
                      : const Text("Kembalikan Buku"),
                )),
          ],
        ),
      ),
    );
  }
}
