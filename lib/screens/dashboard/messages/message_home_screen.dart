import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/app_colors.dart';

class MessageHomeScreen extends StatefulWidget {
  const MessageHomeScreen({super.key});

  @override
  State<MessageHomeScreen> createState() => _MessageHomeScreenState();
}

class _MessageHomeScreenState extends State<MessageHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
                height: size.height * 0.3,
                width: size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/background.png'),
                    fit: BoxFit.cover,
                  ),
                  color: AppColors.mainColor,
                ),
                child: Text(
                  'Messages',
                  style: GoogleFonts.poppins(
                    color: AppColors.background,
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),
              ),
              Positioned(
                top: 140,
                child: Container(
                  width: size.width,
                  height: size.height,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35),
                    ),
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
