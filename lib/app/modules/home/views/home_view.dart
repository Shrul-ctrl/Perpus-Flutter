import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.green.shade900, // Hijau gelap di atas
              Colors.green.shade600, // Hijau agak terang di tengah
              Colors.green.shade400, // Hijau terang di bawah
            ],
          ),
          border: Border.all(
            color: Colors.black,
            width: 5,
          ), // Garis hitam di tepi
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.7), // Efek hitam di sudut
              blurRadius: 50,
              spreadRadius: 10,
              offset: Offset(-20, -20), // Efek sudut kiri atas
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.7),
              blurRadius: 50,
              spreadRadius: 10,
              offset: Offset(20, 20), // Efek sudut kanan bawah
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'As-Lib',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                    color: Colors.white,
                    letterSpacing: 2,
                    shadows: [
                      Shadow(
                        blurRadius: 10,
                        color: Colors.black54,
                        offset: Offset(3, 3),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5), // Mengurangi jarak antar teks
              Text(
                'Aplikasi Perpustakaan Digital',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white70,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
