import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:as_lib/app/modules/profile/controllers/profile_controller.dart';
import 'package:lottie/lottie.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: controller.logout,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: Lottie.network(
              'https://lottie.host/132abfce-757b-4136-b131-2ace5cc2304c/X4NlILeIz0.json',
              repeat: true,
              width: 100,
              height: 100,
              delegates: LottieDelegates(
                values: [
                  ValueDelegate.color(
                    const ['**'],
                    value: Colors.green,
                  ),
                ],
              ),
            ),
          );
        }

        final profile = controller.profile.value;

        return Stack(
          children: [
            // Background lengkung hijau
            ClipPath(
              clipper: ProfileClipper(),
              child: Container(
                height: 280,
                color: const Color.fromARGB(255, 54, 138, 59),
              ),
            ),

            // Konten
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),

                  // Foto profil dan nama
                  Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 45,
                            backgroundImage:
                                AssetImage('assets/profile.jpg'),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          profile.name ?? "-",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),
                  const Center(child: Icon(Icons.keyboard_arrow_down, color: Colors.green)),

                  // Container konten profil
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(top: 10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildProfileRow("EMAIL", profile.email ?? "-"),
                        buildProfileRow("ALAMAT", profile.siswa?.alamat ?? "-"),
                        buildProfileRow("NIS", profile.siswa?.nis ?? "-"),
                        buildProfileRow("KELAS", profile.siswa?.kelas ?? "-"),
                        buildProfileRow(
                          "NOMER TELEPON",
                          profile.siswa?.noHp ?? "-",
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget buildProfileRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class ProfileClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(
      size.width / 2,
      size.height + 10,
      size.width,
      size.height - 100,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
