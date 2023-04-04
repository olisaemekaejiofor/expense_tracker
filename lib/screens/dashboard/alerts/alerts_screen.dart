import 'package:expense_tracker/constants/app_colors.dart';
import 'package:expense_tracker/model/notification_model.dart';
import 'package:expense_tracker/providers/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../widgets/bottom_sheet_button.dart';

class AlertScreen extends StatefulWidget {
  const AlertScreen({super.key});

  @override
  State<AlertScreen> createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  void showCustomBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return CustomBottomSheet(
          child: Container(
            color: Colors.white,
            child: const Center(
              child: Text('This is a custom bottom sheet'),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final notification = context.read<NotificationProvider>();
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
              child: FutureBuilder<NotificationModel>(
                future: notification.getNotifications(),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.data.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: alertCards(
                              data: snapshot.data!.data[index],
                              onTap: () {
                                // showCustomBottomSheet(context);
                              }),
                        );
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget alertCards({Datum? data, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 85,
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.greyColor, width: 0.5),
        ),
        child: Center(
          child: ListTile(
            leading: (data!.title == 'Requistion')
                ? const CircleAvatar(
                    backgroundColor: Color(0xffDFA606),
                    radius: 30,
                    child: Icon(Icons.message, color: Colors.white),
                  )
                : (data.title == 'Requisition Status Update' &&
                        data.message!.split(' ')[6] == 'declined')
                    ? const CircleAvatar(
                        backgroundColor: Color(0xffCC6951),
                        radius: 30,
                        child: Icon(Icons.cancel, color: Colors.white),
                      )
                    : const CircleAvatar(
                        backgroundColor: AppColors.blueColor,
                        radius: 30,
                        child: Icon(Icons.check, color: Colors.white),
                      ),
            title: Text(
              data.title!,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              data.message!,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.greyColor,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
