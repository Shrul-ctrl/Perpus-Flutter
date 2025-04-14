import 'package:as_lib/app/data/koleksi_response.dart';
import 'package:as_lib/app/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class KoleksiController extends GetxController {
  var selectedIndex = 0.obs;
  final _getConnect = GetConnect();
  final token = GetStorage().read('token');

  var koleksiBuku = <Kolekasis>[].obs;
  var isLoadingKoleksi = false.obs;
  var favoriteBookIds =
      <int>{}.obs; // Tambahkan untuk menyimpan ID buku yang dikoleksi

  @override
  void onInit() {
    super.onInit();
    getKoleksiBuku(); // Ambil koleksi saat controller diinisialisasi
  }

  Future<void> getKoleksiBuku() async {
    try {
      isLoadingKoleksi.value = true;
      final response = await _getConnect.get(
        BaseUrl.koleksi,
        headers: {'Authorization': "Bearer $token"},
        contentType: "application/json",
      );

      if (response.status.isOk) {
        final koleksiResponse = KoleksiResponse.fromJson(response.body);
        koleksiBuku.value = koleksiResponse.kolekasis ?? [];

        // Simpan ID buku yang sudah dikoleksi ke favoriteBookIds
        favoriteBookIds.value =
            koleksiBuku
                .where((e) => e.idBuku != null) // Cegah null
                .map((e) => e.idBuku!) // Ambil langsung karena sudah int
                .toSet();
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
    int idBukuInt = int.tryParse(idBuku) ?? 0;

    // Cek apakah buku sudah ada di koleksi
    if (favoriteBookIds.contains(idBukuInt)) {
      Get.snackbar(
        "Info",
        "Buku sudah ada di koleksi Anda!",
        snackPosition: SnackPosition.BOTTOM,
      );
      return; // Jangan kirim request ke API jika sudah ada
    }

    try {
      final response = await _getConnect.post(
        BaseUrl.addkoleksi,
        {'id_user': idUser, 'id_buku': idBuku, 'status_disukai': "suka"},
        headers: {
          'Authorization': "Bearer $token",
          'Content-Type': "application/json",
        },
      );

      if (response.statusCode == 201) {
        // Tambahkan buku ke koleksi
        favoriteBookIds.add(idBukuInt);
        Get.snackbar(
          "Sukses",
          "Buku ditambahkan ke koleksi!",
          snackPosition: SnackPosition.BOTTOM,
        );
        await getKoleksiBuku(); // Perbarui daftar koleksi
      } else {
        Get.snackbar(
          "Failed",
          "Gagal menambahkan koleksi: ${response.body}",
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
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
        favoriteBookIds.remove(id); // Hapus dari daftar ID favorit
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
