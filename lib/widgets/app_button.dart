import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final Color? borderColor;
  final double? width;
  final double? height;
  final bool? hasImage;
  final String? imagePath;
  final BorderRadius? borderRadius;
  const AppButton(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.color,
      required this.textColor,
      this.borderColor,
      this.width,
      this.height,
      this.hasImage = false,
      this.imagePath,
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: color,
      onPressed: onPressed,
      minWidth: width,
      height: height,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(30),
        side: BorderSide(color: borderColor ?? Colors.transparent),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: hasImage == true
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    imagePath!,
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    text,
                    style: GoogleFonts.poppins(color: textColor),
                  ),
                ],
              )
            : Text(
                text,
                style: GoogleFonts.poppins(color: textColor),
              ),
      ),
    );
  }
}

class LoadingButton extends StatelessWidget {
  final BorderRadius? borderRadius;
  final Color color;
  final double? width;
  final double? height;
  final Color? borderColor;
  final Color textColor;
  const LoadingButton({
    super.key,
    this.borderRadius,
    required this.color,
    this.width,
    this.height,
    this.borderColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: color,
      onPressed: () {},
      minWidth: width,
      height: height,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(30),
        side: BorderSide(color: borderColor ?? Colors.transparent),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(textColor),
        ),
      ),
    );
  }
}
