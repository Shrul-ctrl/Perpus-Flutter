import 'package:as_lib/app/data/cart_response.dart';
import 'package:as_lib/app/modules/dashboard/views/cart_view.dart';
import 'package:as_lib/app/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CartController extends GetxController {
  final _getConnect = GetConnect();
  final String? token = GetStorage().read('token'); // Perbaikan membaca token
  final TextEditingController jumlahPinjamController = TextEditingController();

  var carts = <Carts>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getCart();
  }

  /// **Mengambil Data Cart**
  Future<void> getCart() async {
    try {
      isLoading.value = true;
      if (token == null) {
        Get.snackbar("Error", "Token tidak ditemukan.");
        return;
      }

      final response = await _getConnect.get(
        BaseUrl.cart,
        headers: {'Authorization': "Bearer $token"},
      );

      if (response.status.isOk) {
        final cartResponse = CartResponse.fromJson(response.body);
        carts.value = cartResponse.carts ?? [];
      } else {
        Get.snackbar("Error", "Gagal mengambil data cart");
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// **Menambahkan Cart**
  Future<void> addCart(String idUser, String idBuku) async {
    try {
      if (token == null) {
        Get.snackbar("Error", "Token tidak ditemukan.");
        return;
      }

      final response = await _getConnect.post(
        BaseUrl.addcart,
        {
          'id_user': idUser,
          'id_buku': idBuku,
          'jumlah_pinjam':
              int.tryParse(jumlahPinjamController.text) ?? 1, // Validasi angka
        },
        headers: {
          'Authorization': "Bearer $token",
          'Content-Type': "application/json",
        },
      );

      if (response.statusCode == 201) {
        Get.snackbar(
          "Success",
          "Cart Added",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        await getCart();
        Get.to(() => CartView());
      } else {
        Get.snackbar(
          "Failed",
          "Cart Failed to Add: ${response.body}",
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e");
    }
  }

  /// **Mengedit Cart**
  Future<void> editCart(int id, int newJumlahPinjam) async {
    try {
      isLoading.value = true;
      if (token == null) {
        Get.snackbar("Error", "Token tidak ditemukan.");
        return;
      }

      final response = await _getConnect.put(
        '${BaseUrl.editcart}/$id',
        {'jumlah_pinjam': newJumlahPinjam},
        headers: {
          'Authorization': "Bearer $token",
          'Content-Type': "application/json",
        },
      );

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Cart Updated", backgroundColor: Colors.green);
        getCart();
      } else {
        Get.snackbar(
          "Failed",
          "Failed to update cart: ${response.body}",
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// **Menghapus Cart**
  Future<void> deleteCart(int id) async {
    try {
      isLoading.value = true;
      if (token == null) {
        Get.snackbar("Error", "Token tidak ditemukan.");
        return;
      }

      final response = await _getConnect.delete(
        '${BaseUrl.deletecart}/$id',
        headers: {'Authorization': "Bearer $token"},
      );

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Cart Deleted", backgroundColor: Colors.green);
        getCart();
      } else {
        Get.snackbar(
          "Failed",
          "Failed to delete cart",
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
