import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';

class AuthField extends StatefulWidget {
  final String text;
  final TextEditingController controller;
  final bool isPassword;
  final String? Function(String?)? validator;
  const AuthField({
    super.key,
    required this.text,
    required this.controller,
    required this.isPassword,
    this.validator,
  });

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  bool show = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: TextFormField(
            controller: widget.controller,
            obscureText: widget.isPassword ? !show : false,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: AppColors.greyColor,
                ),
              ),
              suffix: (widget.isPassword == true)
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          show = !show;
                        });
                      },
                      child: const Icon(
                        Icons.remove_red_eye,
                        color: Colors.grey,
                      ),
                    )
                  : null,
            ),
            validator: widget.validator,
          ),
        ),
      ],
    );
  }
}

class NormalTextFeild extends StatefulWidget {
  final TextEditingController controller;
  const NormalTextFeild({Key? key, required this.controller}) : super(key: key);

  @override
  State<NormalTextFeild> createState() => _NormalTextFeildState();
}

class _NormalTextFeildState extends State<NormalTextFeild> {
  bool validate = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: validate == true
              ? const BorderSide(color: Colors.red, width: 1)
              : BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          gapPadding: 0,
          borderRadius: BorderRadius.circular(10),
          borderSide: widget.controller.text.isEmpty
              ? BorderSide.none
              : const BorderSide(color: AppColors.greyColor, width: 1),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
        // icon: const Icon(Icons.calendar_today),
        fillColor: AppColors.greyColor,
        filled: true,
        hintText: 'Type your message here',
        // hintStyle: style(FontWeight.w600, 16, textColorGrey),
        contentPadding: const EdgeInsets.only(top: 5, left: 10),
      ),
      // style: style(FontWeight.w600, 17, textColorBlack),
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter a date for your task";
        }
        return null;
      },
    );
  }
}
