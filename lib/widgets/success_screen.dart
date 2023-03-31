import 'package:expense_tracker/screens/dashboard/bottom_navigation.dart';
import 'package:expense_tracker/screens/dashboard/requester_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../constants/app_colors.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  void f() async {
    const storage = FlutterSecureStorage();
    String? role = await storage.read(key: 'role');
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => (role == 'requester')
              ? const RequesterBottomNavScreen()
              : const BottomNavScreen(),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 85, child: LottieBuilder.asset('assets/check.json')),
            const SizedBox(height: 10),
            Text(
              'Request sent',
              style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff000303)),
            ),
          ],
        ),
      ),
    );
  }
}
