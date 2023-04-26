import 'package:expense_tracker/model/conversation_model.dart';
import 'package:expense_tracker/providers/message_provider.dart';
import 'package:expense_tracker/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';

class MessageHomeScreen extends StatefulWidget {
  const MessageHomeScreen({super.key});

  @override
  State<MessageHomeScreen> createState() => _MessageHomeScreenState();
}

class _MessageHomeScreenState extends State<MessageHomeScreen> {
  @override
  void initState() {
    SocketService().createSocketConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final message = context.read<MessageProvider>();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
                height: size.height * 0.3,
                width: size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/background.png'),
                    fit: BoxFit.cover,
                  ),
                  color: AppColors.mainColor,
                ),
                child: Text(
                  'Messages',
                  style: GoogleFonts.poppins(
                    color: AppColors.background,
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),
              ),
              Positioned(
                top: 140,
                child: Container(
                  width: size.width,
                  height: size.height,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35),
                    ),
                  ),
                  // child: FutureBuilder<ConversationModel>(
                  //   future: message.getConversations(),
                  //   builder: (context, snapshot) {
                  //     if (snapshot.hasData) {
                  //       return ListView.builder(
                  //         padding: const EdgeInsets.symmetric(
                  //           horizontal: 10,
                  //           vertical: 20,
                  //         ),
                  //         itemCount: 5,
                  //         itemBuilder: (context, index) {
                  //           return messageCard();
                  //         },
                  //       );
                  //     } else {
                  //       return const Center(
                  //         child: CircularProgressIndicator(
                  //           valueColor: AlwaysStoppedAnimation(AppColors.mainColor),
                  //         ),
                  //       );
                  //     }
                  //   },
                  // ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget messageCard() {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: AppColors.lghtblueColor,
        radius: 30,
        child: Text(
          'A',
          style: GoogleFonts.poppins(
            color: AppColors.blueColor,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      title: Text(
        'Alex Osho',
        style: GoogleFonts.poppins(
          color: AppColors.mainColor,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        'Lorem ipsum dolor sit amet?',
        style: GoogleFonts.poppins(
          color: AppColors.mainColor,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      ),
      trailing: Column(
        children: [
          Text(
            '12:00',
            style: GoogleFonts.poppins(
              color: AppColors.blueColor,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            width: 16,
            height: 16,
            decoration: const BoxDecoration(
              color: AppColors.blueColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '1',
                style: GoogleFonts.poppins(
                  color: AppColors.background,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
