import 'package:expense_tracker/constants/app_colors.dart';
import 'package:expense_tracker/providers/auth_provider.dart';
import 'package:expense_tracker/screens/dashboard/bottom_navigation.dart';
import 'package:expense_tracker/screens/dashboard/requester_bottom_navigation.dart';
import 'package:expense_tracker/widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../widgets/app_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.25,
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 20,
              ),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Welcome Back',
                    style: GoogleFonts.raleway(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Kindly put in your details to log into your account',
                    style: GoogleFonts.raleway(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.7),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              )),
          Form(
            key: _formKey,
            child: Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    AuthField(
                      text: 'Email Address',
                      controller: email,
                      isPassword: false,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Email cannot be empty';
                        } else if (!val.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    AuthField(
                      text: 'Password',
                      controller: password,
                      isPassword: true,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Password cannot be empty';
                        } else if (val.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 40),
                    Consumer<AuthProvider>(
                      builder: (context, value, _) {
                        return (value.authState == AuthState.loading)
                            ? LoadingButton(
                                height: 55,
                                width: double.infinity,
                                color: const Color(0xff168D89),
                                textColor: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              )
                            : AppButton(
                                height: 55,
                                width: double.infinity,
                                borderRadius: BorderRadius.circular(10),
                                text: 'Log In',
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    await value.login(email.text, password.text);
                                    if (value.authState == AuthState.success) {
                                      if (value.role == 'requester') {
                                        if (mounted) {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const RequesterBottomNavScreen(),
                                            ),
                                          );
                                        }
                                      } else {
                                        if (mounted) {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const BottomNavScreen(),
                                            ),
                                          );
                                        }
                                      }
                                    } else {
                                      if (mounted) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(value.errorMessage),
                                          ),
                                        );
                                      }
                                    }
                                  } else {
                                    if (mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Please fill in all fields'),
                                        ),
                                      );
                                    }
                                  }
                                },
                                color: const Color(0xff168D89),
                                textColor: Colors.white,
                              );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 150),
        ],
      ),
    );
  }
}
