import 'package:as_lib/app/modules/cart/controllers/cart_controller.dart';
import 'package:as_lib/app/modules/dashboard/views/cart_view.dart';
import 'package:as_lib/app/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:as_lib/app/data/buku_response.dart';
import 'package:get_storage/get_storage.dart';

class BookDetailView extends StatelessWidget {
  final Bukus buku;
  const BookDetailView({super.key, required this.buku});
  @override
  Widget build(BuildContext context) {
    CartController controller = Get.put(CartController());
    final String? idUser = GetStorage().read('token');
    if (idUser == null) {
      return Scaffold(
        body: Center(child: Text("User tidak ditemukan, silakan login ulang.")),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Buku'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Get.to(() => CartView());
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ======== GAMBAR BUKU =========
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      '${BaseUrl.imagePath}/${buku.foto}',
                      // 'http://192.168.1.7:8000/img/${buku.foto}',
                      fit: BoxFit.cover,
                      height: 500,
                      width: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        return const SizedBox(
                          height: 250,
                          child: Center(child: Text('Image not found')),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${buku.jumlahBuku ?? 0} Buku',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // ======== DETAIL BUKU =========
              Text(
                buku.judul ?? "Judul tidak tersedia",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              _buildDetailRow('ISBN', buku.isbn.toString()),
              _buildDetailRow('Deskripsi', buku.deskripsi),
              _buildDetailRow('Penulis', buku.penuli?.namaPenulis),
              _buildDetailRow('Penerbit', buku.penerbit?.namaPenerbit),
              _buildDetailRow('Kategori', buku.kategori?.namaKategori),
              _buildDetailRow('Tahun Terbit', buku.tahunTerbit),
              const SizedBox(height: 24),

              // ======== TOMBOL "TAMBAHKAN KE CART" =========
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                  ),
                  onPressed: () {
                    controller.addCart(idUser, buku.id.toString());
                  },
                  child: const Text("Tambahkan ke cart"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text.rich(
        TextSpan(
          text: "$title: ",
          style: const TextStyle(fontWeight: FontWeight.bold),
          children: [
            TextSpan(
              text: value ?? "Tidak tersedia",
              style: const TextStyle(fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
