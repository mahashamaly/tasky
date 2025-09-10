import 'package:flutter/material.dart';

class CustomTextFormFaild extends StatelessWidget {
  CustomTextFormFaild({
    super.key,
    required this.controller,
    this.maxLines,
    required this.hintText,
    this.validator,
    required this.title,
  });
  final TextEditingController controller;
  final int? maxLines;
  final String hintText;
  final Function(String?)? validator;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
         title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xffFFFCFC),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          style: TextStyle(color: Colors.white),

          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xff6D6D6D),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),

            filled: true,
            fillColor: Color(0xff282828),
          ),
          validator: validator != null
              ? (String? value) => validator!(value)
              : null,
        ),
      ],
    );
  }
}
