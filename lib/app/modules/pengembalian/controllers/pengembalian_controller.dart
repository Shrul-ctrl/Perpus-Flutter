import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PengembalianController extends GetxController {
  final box = GetStorage();
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
    String? token = box.read('token');
    String url = 'http://192.168.1.7:8000/api/pengembalian/create';

    Map<String, dynamic> body = {
      "no_peminjaman":
          noPeminjaman.value, // Kirim string langsung, bukan ID angka
      "id_buku": bukuDipinjam.map((buku) => buku['id']).toList(),
      "jumlah_kembali": {
        for (int i = 0; i < bukuDipinjam.length; i++)
          bukuDipinjam[i]['id'].toString(): jumlahKembali[i],
      },
      "buku_hilang": {
        for (int i = 0; i < bukuDipinjam.length; i++)
          bukuDipinjam[i]['id'].toString(): bukuHilang[i],
      },
      "buku_rusak": {
        for (int i = 0; i < bukuDipinjam.length; i++)
          bukuDipinjam[i]['id'].toString(): bukuRusak[i],
      },
      "denda_hilang": {
        for (int i = 0; i < bukuDipinjam.length; i++)
          bukuDipinjam[i]['id'].toString():
              bukuHilang[i] > 0 ? bukuDipinjam[i]['harga'] : 0,
      },
      "denda_rusak": {
        for (int i = 0; i < bukuDipinjam.length; i++)
          bukuDipinjam[i]['id'].toString():
              bukuRusak[i] > 0 ? (bukuDipinjam[i]['harga'] * 0.5) : 0,
      },
    };

    try {
      print("Request Body: ${json.encode(body)}"); // Debug log sebelum request
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': "Bearer $token",
          'Accept': "application/json",
          'Content-Type': "application/json",
        },
        body: json.encode(body),
      );

      print("Response Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 201) {
        var data = json.decode(response.body);
        Get.snackbar(
          "Sukses",
          data['message'],
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAllNamed('/home');
      } else {
        try {
          var errorData = json.decode(response.body);
          Get.snackbar(
            "Error",
            errorData['message'] ?? 'Terjadi kesalahan',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        } catch (e) {
          Get.snackbar(
            "Error",
            "Kesalahan server, cek kembali API.",
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Gagal menghubungi server: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
