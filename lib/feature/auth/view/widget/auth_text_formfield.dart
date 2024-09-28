import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import '../../../../core/theme/color/app_color.dart';

class AuthTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String? Function(String?)? validator;
  final bool obscureText;
  final IconData prefixIcon;
  final bool showPasswordToggle;
  final TextInputType textInputType;

  const AuthTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.textInputType = TextInputType.text,
    this.validator,
    this.obscureText = false,
    required this.prefixIcon,
    this.showPasswordToggle = false,
  });

  @override
  createState() => _AuthTextFormFieldState();
}

class _AuthTextFormFieldState extends State<AuthTextFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: const TextStyle(
            color: AppColor.secondary,
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.textInputType,
          validator: widget.validator,
          obscureText: widget.obscureText && _obscureText,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColor.textfield,
            prefixIcon: Icon(widget.prefixIcon),
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 16.0,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                color: AppColor.primary,
                width: 1.0,
              ),
            ),
            suffixIcon: widget.obscureText && widget.showPasswordToggle
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: Icon(
                      _obscureText ? IconlyLight.hide : IconlyLight.show,
                      color: Colors.grey,
                    ),
                  )
                : null,
          ),
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 7)
      ],
    );
  }
}
