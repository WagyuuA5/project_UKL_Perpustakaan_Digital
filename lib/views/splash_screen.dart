import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {

  late AnimationController logoController;
  late Animation<double> fadeLogo;
  late Animation<double> scaleLogo;

  late AnimationController textController;
  late Animation<double> fadeText;
  late Animation<Offset> slideText;

  @override
  void initState() {
    super.initState();

    // ANIMASI LOGO
    logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    fadeLogo = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: logoController, curve: Curves.easeOut),
    );

    scaleLogo = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: logoController, curve: Curves.easeOutBack),
    );

    logoController.forward();

    // ANIMASI TEKS
    textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    fadeText = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: textController, curve: Curves.easeOut),
    );

    slideText = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: textController, curve: Curves.easeOut),
    );

    Future.delayed(const Duration(milliseconds: 900), () {
      if (mounted) textController.forward();
    });

    // PINDAH HALAMAN SETELAH 3 DETIK
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  void dispose() {
    logoController.dispose();
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const bluePrimary = Color(0xFF133C8A);
    const bgSoft = Color(0xFFF5FAFF);

    return Scaffold(
      backgroundColor: bgSoft,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // LOGO ANIMASI
            AnimatedBuilder(
              animation: logoController,
              builder: (_, __) {
                return Opacity(
                  opacity: fadeLogo.value,
                  child: Transform.scale(
                    scale: scaleLogo.value,
                    child: SizedBox(
                      width: 220,
                      height: 220,
                      child: Image.asset(
                        'assets/images/Logo_1.png',
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.image_not_supported,
                          size: 120,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 25),

            // TEKS ANIMASI
            AnimatedBuilder(
              animation: textController,
              builder: (_, __) {
                return Opacity(
                  opacity: fadeText.value,
                  child: Transform.translate(
                    offset: slideText.value * 20,
                    child: Column(
                      children: const [
                        Text(
                          "SmartLibrary",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            color: bluePrimary,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Perpustakaan Digital Modern",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 35),

            const CircularProgressIndicator(
              color: bluePrimary,
              strokeWidth: 3,
            ),
          ],
        ),
      ),
    );
  }
}
