import 'package:expense_tracker/constants/app_colors.dart';
import 'package:expense_tracker/screens/dashboard/approval/approval_home_screen.dart';
import 'package:expense_tracker/screens/dashboard/dashboard_screen.dart';
import 'package:expense_tracker/screens/dashboard/messages/message_home_screen.dart';
import 'package:expense_tracker/screens/dashboard/profile/profile_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../providers/profile_provider.dart';
import '../../providers/request_provider.dart';
import 'request/create_request_screen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _selectedIndex = 0;

  Widget currScreen = const DashboardScreen();

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  void initState() {
    Provider.of<ProfileProvider>(context, listen: false).getProfile();
    Provider.of<RequestProvider>(context, listen: false).getStuff();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.background,
            width: 5,
          ),
          shape: BoxShape.circle,
        ),
        child: FloatingActionButton(
          backgroundColor: AppColors.blueColor,
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateRequestScreen(),
            ),
          ),
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        shape: const CircularNotchedRectangle(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: const BoxDecoration(
            color: AppColors.mainColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  iconItems(
                    'home-2.svg',
                    'Home',
                    _selectedIndex == 0,
                    onPressed: () {
                      setState(() {
                        currScreen = const DashboardScreen();
                        _selectedIndex = 0;
                      });
                    },
                  ),
                  iconItems('message.svg', 'Message', _selectedIndex == 1, onPressed: () {
                    setState(() {
                      currScreen = const MessageHomeScreen();
                      _selectedIndex = 1;
                    });
                  }),
                ],
              ),
              Row(
                children: [
                  iconItems('approval.svg', 'Approval', _selectedIndex == 2,
                      onPressed: () {
                    setState(() {
                      currScreen = const ApprovalHomeScreen();
                      _selectedIndex = 2;
                    });
                  }),
                  iconItems('profile.svg', 'Profile', _selectedIndex == 3, onPressed: () {
                    setState(() {
                      currScreen = const ProfileHomeScreen();
                      _selectedIndex = 3;
                    });
                  }),
                ],
              )
            ],
          ),
        ),
      ),
      body: PageStorage(bucket: bucket, child: currScreen),
    );
  }

  Widget iconItems(String image, String text, bool active, {VoidCallback? onPressed}) {
    return MaterialButton(
      onPressed: onPressed,
      minWidth: 40,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/$image', color: (active) ? AppColors.blueColor : null),
          Text(
            text,
            style: GoogleFonts.openSans(color: Colors.white, fontWeight: FontWeight.w300),
          )
        ],
      ),
    );
  }
}
