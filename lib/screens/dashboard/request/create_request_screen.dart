import 'package:dotted_border/dotted_border.dart';
import 'package:expense_tracker/providers/request_provider.dart';
import 'package:expense_tracker/screens/dashboard/request/confirm_request_screen.dart';
import 'package:expense_tracker/widgets/app_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';
import '../../../widgets/drop_down_button.dart';

class CreateRequestScreen extends StatefulWidget {
  const CreateRequestScreen({super.key});

  @override
  State<CreateRequestScreen> createState() => _CreateRequestScreenState();
}

class _CreateRequestScreenState extends State<CreateRequestScreen> {
  @override
  Widget build(BuildContext context) {
    final request = context.read<RequestProvider>();
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                      'Make Request',
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
            Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: 100,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                color: AppColors.blueColor.withOpacity(0.1),
              ),
              child: Center(
                child: Text(
                  'Request 1',
                  style: GoogleFonts.poppins(
                    color: const Color(0xff000303),
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomDropdownButton(
                            items: request.department,
                            type: 'department',
                          ),
                          CustomDropdownButton(
                            items: request.category,
                            type: 'category',
                          ),
                          // dropDownButton('Department', request.department),
                          // dropDownButton('Category', request.category),
                        ],
                      ),
                      const SizedBox(height: 5),
                      textfield('Title', request.title),
                      const SizedBox(height: 5),
                      textfield('Amount', request.amount),
                      const SizedBox(height: 10),
                      largeTextField('Description', request.desc),
                      const SizedBox(height: 10),
                      dottedContainer(),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: AppButton(
                text: 'Send Request',
                width: size.width,
                height: 55,
                onPressed: () {
                  if (request.title.text == '' ||
                      request.departmen.text == '' ||
                      request.amount.text == '' ||
                      request.categor.text == '' ||
                      request.desc.text == '') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please fill in all fields'),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ConfirmRequestScreen(),
                      ),
                    );
                  }
                },
                color: AppColors.blueColor,
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget textfield(String text, TextEditingController con) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.background,
        border: Border.all(color: Colors.grey),
      ),
      child: TextField(
        controller: con,
        decoration: InputDecoration(
          hintText: text,
          hintStyle: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget largeTextField(String text, TextEditingController con) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.background,
            border: Border.all(color: Colors.grey),
          ),
          child: TextField(
            controller: con,
            maxLines: 5,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget dottedContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Media',
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 2),
        GestureDetector(
          onTap: () async {
            var p = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['pdf', 'png'],
            );
            setState(() {
              context.read<RequestProvider>().media.text = p!.files.single.path!;
            });
          },
          child: DottedBorder(
            color: Colors.grey,
            strokeWidth: 1.5,
            dashPattern: const [5, 5],
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.image,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    (context.read<RequestProvider>().media.text != '')
                        ? context.read<RequestProvider>().media.text.split('\\').last
                        : 'Add Media',
                    style: GoogleFonts.poppins(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
