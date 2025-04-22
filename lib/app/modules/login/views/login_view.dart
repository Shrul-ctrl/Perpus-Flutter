import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Stack(
                    children: [
                      // Gradient background
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.green.shade900,
                              Colors.green.shade500,
                              Colors.teal.shade800,
                            ],
                          ),
                        ),
                      ),

                      // Hexagon background
                      CustomPaint(
                        size: Size.infinite,
                        painter: HexagonBackgroundPainter(),
                      ),

                      // ✅ Main Column UI
                      // ganti bagian dalam Column
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "As-Library",
                            style: GoogleFonts.poppins(
                              fontSize: 80,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Perpustakaan Digital",
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 40),

                          // ✅ Container Login jadi satu & setengah layar
                          Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.5,
                            margin: const EdgeInsets.symmetric(horizontal: 24),
                            padding: EdgeInsets.only(
                              top: 20,
                              left: 20,
                              right: 20,
                              bottom:
                                  MediaQuery.of(context).viewInsets.bottom + 20,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        "Masuk ke akun Anda",
                                        style: GoogleFonts.poppins(
                                          fontSize: 22,
                                          color: Colors.grey.shade800,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      const Divider(
                                        thickness: 4,
                                        indent: 100,
                                        endIndent: 100,
                                        color: Colors.green,
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 20),

                                // Email
                                // Email
                                Material(
                                  elevation: 3,
                                  shadowColor: Colors.black12,
                                  borderRadius: BorderRadius.circular(12),
                                  child: TextField(
                                    controller: controller.emailController,
                                    decoration: InputDecoration(
                                      labelText: 'Email',
                                      labelStyle: TextStyle(
                                        color: Colors.green.shade800,
                                      ),
                                      prefixIcon: Icon(
                                        Icons.email_outlined,
                                        color: Colors.green.shade800,
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.green.shade700,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    cursorColor: Colors.green.shade800,
                                  ),
                                ),

                                const SizedBox(height: 15),

                                // Password
                                Material(
                                  elevation: 3,
                                  shadowColor: Colors.black12,
                                  borderRadius: BorderRadius.circular(12),
                                  child: TextField(
                                    controller: controller.passwordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      labelStyle: TextStyle(
                                        color: Colors.green.shade800,
                                      ),
                                      prefixIcon: Icon(
                                        Icons.lock_outline,
                                        color: Colors.green.shade800,
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.green.shade700,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    cursorColor: Colors.green.shade800,
                                  ),
                                ),

                                const SizedBox(height: 24),

                                // Tombol Login (diubah jaraknya, jangan pakai Spacer)
                                SizedBox(
                                  width: double.infinity,
                                  height: 45,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      controller.loginNow();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green.shade600,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text(
                                      "LOGIN",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Painter untuk latar belakang hexagon
class HexagonBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white.withOpacity(0.06)
          ..style = PaintingStyle.stroke;

    const double radius = 40.0;
    final double hexHeight = radius * 2;
    final double hexWidth = sqrt(3) * radius;

    for (double y = 0; y < size.height + hexHeight; y += hexHeight * 0.75) {
      for (double x = 0; x < size.width + hexWidth; x += hexWidth) {
        final offsetX = ((y ~/ (hexHeight * 0.75)) % 2 == 0) ? 0 : hexWidth / 2;
        final center = Offset(x + offsetX, y);

        final path = Path();
        for (int i = 0; i < 6; i++) {
          final angle = (pi / 180) * (60 * i - 30);
          final dx = center.dx + radius * cos(angle);
          final dy = center.dy + radius * sin(angle);
          if (i == 0) {
            path.moveTo(dx, dy);
          } else {
            path.lineTo(dx, dy);
          }
        }
        path.close();
        canvas.drawPath(path, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
