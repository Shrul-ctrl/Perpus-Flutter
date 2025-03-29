import 'package:as_lib/app/data/koleksi_response.dart';
import 'package:as_lib/app/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class KoleksiController extends GetxController {
  //TODO: Implement KoleksiController

  // --- KOLEKSI SECTION ---
  var selectedIndex = 0.obs;
  final _getConnect = GetConnect();
  final token = GetStorage().read('token');
  var koleksiBuku = <Kolekasis>[].obs;
  var isLoadingKoleksi = false.obs;

  Future<void> getKoleksiBuku() async {
    try {
      isLoadingKoleksi.value = true;
      print("Token saat ini: $token"); // Debugging, cek token

      final response = await _getConnect.get(
        BaseUrl.koleksi,
        headers: {'Authorization': "Bearer $token"},
        contentType: "application/json",
      );

      if (response.status.isOk) {
        final koleksiResponse = KoleksiResponse.fromJson(response.body);
        koleksiBuku.value = koleksiResponse.kolekasis ?? [];
      } else {
        Get.snackbar("Error", "Gagal mengambil data koleksi");
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e");
    } finally {
      isLoadingKoleksi.value = false;
    }
  }

  Future<void> addKoleksi(String idUser, String idBuku) async {
    try {
      if (token == null) {
        Get.snackbar("Error", "Token tidak ditemukan.");
        return;
      }

      print("Mengirim request ke: ${BaseUrl.addkoleksi}");
      print("Payload: id_user: $idUser, id_buku: $idBuku");

      final response = await _getConnect.post(
        BaseUrl.addkoleksi,
        {
          'id_user': idUser,
          'id_buku': idBuku,
          'status_disukai': "suka", // Ubah dari 'jumlah_pinjam'
        },
        headers: {
          'Authorization': "Bearer $token",
          'Content-Type': "application/json",
        },
      );

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 201) {
        Get.snackbar(
          "Success",
          "Koleksi berhasil ditambahkan",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          "Failed",
          "Gagal menambahkan koleksi: ${response.body}",
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      print("Error: $e");
      Get.snackbar("Error", "Terjadi kesalahan: $e");
    }
  }

  void removeFromKoleksi(int id) async {
    try {
      final response = await _getConnect.delete(
        "${BaseUrl.deletekoleksi}/$id",
        headers: {'Authorization': "Bearer $token"},
      );

      if (response.status.isOk) {
        koleksiBuku.removeWhere((item) => item.id == id);
        Get.snackbar("Sukses", "Buku Batal Dikoleksi");
        await getKoleksiBuku(); // Ambil ulang data koleksi agar tetap sinkron
      } else {
        Get.snackbar("Error", "Buku Gagal untuk Dikoleksi");
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e");
    }
  }
}
