// ignore_for_file: use_build_context_synchronously

import 'package:expense_tracker/providers/request_provider.dart';
import 'package:expense_tracker/widgets/app_button.dart';
import 'package:expense_tracker/widgets/success_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';
import '../approval/request_details_screen.dart';

class ConfirmRequestScreen extends StatefulWidget {
  const ConfirmRequestScreen({super.key});

  @override
  State<ConfirmRequestScreen> createState() => _ConfirmRequestScreenState();
}

class _ConfirmRequestScreenState extends State<ConfirmRequestScreen> {
  @override
  Widget build(BuildContext context) {
    final req = context.read<RequestProvider>();
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: size.width,
                height: size.height * 0.15,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                  color: AppColors.blueColor,
                  image: DecorationImage(
                      image: AssetImage('assets/background.png'), fit: BoxFit.cover),
                ),
                child: Center(
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Request Details',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      listTile('Status', 'Pending'),
                      const Divider(height: 0),
                      listTile('Department', req.departmen.text),
                      const Divider(height: 0),
                      listTile('Category', req.categor.text),
                      const Divider(height: 0),
                      listTile('Amount', '₦ ${req.amount.text}'),
                      const Divider(),
                      listTile2('Description', req.desc.text),
                      const Divider(),
                      listTile2(
                        'Media',
                        '',
                        subtitleWidget: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.greyColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.image,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Screenshot.png',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Divider(),
                      listTile('Account Name', 'Eren Bosco'),
                      const Divider(height: 0),
                      listTile('Account Number', '1234567890'),
                      const Divider(height: 0),
                      listTile('Bank', 'Access Bank'),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: AppButton(
                          text: 'Edit',
                          width: 40,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          color: AppColors.blueColor,
                          textColor: Colors.white,
                          hasImage: true,
                          imagePath: 'assets/edit-2.svg',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Consumer<RequestProvider>(
                    builder: (context, value, _) {
                      return (value.requestState == RequestState.loading)
                          ? LoadingButton(
                              height: 55,
                              width: double.infinity,
                              color: const Color(0xff168D89),
                              textColor: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            )
                          : AppButton(
                              width: size.width,
                              height: 55,
                              text: 'Confirm Request',
                              onPressed: () async {
                                await value.createRequest();
                                if (value.requestState == RequestState.error) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(value.errorMessage),
                                    ),
                                  );
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SuccessScreen(),
                                    ),
                                  );
                                }
                              },
                              color: AppColors.blueColor,
                              textColor: Colors.white,
                            );
                      // : AppButton(
                      //     height: 55,
                      //     width: double.infinity,
                      //     borderRadius: BorderRadius.circular(10),
                      //     text: 'Log In',
                      //     onPressed: () async {
                      //       if (_formKey.currentState!.validate()) {
                      //         await value.login(email.text, password.text);
                      //         if (value.authState == AuthState.success) {
                      //           if (widget.app == 'requester') {
                      //             if (mounted) {
                      //               Navigator.pushReplacement(
                      //                 context,
                      //                 MaterialPageRoute(
                      //                   builder: (context) =>
                      //                       const RequesterBottomNavScreen(),
                      //                 ),
                      //               );
                      //             }
                      //           } else {
                      //             if (mounted) {
                      //               Navigator.pushReplacement(
                      //                 context,
                      //                 MaterialPageRoute(
                      //                   builder: (context) =>
                      //                       const BottomNavScreen(),
                      //                 ),
                      //               );
                      //             }
                      //           }
                      //         } else {
                      //           if (mounted) {
                      //             ScaffoldMessenger.of(context).showSnackBar(
                      //               SnackBar(
                      //                 content: Text(value.errorMessage),
                      //               ),
                      //             );
                      //           }
                      //         }
                      //       } else {
                      //         if (mounted) {
                      //           ScaffoldMessenger.of(context).showSnackBar(
                      //             const SnackBar(
                      //               content: Text('Please fill in all fields'),
                      //             ),
                      //           );
                      //         }
                      //       }
                      //     },
                      //     color: const Color(0xff168D89),
                      //     textColor: Colors.white,
                      //   );
                    },
                  )),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
