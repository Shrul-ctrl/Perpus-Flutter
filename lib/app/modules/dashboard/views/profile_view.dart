import 'package:as_lib/app/modules/dashboard/views/koleksi_view.dart';
import 'package:as_lib/app/modules/dashboard/views/riwayat_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:as_lib/app/modules/profile/controllers/profile_controller.dart';

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
          return const Center(child: CircularProgressIndicator());
        }

        final profile = controller.profile.value;

        return Stack(
          children: [
            // Background Lengkung
            ClipPath(
              clipper: ProfileClipper(),
              child: Container(
                height: 280,
                color: const Color.fromARGB(255, 54, 138, 59),
              ),
            ),

            // Konten Profil
            Column(
              children: [
                const SizedBox(height: 60),

                // Foto Profil
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 45,
                          backgroundImage: AssetImage('assets/profile.jpg'),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        profile.name ?? "-", // Menampilkan nama pengguna
                        style: const TextStyle(
                          color:
                              Colors
                                  .white, // Warna teks putih agar kontras dengan background
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                // Dropdown Icon
                const SizedBox(height: 10),
                const Icon(Icons.keyboard_arrow_down, color: Colors.white),

                // Detail Profil
                Expanded(
                  child: Container(
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
                        // buildProfileRow("NAME", profile.name ?? "-"),
                        buildProfileRow("EMAIL", profile.email ?? "-"),
                        buildProfileRow(
                          "LOCATION",
                          profile.siswa?.alamat ?? "-",
                        ),
                        buildProfileRow(
                          "PHONE NUMBER",
                          profile.siswa?.noHp ?? "-",
                        ),
                        const SizedBox(height: 10),

                        // Icon Transportasi di Bawah
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Tombol Koleksi
                            Column(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.book,
                                    color: Colors.green,
                                    size: 32,
                                  ),
                                  onPressed: () {
                                    Get.to(
                                      () => KoleksiView(),
                                    ); // Navigasi ke halaman koleksi
                                  },
                                ),
                                const Text(
                                  "Koleksi",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),

                            // Tombol Riwayat
                            Column(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.history,
                                    color: Colors.green,
                                    size: 32,
                                  ),
                                  onPressed: () {
                                    Get.to(
                                      () => RiwayatView(),
                                    ); // Navigasi ke halaman riwayat
                                  },
                                ),
                                const Text(
                                  "Riwayat",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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
    path.lineTo(0, size.height - 100); // Lebih turun agar lebih melengkung
    path.quadraticBezierTo(
      size.width / 2, size.height + 10, // Lebih menonjolkan lengkungan
      size.width, size.height - 100,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
