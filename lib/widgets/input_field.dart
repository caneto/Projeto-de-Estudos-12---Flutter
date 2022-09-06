import 'package:flutter/material.dart';

class InputField extends StatelessWidget {

  final IconData? icon;
  final Color colorIcon;
  final String? hint;
  final Color hintColor;
  final Color borderSideColor;
  final Color styleColor;
  final bool? obscure;
  final TextEditingController? controller;

  InputField({this.icon, required this.colorIcon, this.hint, required this.hintColor, required this.borderSideColor, required this.styleColor, this.obscure, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        icon: Icon(icon, color: colorIcon),
        hintText: hint,
        hintStyle: TextStyle(color: hintColor),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: borderSideColor)
        ),
        contentPadding: EdgeInsets.only(
            left: 5,
            right: 30,
            bottom: 10,
            top: 20
        ),
        errorText: "",
      ),
      style: TextStyle(color: styleColor),
      obscureText: obscure!,
    );
  }
}
