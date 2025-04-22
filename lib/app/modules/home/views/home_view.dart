import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

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
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.green.shade800,
              Colors.green.shade500,
              Colors.teal.shade300,
            ],
          ),
        ),
        child: Center(
          child: Stack(
            children: [
              // Lukisan hexagon latar
              Positioned.fill(
                child: CustomPaint(painter: HexagonBackgroundPainter()),
              ),

              // Konten utama
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'As-Library',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
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
                    const SizedBox(height: 8),
                    Text(
                      'Aplikasi Perpustakaan Digital',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                    const SizedBox(height: 300),
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: Lottie.network(
                        'https://lottie.host/132abfce-757b-4136-b131-2ace5cc2304c/X4NlILeIz0.json',
                        repeat: true,
                        fit: BoxFit.contain,
                        delegates: LottieDelegates(
                          values: [
                            ValueDelegate.color(const [
                              '**',
                            ], value: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
