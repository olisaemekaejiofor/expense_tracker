import 'package:expense_tracker/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => const MaterialPage(
        child: SplashScreen(),
      ),
    ),
    // GoRoute(
    //   path: '/login',
    //   name: 'login',
    //   pageBuilder: (context, state) => const MaterialPage(
    //     child: LoginScreen(),
    //   ),
    // ),
  ],
);
