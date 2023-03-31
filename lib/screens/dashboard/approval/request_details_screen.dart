import 'package:expense_tracker/constants/app_colors.dart';
import 'package:expense_tracker/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../model/request_model.dart';

class RequestDetailsScreen extends StatefulWidget {
  final Datum? data;
  const RequestDetailsScreen({super.key, this.data});

  @override
  State<RequestDetailsScreen> createState() => _RequestDetailsScreenState();
}

class _RequestDetailsScreenState extends State<RequestDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
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
            Expanded(
              child: Padding(
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
                    children: [
                      listTile('Status', widget.data!.status!),
                      const Divider(height: 0),
                      listTile(
                          'Department', widget.data!.department?.department! ?? 'nil'),
                      const Divider(height: 0),
                      listTile('Category', 'nil'),
                      const Divider(height: 0),
                      listTile('Amount', '₦ ${widget.data!.amount}'),
                      const Divider(),
                      listTile2('Description', widget.data!.description!),
                      const Divider(),
                      listTile2(
                        'Media',
                        '',
                        subtitleWidget: (widget.data!.media == null)
                            ? null
                            : InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Image.network(widget.data!.media!),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 2),
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
                      ),
                      const Divider(),
                      listTile(
                          'Account Name',
                          (widget.data!.userAccount == null)
                              ? ''
                              : widget.data!.userAccount!.accountName!),
                      const Divider(height: 0),
                      listTile(
                          'Account Number',
                          (widget.data!.userAccount == null)
                              ? ''
                              : widget.data!.userAccount!.accountNumber!),
                      const Divider(height: 0),
                      listTile(
                          'Bank',
                          (widget.data!.userAccount == null)
                              ? ''
                              : widget.data!.userAccount!.bankName!),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 100)
          ],
        ),
      ),
    );
  }
}

class PendingRequestScreen extends StatefulWidget {
  final Datum? data;
  const PendingRequestScreen({super.key, this.data});

  @override
  State<PendingRequestScreen> createState() => _PendingRequestScreenState();
}

class _PendingRequestScreenState extends State<PendingRequestScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: size.width,
                height: size.height * 0.12,
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
              const SizedBox(height: 10),
              Image.asset('assets/profile-pic.png', height: 100),
              const SizedBox(height: 5),
              Text(
                'Mary Jane',
                style: GoogleFonts.poppins(
                  color: AppColors.blueColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: size.width * 0.4,
                child: AppButton(
                  text: 'Message',
                  onPressed: () {},
                  color: AppColors.blueColor,
                  textColor: Colors.white,
                  hasImage: true,
                  imagePath: 'assets/message.svg',
                  width: size.width * 0.4,
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
                    children: [
                      listTile('Status', 'Pending'),
                      const Divider(height: 0),
                      listTile(
                          'Department', widget.data!.department?.department! ?? 'nil'),
                      const Divider(height: 0),
                      listTile('Category', 'nil'),
                      const Divider(height: 0),
                      listTile('Amount', '₦ ${widget.data!.amount}'),
                      const Divider(),
                      listTile2('Description', widget.data!.description!),
                      const Divider(),
                      listTile2(
                        'Media',
                        '',
                        subtitleWidget: (widget.data!.media == null)
                            ? null
                            : InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Image.network(widget.data!.media!),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 2),
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
                      ),
                      const Divider(),
                      listTile(
                          'Account Name',
                          (widget.data!.userAccount == null)
                              ? ''
                              : widget.data!.userAccount!.accountName!),
                      const Divider(height: 0),
                      listTile(
                          'Account Number',
                          (widget.data!.userAccount == null)
                              ? ''
                              : widget.data!.userAccount!.accountNumber!),
                      const Divider(height: 0),
                      listTile(
                          'Bank',
                          (widget.data!.userAccount == null)
                              ? ''
                              : widget.data!.userAccount!.bankName!),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppButton(
                      text: 'Decline',
                      onPressed: () {},
                      width: size.width * 0.4,
                      height: 50,
                      color: AppColors.background,
                      textColor: const Color(0xff000303),
                      borderColor: AppColors.greyColor,
                    ),
                    AppButton(
                      text: 'Approve',
                      width: size.width * 0.4,
                      height: 50,
                      onPressed: () {},
                      color: AppColors.blueColor,
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}

Widget listTile(String title, String subtitle) {
  return ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
    visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
    leading: Text(
      title,
      style: GoogleFonts.poppins(
        color: AppColors.greyColor,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),
    trailing: Text(
      subtitle,
      style: GoogleFonts.poppins(
        color: const Color(0xff000303),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

Widget listTile2(String title, String subtitle, {Widget? subtitleWidget}) {
  return ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
    visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
    title: Text(
      title,
      style: GoogleFonts.poppins(
        color: AppColors.greyColor,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),
    subtitle: subtitleWidget ??
        Text(
          subtitle,
          style: GoogleFonts.poppins(
            color: const Color(0xff000303),
            fontSize: 13,
            fontWeight: FontWeight.w500,
            height: 1.3,
          ),
        ),
  );
}
