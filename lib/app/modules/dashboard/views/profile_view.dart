import 'package:as_lib/app/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:as_lib/app/data/profile_response.dart';
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
      body: FutureBuilder<Profiles>(
        future: controller.getProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Lottie.network(
                'https://lottie.host/132abfce-757b-4136-b131-2ace5cc2304c/X4NlILeIz0.json',
                width: 100,
                height: 100,
                repeat: true,
                delegates: LottieDelegates(
                  values: [
                    ValueDelegate.color(['**'], value: Colors.green),
                  ],
                ),
              ),
            );
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(
              child: Text("Gagal memuat data profil"),
            );
          }

          final profile = snapshot.data!;

          return Stack(
            children: [
              // Background hijau melengkung
              ClipPath(
                clipper: ProfileClipper(),
                child: Container(
                  height: 280,
                  color: const Color.fromARGB(255, 54, 138, 59),
                ),
              ),

              // Konten Profil
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
                              backgroundImage: profile.fotoprofile != null
                                  ? NetworkImage(
                                      '${BaseUrl.profilePath}/${profile.fotoprofile}',
                                    )
                                  : const AssetImage('assets/profile.jpg')
                                      as ImageProvider,
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
                    const Center(
                      child: Icon(Icons.keyboard_arrow_down, color: Colors.green),
                    ),

                    // Container info profil
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
                          buildProfileRow("NOMOR TELEPON", profile.siswa?.noHp ?? "-"),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // Widget untuk baris info profil
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
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

// Clipper untuk background melengkung atas
class ProfileClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
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
