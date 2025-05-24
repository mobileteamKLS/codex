import 'package:flutter/material.dart';

class CustomText extends StatefulWidget {
  final String text;
  final Color fontColor;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final TextDecoration textDecoration;
  final int? maxLine;

  const CustomText(
      {super.key,
        required this.text,
        required this.fontColor,
        required this.fontSize,
        required this.fontWeight,
        required this.textAlign,
        this.textDecoration = TextDecoration.none,
        this.maxLine = 3});

  @override
  State<CustomText> createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {
  @override
  Widget build(BuildContext context) {
    return Text(
        maxLines: widget.maxLine,
        widget.text,
        textAlign: widget.textAlign,
        style: TextStyle(
            fontSize: widget.fontSize,
            color: widget.fontColor,
            fontWeight: widget.fontWeight,
            decoration: widget.textDecoration,
            decorationColor: widget.fontColor));
  }
}