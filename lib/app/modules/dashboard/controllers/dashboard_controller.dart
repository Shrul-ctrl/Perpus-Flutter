import 'package:as_lib/app/data/buku_response.dart';
import 'package:as_lib/app/data/detail_buku_response.dart';
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
  var isLoading = false.obs;

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

  // --- PEMINJAMAN SECTION ---
  var peminjaman = <Peminjamans>[].obs;

  Future<void> getPeminjaman() async {
    try {
      isLoading.value = true;
      final response = await _getConnect.get(
        BaseUrl.peminjaman,
        headers: {'Authorization': "Bearer $token"},
        contentType: "application/json",
      );
      final peminjamanResponse = PeminjamanResponse.fromJson(response.body);
      peminjaman.value = peminjamanResponse.peminjamans ?? [];
    } finally {
      isLoading.value = false;
    }
  }

  // --- PEMINJAMAN SECTION ---
  var pengembalian = <Pengembalians>[].obs;

  Future<void> getPengembalian() async {
    try {
      isLoading.value = true;
      final response = await _getConnect.get(
        BaseUrl.pengembalian,
        headers: {'Authorization': "Bearer $token"},
        contentType: "application/json",
      );
      final pengembalianResponse = PengembalianResponse.fromJson(response.body);
      pengembalian.value = pengembalianResponse.pengembalians ?? [];
    } finally {
      isLoading.value = false;
    }
  }

  

  Future<DetailBukuResponse> getDetailBuku({required int id}) async {
    try {
      isLoading.value = true;
      final response = await _getConnect.get(
        '${BaseUrl.detailBukus}/$id',
        headers: {'Authorization': "Bearer $token"},
        contentType: "application/json",
      );
      return DetailBukuResponse.fromJson(response.body);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    getBuku();
    getPeminjaman();
    getPengembalian();
    super.onInit();
  }
}
