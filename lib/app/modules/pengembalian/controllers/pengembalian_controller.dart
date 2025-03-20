import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PengembalianController extends GetxController {
  var isLoading = false.obs;
  var jumlahKembali = <int>[].obs;
  var bukuHilang = <int>[].obs;
  var bukuRusak = <int>[].obs;
  var bukuDipinjam = <Map<String, dynamic>>[].obs;
  var noPeminjaman = ''.obs;
  var jumlahPinjam = 0.obs;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      noPeminjaman.value = Get.arguments['no_peminjaman']?.toString() ?? 'N/A';
      jumlahPinjam.value = Get.arguments['jumlah_pinjam'] ?? 0;

      if (Get.arguments['buku_dipinjam'] is List) {
        var bukuList = List<Map<String, dynamic>>.from(
          Get.arguments['buku_dipinjam'],
        );
        bukuDipinjam.assignAll(bukuList);

        jumlahKembali.assignAll(List<int>.filled(bukuDipinjam.length, 0));
        bukuHilang.assignAll(List<int>.filled(bukuDipinjam.length, 0));
        bukuRusak.assignAll(List<int>.filled(bukuDipinjam.length, 0));
      }
    } else {
      print("Get.arguments is null, data tidak tersedia");
    }
  }

  Future<void> addPengembalian() async {
    isLoading.value = true;
    String url = 'http://192.168.1.7:8000/api/pengembalian/create';

    Map<String, dynamic> body = {
      "id_peminjaman": noPeminjaman.value,
      "id_buku": bukuDipinjam.map((buku) => buku['id']).toList(),
      "jumlah_kembali": jumlahKembali.toList(),
      "buku_hilang": bukuHilang.toList(),
      "buku_rusak": bukuRusak.toList(),
      "denda_hilang": bukuHilang.map((hilang) => hilang > 0 ? 1 : 0).toList(),
      "denda_rusak": bukuRusak.map((rusak) => rusak > 0 ? 0.5 : 0).toList(),
    };

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      );

      var data = json.decode(response.body);

      if (response.statusCode == 201) {
        Get.snackbar(
          "Sukses",
          data['message'],
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAllNamed('/home');
      } else {
        Get.snackbar(
          "Error",
          data['message'],
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Gagal menghubungi server",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
