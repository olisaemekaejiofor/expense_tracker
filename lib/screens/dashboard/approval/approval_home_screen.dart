import 'package:expense_tracker/model/request_model.dart';
import 'package:expense_tracker/providers/request_provider.dart';
import 'package:expense_tracker/screens/dashboard/approval/request_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';

class ApprovalHomeScreen extends StatefulWidget {
  const ApprovalHomeScreen({super.key});

  @override
  State<ApprovalHomeScreen> createState() => _ApprovalHomeScreenState();
}

class _ApprovalHomeScreenState extends State<ApprovalHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final requestProvider = Provider.of<RequestProvider>(context);
    requestProvider.getRequests();
    final Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(20, 55, 20, 0),
                height: size.height * 0.15,
                width: size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/background.png'),
                    fit: BoxFit.cover,
                  ),
                  color: AppColors.mainColor,
                ),
                child: Text(
                  'Approval',
                  style: GoogleFonts.poppins(
                    color: AppColors.background,
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    height: 55,
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      // boxShadow: const <BoxShadow>[
                      //   BoxShadow(
                      //     color: AppColors.greyColor,
                      //     blurRadius: .5,
                      //     offset: Offset(0.0, 0.15),
                      //   )
                      // ],
                    ),
                    child: TabBar(
                      indicator: BoxDecoration(
                        color: AppColors.blueColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      unselectedLabelColor: const Color(0xff7C8181),
                      labelStyle: GoogleFonts.poppins(
                        fontSize: 12,
                      ),
                      tabs: const [
                        Tab(text: 'All'),
                        Tab(text: 'Approved'),
                        Tab(text: 'Declined'),
                        Tab(text: 'Pending')
                      ],
                    ),
                  )
                ],
              ),
              FutureBuilder<RequestModel>(
                  future: requestProvider.getRequests(),
                  builder: (context, value) {
                    if (value.hasData) {
                      return Expanded(
                        child: TabBarView(
                          children: [
                            ListView(
                              children: List.generate(
                                value.data!.data.length,
                                (index) => approvalCards(
                                  value.data!.data.reversed.toList()[index],
                                ),
                              ),
                            ),
                            ListView(
                              children: List.generate(
                                value.data!.data
                                    .where((element) => element.status == 'Approved')
                                    .toList()
                                    .length,
                                (index) {
                                  List<Datum> approved = value.data!.data
                                      .where((element) => element.status == 'Approved')
                                      .toList()
                                      .reversed
                                      .toList();
                                  return approvalCards(
                                    approved[index],
                                  );
                                },
                              ),
                            ),
                            ListView(
                              children: List.generate(
                                value.data!.data
                                    .where((element) => element.status == 'Declined')
                                    .toList()
                                    .length,
                                (index) {
                                  List<Datum> declined = value.data!.data
                                      .where((element) => element.status == 'Declined')
                                      .toList()
                                      .reversed
                                      .toList();
                                  return approvalCards(
                                    declined[index],
                                  );
                                },
                              ),
                            ),
                            ListView(
                              children: List.generate(
                                value.data!.data
                                    .where((element) => element.status == 'Pending')
                                    .toList()
                                    .length,
                                (index) {
                                  List<Datum> pending = value.data!.data
                                      .where((element) => element.status == 'Pending')
                                      .toList()
                                      .reversed
                                      .toList();
                                  return approvalCards(
                                    pending[index],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const Expanded(
                        child: TabBarView(
                          children: [
                            Center(child: CircularProgressIndicator()),
                            Center(child: CircularProgressIndicator()),
                            Center(child: CircularProgressIndicator()),
                            Center(child: CircularProgressIndicator()),
                          ],
                        ),
                      );
                    }
                  }),
              
            ],
          ),
        ),
      ),
    );
  }

  Widget approvalCards(Datum data) {
    return Container(
      height: 100,
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data.status!.toUpperCase(),
                style: GoogleFonts.poppins(
                  color: (data.status! == 'Declined')
                      ? Colors.red
                      : (data.status! == 'Pending')
                          ? Colors.yellow[600]
                          : AppColors.blueColor,
                  fontSize: 12,
                ),
              ),
              Text(
                DateFormat.yMMMMEEEEd().format(data.createdAt!),
                style: GoogleFonts.poppins(
                  color: const Color(0xff7C8181),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 200,
                child: Text(
                  '${data.title!}: ${data.description!}',
                  style: GoogleFonts.poppins(
                    color: const Color(0xff000303),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    height: 1,
                  ),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RequestDetailsScreen(
                        data: data,
                      ),
                    ),
                  );
                },
                color: AppColors.blueColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'View details',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
