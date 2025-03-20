import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    LoginController controller = Get.put(LoginController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment:
                CrossAxisAlignment.start, // Membuat semua elemen rata kiri
            children: [
              // Judul "As-Lib" di tengah
              Column(
                mainAxisAlignment:
                    MainAxisAlignment
                        .center, // Untuk memastikan teks berada di tengah
                children: [
                  const SizedBox(height: 0), // Sesuaikan ketinggian di sini
                  Center(
                    child: Text(
                      'As-Lib',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 80,
                        color: const Color.fromARGB(255, 0, 0, 0),
                        letterSpacing: 7,
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
                ],
              ),

              const SizedBox(height: 20),

              // Judul Login (Rata Kiri)
              const Text(
                "Login",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.left, // Pastikan teks ini rata kiri
              ),
              const SizedBox(height: 8),

              // Subtitle (Rata Kiri)
              const Text(
                "Please sign in to continue.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.left, // Pastikan teks ini rata kiri
              ),
              const SizedBox(height: 20),

              // Input Username
              TextField(
                controller: controller.emailController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person_outline),
                  labelText: 'Username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Input Password
              TextField(
                controller: controller.passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock_outline),
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Tombol Login
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    controller.loginNow();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Sign In",
                    style: TextStyle(fontSize: 18, color: Colors.white),
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
