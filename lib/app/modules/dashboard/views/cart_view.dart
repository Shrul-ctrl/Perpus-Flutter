import 'package:as_lib/app/modules/cart/controllers/cart_controller.dart';
import 'package:as_lib/app/modules/peminjaman/controllers/peminjaman_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartView extends StatelessWidget {
  final CartController controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Keranjang Peminjaman")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.carts.isEmpty) {
            return const Center(child: Text("Keranjang peminjaman kosong"));
          }

          return ListView.builder(
            itemCount: controller.carts.length,
            itemBuilder: (context, index) {
              final cartItem = controller.carts[index];

              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  title: Text(
                    cartItem.buku?.judul ?? "Judul tidak tersedia",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("ISBN: ${cartItem.buku?.isbn ?? "-"}"),
                      Row(
                        children: [
                          // Tombol Kurangi
                          IconButton(
                            icon: const Icon(
                              Icons.remove_circle,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              if (cartItem.jumlahPinjam! > 1) {
                                controller.editCart(
                                  cartItem.id!,
                                  cartItem.jumlahPinjam! - 1,
                                );
                              }
                            },
                          ),
                          // Jumlah Peminjaman
                          Text(
                            "${cartItem.jumlahPinjam}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // Tombol Tambah
                          IconButton(
                            icon: const Icon(
                              Icons.add_circle,
                              color: Colors.green,
                            ),
                            onPressed: () {
                              controller.editCart(
                                cartItem.id!,
                                cartItem.jumlahPinjam! + 1,
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      controller.deleteCart(cartItem.id!);
                    },
                  ),
                ),
              );
            },
          );
        }),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            final peminjamanController = Get.put(PeminjamanController());
            peminjamanController.addPeminjaman();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green, // Warna tombol hijau
            foregroundColor: Colors.white, // Warna teks putih
            padding: const EdgeInsets.symmetric(vertical: 16), // Padding tombol
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Sudut tombol membulat
            ),
          ),
          child: const Text("Ajukan Peminjaman"),
        ),
      ),
    );
  }
}
