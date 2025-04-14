import 'package:as_lib/app/data/profile_response.dart';
import 'package:as_lib/app/utils/api.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  final box = GetStorage();
  final _getConnect = GetConnect();
  final token = GetStorage().read('token');
  final isLoading = false.obs;

  // Variabel untuk menyimpan profil
  var profile = Profiles().obs;

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  Future<void> getProfile() async {
    try {
      isLoading(true);
      final response = await _getConnect.get(
        BaseUrl.profile,
        headers: {'Authorization': "Bearer $token"},
      );

      if (response.statusCode == 200) {
        var profileResponse = ProfileResponse.fromJson(response.body);
        profile.value = profileResponse.profiles ?? Profiles();
      }
    } catch (e) {
      print("Error fetching profile: $e");
    } finally {
      isLoading(false);
    }
  }

  void logout() {
    box.remove('token');
    Get.offAllNamed('/login');
  }
}
