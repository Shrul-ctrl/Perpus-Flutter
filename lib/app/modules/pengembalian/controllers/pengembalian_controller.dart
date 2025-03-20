import 'package:as_lib/app/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PengembalianController extends GetxController {
  var isLoading = false.obs;

  Future<void> addPengembalian({
    required int idPeminjaman,
    required List<int> idBuku,
    required List<int> jumlahKembali,
    required List<int> bukuHilang,
    required List<int> bukuRusak,
    required List<int> dendaHilang,
    required List<int> dendaRusak,
  }) async {
    try {
      isLoading.value = true;

      // Buat body request
      Map<String, dynamic> requestBody = {
        'id_peminjaman': idPeminjaman,
        'id_buku': idBuku,
        'jumlah_kembali': jumlahKembali,
        'buku_hilang': bukuHilang,
        'buku_rusak': bukuRusak,
        'denda_hilang': dendaHilang,
        'denda_rusak': dendaRusak,
      };

      var response = await http.post(
        Uri.parse(BaseUrl.pengembalian),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      var responseData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        Get.snackbar("Sukses", "Pengembalian berhasil dikirim",
            backgroundColor: Colors.green, colorText: Colors.white);
        Get.back(); // Kembali ke halaman sebelumnya
      } else {
        Get.snackbar("Gagal", responseData['message'] ?? "Terjadi kesalahan",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Gagal menghubungkan ke server",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}
