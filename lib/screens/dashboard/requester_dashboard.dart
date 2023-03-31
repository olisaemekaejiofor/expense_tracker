import 'package:expense_tracker/providers/request_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../constants/app_colors.dart';
import '../../model/request_model.dart';
import '../../providers/profile_provider.dart';
import 'approval/request_details_screen.dart';

class RequesterDashBoard extends StatefulWidget {
  const RequesterDashBoard({super.key});

  @override
  State<RequesterDashBoard> createState() => _RequesterDashBoardState();
}

class _RequesterDashBoardState extends State<RequesterDashBoard> {
  @override
  Widget build(BuildContext context) {
    final prof = context.read<ProfileProvider>();
    final req = context.read<RequestProvider>();
    final Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 55, 20, 0),
                    margin: EdgeInsets.fromLTRB(0, 0, 0, size.height * 0.03),
                    height: size.height * 0.22,
                    width: size.width,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/background.png'),
                        fit: BoxFit.cover,
                      ),
                      color: AppColors.mainColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi, Welcome',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          prof.profileModel?.fullName ?? 'Loading...',
                          style: GoogleFonts.poppins(
                            color: AppColors.background,
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 55,
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
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
                      labelStyle: GoogleFonts.poppins(),
                      tabs: const [
                        Tab(text: 'All'),
                        Tab(text: 'Approved'),
                        Tab(text: 'Denied'),
                      ],
                    ),
                  ),
                ],
              ),
              FutureBuilder<RequestModel>(
                future: req.getSpecificRequest(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: TabBarView(
                        children: [
                          ListView(
                              children:
                                  List.generate(snapshot.data!.data.length, (index) {
                            return activityCards(
                              snapshot.data!.data.reversed.toList()[index],
                            );
                          })),
                          ListView(
                              children: List.generate(
                                  snapshot.data!.data
                                      .where((element) => element.status == 'Approved')
                                      .toList()
                                      .length, (index) {
                            List<Datum> approved = snapshot.data!.data
                                .where((element) => element.status == 'Approved')
                                .toList()
                                .reversed
                                .toList();
                            return activityCards(approved[index]);
                          })),
                          ListView(
                              children: List.generate(
                                  snapshot.data!.data
                                      .where((element) => element.status == 'Declined')
                                      .toList()
                                      .length, (index) {
                            List<Datum> declined = snapshot.data!.data
                                .where((element) => element.status == 'Declined')
                                .toList()
                                .reversed
                                .toList();
                            return activityCards(declined[index]);
                          })),
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
                        ],
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget activityCards(Datum data) {
    return Container(
      height: 120,
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  text: '${data.title}\n',
                  style: GoogleFonts.poppins(
                    color: const Color(0xff000303),
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  children: [
                    TextSpan(
                      text: '₦ ${data.amount}',
                      style: GoogleFonts.poppins(
                        color: const Color(0xff000303),
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              ),
              Text(
                '${data.status}',
                style: GoogleFonts.poppins(
                  color: AppColors.blueColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat.yMMMEd().format(data.createdAt!),
                style: GoogleFonts.poppins(
                  color: const Color(0xff7C8181),
                  fontSize: 12,
                ),
              ),
              MaterialButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RequestDetailsScreen(
                      data: data,
                    ),
                  ),
                ),
                color: AppColors.blueColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
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
