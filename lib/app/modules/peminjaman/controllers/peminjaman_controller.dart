import 'package:as_lib/app/modules/cart/controllers/cart_controller.dart';
import 'package:as_lib/app/modules/dashboard/views/your_loan_view.dart';
import 'package:as_lib/app/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PeminjamanController extends GetxController {
  final _getConnect = GetConnect();
  final box = GetStorage();
  final CartController cartController = Get.find();
  

  Future<void> addPeminjaman() async {
    try {
      String? token = box.read('token');
      if (token == null) {
        Get.snackbar("Error", "Token tidak ditemukan.");
        return;
      }

      final response = await _getConnect.post(
        BaseUrl.addpeminjaman,
        {},
        headers: {
          'Authorization': "Bearer $token",
          'Accept': "application/json",
          'Content-Type': "application/json",
        },
      );

      if (response.statusCode == 201) {
        Get.snackbar(
          "Success",
          "Peminjaman berhasil diajukan",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        cartController.getCart(); // 🔄 Refresh cart setelah peminjaman
        Get.offAll(() => YourLoanView()); // 🚀 Pindah ke halaman peminjaman!
      } else {
        String errorMessage = response.body['message'] ?? "Terjadi kesalahan";
        Get.snackbar(
          "Failed",
          errorMessage,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e");
    }
    
  }
}
