import 'package:as_lib/app/data/buku_response.dart';
import 'package:as_lib/app/data/detail_buku_response.dart';
import 'package:as_lib/app/data/koleksi_response.dart';
import 'package:as_lib/app/data/peminjaman_response.dart';
import 'package:as_lib/app/data/pengembalian_response.dart';
import 'package:as_lib/app/modules/dashboard/views/index_view.dart';
import 'package:as_lib/app/modules/dashboard/views/profile_view.dart';
import 'package:as_lib/app/modules/dashboard/views/your_loan_view.dart';
import 'package:as_lib/app/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DashboardController extends GetxController {
  var selectedIndex = 0.obs;
  final _getConnect = GetConnect();
  final token = GetStorage().read('token');

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  final List<Widget> pages = [IndexView(), YourLoanView(), ProfileView()];

  Future<BukuResponse> getBuku() async {
    final response = await _getConnect.get(
      BaseUrl.buku,
      headers: {'Authorization': "Bearer $token"},
      contentType: "application/json",
    );
    return BukuResponse.fromJson(response.body);
  }

  // --- KOLEKSI SECTION ---
  var riwayatbuku = <Pengembalians>[].obs;
  var isLoadingKriwayatbuku = false.obs;

  Future<void> getriwayatbuku() async {
    try {
      isLoadingKriwayatbuku.value = true;
      print("Token saat ini: $token"); // Debugging, cek token

      final response = await _getConnect.get(
        BaseUrl.koleksi,
        headers: {'Authorization': "Bearer $token"},
        contentType: "application/json",
      );

      if (response.status.isOk) {
        final pengembalianResponse = PengembalianResponse.fromJson(
          response.body,
        );
        riwayatbuku.value = pengembalianResponse.pengembalians ?? [];
      } else {
        Get.snackbar("Error", "Gagal mengambil data carts");
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e");
    } finally {
      isLoadingKriwayatbuku.value = false;
    }
  }

  // --- KOLEKSI SECTION ---
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
        Get.snackbar("Error", "Gagal mengambil data cart");
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e");
    } finally {
      isLoadingKoleksi.value = false;
    }
  }

  void removeFromKoleksi(int id) async {
    try {
      final response = await _getConnect.delete(
        "${BaseUrl.koleksi}/$id",
        headers: {'Authorization': "Bearer $token"},
      );

      if (response.status.isOk) {
        koleksiBuku.removeWhere((item) => item.id == id);
        Get.snackbar("Sukses", "Buku dihapus dari keranjang");
        await getKoleksiBuku(); // Ambil ulang data cart agar tetap sinkron
      } else {
        Get.snackbar("Error", "Gagal menghapus buku dari keranjang");
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e");
    }
  }

  // --- PEMINJAMAN SECTION ---
  var peminjaman = <Peminjamans>[].obs;

  Future<void> getPeminjaman() async {
    final response = await _getConnect.get(
      BaseUrl.peminjaman,
      headers: {'Authorization': "Bearer $token"},
      contentType: "application/json",
    );
    final peminjamanResponse = PeminjamanResponse.fromJson(response.body);
    peminjaman.value = peminjamanResponse.peminjamans ?? [];
  }

  void logOut() async {
    final response = await _getConnect.post(
      BaseUrl.logout,
      {},
      headers: {'Authorization': "Bearer $token"},
      contentType: "application/json",
    );

    if (response.statusCode == 200) {
      Get.snackbar(
        "Success",
        "Logout Success",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      GetStorage().erase();
      Get.offAllNamed('/login');
    } else {
      Get.snackbar(
        "Failed",
        "Logout Failed",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<DetailBukuResponse> getDetailBuku({required int id}) async {
    final response = await _getConnect.get(
      '${BaseUrl.detailBukus}/$id',
      headers: {'Authorization': "Bearer $token"},
      contentType: "application/json",
    );
    return DetailBukuResponse.fromJson(response.body);
  }

  @override
  void onInit() {
    getBuku();
    getPeminjaman();
    // getKoleksiBuku();
    // getriwayatbuku();
    super.onInit();
  }
}
