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
