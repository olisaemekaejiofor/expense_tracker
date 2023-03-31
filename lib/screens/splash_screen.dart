// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:expense_tracker/screens/authentication/login_screen.dart';
import 'package:expense_tracker/screens/dashboard/bottom_navigation.dart';
import 'package:expense_tracker/screens/dashboard/requester_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _storage = const FlutterSecureStorage();

  void navigate() async {
    var token = await _storage.read(key: 'token');
    var role = await _storage.read(key: 'role');

    if (token != null) {
      if (role == 'approver') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const BottomNavScreen(),
          ),
        );
      } else if (role == 'requester') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const RequesterBottomNavScreen(),
          ),
        );
      }
    } else {
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      navigate();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Image.asset(
            'assets/logo.png',
            height: 150,
          ),
        ),
      ),
    );
  }
}
