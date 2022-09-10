import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final Function onSubmit;
  final Widget? icon;
  final Widget? perfixIcon;
  final Color? fillColor;
  final TextInputType? inputType;
  final String? label;
  final String? hint;
  final Color? hintColor;
  final bool? secureText;
  final double? radius;
  final TextEditingController? controller;
  final double? height;
  final double? verticalMargin;
  final bool? readOnly;
  final double? hintSize;
  final bool? enabledBorder;
  final Color? borderColor;

  const CustomTextField({
    Key? key,
    required this.onSubmit,
    this.fillColor,
    this.hintColor,
    this.icon,
    this.perfixIcon,
    this.inputType,
    this.label,
    this.hint,
    this.secureText,
    this.controller,
    this.radius,
    this.height,
    this.verticalMargin,
    this.readOnly,
    this.hintSize,
    this.enabledBorder = false,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(vertical: verticalMargin ?? 10),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 10),
        border: enabledBorder! ? Border.all(color: borderColor!) : null,
      ),
      child: TextFormField(
        controller: controller != null ? controller : null,
        readOnly: readOnly ?? false,
        style: TextStyle(color: hintColor ?? Colors.white),
        obscureText: secureText ?? false,
        cursorColor: Theme.of(context).primaryColor,
        keyboardType: inputType ?? TextInputType.text,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius ?? 10),
                borderSide: BorderSide.none),
            errorStyle: const TextStyle(fontSize: 10.0),
            errorMaxLines: 2,
            contentPadding: const EdgeInsets.only(
                right: 20.0, top: 10.0, bottom: 10.0, left: 20),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius ?? 10),
                borderSide: BorderSide.none),
            filled: true,
            fillColor: fillColor ?? Colors.grey[50],
            prefixIcon: perfixIcon ?? null,
            prefixIconConstraints:
                const BoxConstraints(maxHeight: 40, maxWidth: 40),
            suffixIcon: icon ?? null,
            suffixIconConstraints:
                const BoxConstraints(maxHeight: 40, maxWidth: 40),
            labelText: label,
            labelStyle: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.015,
                color: Theme.of(context).primaryColor),
            hintStyle: TextStyle(
              fontSize: hintSize ?? MediaQuery.of(context).size.height * 0.02,
              color: hintColor ?? Colors.white,
              fontFamily: 'Poppins',
            ),
            hintText: hint),
        onFieldSubmitted: (String value) {
          return onSubmit(value);
        },
      ),
    );
  }
}
