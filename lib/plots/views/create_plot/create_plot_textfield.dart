import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreatePlotTextField extends StatefulWidget {
  const CreatePlotTextField({super.key, required this.controller, required this.hintText, required this.keyboardType, required this.enabled, this.onChanged});
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final bool enabled;
  final void Function(String)? onChanged;

  @override
  State<CreatePlotTextField> createState() => _CreatePlotTextFieldState();
}

class _CreatePlotTextFieldState extends State<CreatePlotTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      style: GoogleFonts.poppins(color: Colors.white),
      keyboardType: widget.keyboardType,
      enabled: widget.enabled,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF5C5C5C)),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF5C5C5C)),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF5C5C5C)),
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: widget.hintText,
        labelStyle: GoogleFonts.poppins(color: Colors.white),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
