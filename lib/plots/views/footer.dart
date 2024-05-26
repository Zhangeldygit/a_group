import 'package:a_group/plots/plots_repository/models/plot_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Footer extends StatelessWidget {
  final Plot plot;
  const Footer({super.key, required this.plot});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12.0, left: 16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Container(
                  height: 16,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFC32B),
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                  child: Align(
                    alignment: AlignmentDirectional.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      child: Text(
                        '2/2024',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.manrope(fontSize: 10, fontWeight: FontWeight.w400, color: const Color(0xFFFFFFFF), height: 0.9),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Container(
                  height: 16,
                  decoration: BoxDecoration(
                    color: const Color(0xFF30DB5B),
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                  child: Align(
                    alignment: AlignmentDirectional.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                      child: Text(
                        'Сдан',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.manrope(fontSize: 10, fontWeight: FontWeight.w400, color: Color(0xFFFFFFFF), height: 0.9),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 16,
                decoration: BoxDecoration(
                  color: const Color(0xFFDA8FFF),
                  borderRadius: BorderRadius.circular(2.0),
                ),
                child: Align(
                  alignment: AlignmentDirectional.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                    child: Text(
                      'ДКП',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.manrope(fontSize: 10, fontWeight: FontWeight.w400, color: Color(0xFFFFFFFF), height: 0.9),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
