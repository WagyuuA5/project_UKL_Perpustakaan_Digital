

import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/RegisterScreen.dart';
// import 'package:flutter_application_1/views/profile_view.dart';
import 'theme/app_theme.dart';
import 'views/splash_screen.dart';
import 'views/login_view.dart';
import 'views/home_view.dart';
// import 'views/LinimasaView.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SmartLibraryApp());
}

class SmartLibraryApp extends StatelessWidget {
  const SmartLibraryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartLibrary',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(),
      initialRoute: '/',
      routes: {
        '/': (_) => const SplashScreen(),
        '/login': (_) => const LoginView(),
         '/register': (_) => const RegisterScreen(),
        '/home': (_) => const HomeView(),

        // '/linimasa': (context) => const LinimasaView(),
        // '/profil': (context) => const ProfileView(),
      },
    );
  }
}
