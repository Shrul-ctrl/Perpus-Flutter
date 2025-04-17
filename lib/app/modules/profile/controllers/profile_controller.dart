import 'package:as_lib/app/data/profile_response.dart';
import 'package:as_lib/app/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  final box = GetStorage();
  final _getConnect = GetConnect();
  final token = GetStorage().read('token');

  var profile = Profiles().obs;

  Future<Profiles> getProfile() async {
    try {
      final response = await _getConnect.get(
        BaseUrl.profile,
        headers: {'Authorization': "Bearer $token"},
      );

      if (response.statusCode == 200) {
        var profileResponse = ProfileResponse.fromJson(response.body);
        profile.value = profileResponse.profiles ?? Profiles();
        return profile.value;
      } else {
        throw Exception("Failed to load profile");
      }
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }

    void logout() {
    box.remove('token');
    Get.offAllNamed('/login');
  }

  // void logout() async {
  //   final response = await _getConnect.post(
  //     BaseUrl.logout,
  //     {},
  //     headers: {'Authorization': "Bearer $token"},
  //     contentType: "application/json",
  //   );

  //   if (response.statusCode == 200) {
  //     Get.snackbar("Success", "Logout Success",
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Colors.green,
  //       colorText: Colors.white,
  //     );
  //     GetStorage().erase();
  //     Get.offAllNamed('/login');
  //   } else {
  //     Get.snackbar("Failed", "Logout Failed",
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //     );
  //   }
  // }
}
