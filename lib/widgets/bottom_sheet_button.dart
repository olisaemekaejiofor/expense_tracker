// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class CustomBottomSheet extends StatefulWidget {
  final Widget child;
  const CustomBottomSheet({Key? key, required this.child}) : super(key: key);

  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, child: widget.child, // Add your content here
    );
  }
}
