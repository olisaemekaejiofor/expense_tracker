import 'package:expense_tracker/constants/app_colors.dart';
import 'package:expense_tracker/screens/authentication/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../providers/profile_provider.dart';

class ProfileHomeScreen extends StatefulWidget {
  const ProfileHomeScreen({super.key});

  @override
  State<ProfileHomeScreen> createState() => _ProfileHomeScreenState();
}

class _ProfileHomeScreenState extends State<ProfileHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final prof = Provider.of<ProfileProvider>(context);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: size.height * 0.425,
              width: size.width,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
              decoration: const BoxDecoration(
                color: AppColors.mainColor,
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Profile',
                      style: GoogleFonts.poppins(
                        color: AppColors.background,
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage('assets/profile-pic.png'),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        prof.profileModel!.fullName,
                        style: GoogleFonts.poppins(
                          color: AppColors.background,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        prof.profileModel!.email,
                        style: GoogleFonts.poppins(
                          color: AppColors.background,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                decoration: const BoxDecoration(
                  color: AppColors.background,
                ),
                child: Column(
                  children: [
                    listTiles('security', 'Change confirmation pin'),
                    const SizedBox(height: 20),
                    listTiles(
                      'logout',
                      'Logout',
                      color: AppColors.orangeColor,
                      onTap: () {
                        const storage = FlutterSecureStorage();
                        storage.deleteAll();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listTiles(String image, String text, {Color? color, VoidCallback? onTap}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      child: ListTile(
        onTap: onTap,
        visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color?.withOpacity(0.1) ?? AppColors.blueColor.withOpacity(0.1),
          ),
          child: Center(child: SvgPicture.asset('assets/$image.svg')),
        ),
        title: Text(
          text,
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: AppColors.greyColor,
          size: 16,
        ),
      ),
    );
  }
}
