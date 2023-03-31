// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/request_provider.dart';

class CustomDropdownButton extends StatefulWidget {
  final List<dynamic> items;
  final String type;

  const CustomDropdownButton({super.key, required this.items, required this.type});

  @override
  _CustomDropdownButtonState createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  late String _selectedItem;
  late List<DropdownMenuItem<String>> _dropDownMenuItems;

  @override
  void initState() {
    super.initState();
    // _selectedItem = (widget.type == 'category')
    //     ? widget.items.map((dynamic e) => e['_id']).toList()[0]
    //     : widget.items.map((dynamic e) => e['_id']).toList()[0];
    _dropDownMenuItems = widget.items
        .map((dynamic item) => DropdownMenuItem<String>(
              value: (widget.type == 'category') ? item['_id'] : item['_id'],
              child:
                  Text((widget.type == 'category') ? item['name'] : item['department']),
            ))
        .toList();
    _selectedItem = widget.items[0]['_id'];
  }

  @override
  Widget build(BuildContext context) {
    final req = context.read<RequestProvider>();
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.42,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          // color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey),
        ),
        child: DropdownButton<String>(
          value: _selectedItem,
          items: _dropDownMenuItems,
          underline: Container(
            height: 0,
            color: Colors.transparent,
          ),
          onChanged: (newValue) {
            setState(() {
              _selectedItem = newValue!;
              if (widget.type == 'category') {
                req.categor.text = _selectedItem;
              } else {
                req.departmen.text = _selectedItem;
              }
            });
          },
        ),
      ),
    );
  }
}
