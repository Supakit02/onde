import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  final String text;
  var onPressed;
  double? width;
  TextStyle? style;
  ButtonCustom({
    Key? key,
    required this.text,
    required this.onPressed,
    this.width,
    this.style,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Container(
        width: width ?? MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color(0xFF021E65),
          border: Border.all(color: Color(0xFFE2EAFE)),
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextButton(
          child: Text(
            text,
            style: style,
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
