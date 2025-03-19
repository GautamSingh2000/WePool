import 'package:flutter/material.dart';
import 'package:wepool/utils/colors.dart';

class GlobalOutlineEditText extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool obscureText;

  const GlobalOutlineEditText({
    super.key,
    required this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.obscureText = false,
  });

  @override
  State<GlobalOutlineEditText> createState() => _GlobalOutlineEditTextState();
}

class _GlobalOutlineEditTextState extends State<GlobalOutlineEditText> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: _obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.backgroundGray01,

        // Borders
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.borderGray01),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),

        hintText: widget.hintText,
        hintMaxLines: 1,
        hintStyle: TextStyle(fontSize: 14, color: AppColors.hintGray, fontWeight: FontWeight.w400),

        // Show visibility icon only if the keyboard type is password
        suffixIcon: widget.keyboardType == TextInputType.visiblePassword
            ? IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: AppColors.iconGray01,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText; // Toggle visibility
            });
          },
        )
            : null, // No icon for non-password fields
      ),
      validator: widget.validator,
    );
  }
}
