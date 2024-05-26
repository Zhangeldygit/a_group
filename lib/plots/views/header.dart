import 'package:a_group/plots/plots_repository/models/plot_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends StatelessWidget {
  final Plot plot;
  const Header({super.key, required this.plot});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 2.0, left: 16),
                child: Text(plot.name ?? '',
                    // name.maybeHandleOverflow(
                    //   maxChars: 30,
                    //   replacement: '…',
                    // ),
                    maxLines: 1,
                    style: GoogleFonts.manrope(fontSize: 16, fontWeight: FontWeight.w500, color: const Color(0xFF393939))),
              ),
            ),
          ],
        ),
        // if (facility.district != null)
        Padding(
          padding: const EdgeInsets.only(bottom: 4.0, left: 16),
          child: Text(
            plot.district ?? '',
            // '${facility.district?.name}'.maybeHandleOverflow(
            //   maxChars: 30,
            //   replacement: '…',
            // ),
            maxLines: 1,
            style: GoogleFonts.manrope(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: const Color(0xFFC0C0C0),
            ),
            // const TextStyle(
            //   fontFamily: "Manrope",
            //   fontSize: 11,
            //   fontWeight: FontWeight.w400,
            //   color: Color(0xFFC0C0C0),
            // ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 4.0, left: 16),
          child: Text('${plot.price} тг',
              style: GoogleFonts.manrope(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF393939),
              )
              // const TextStyle(
              //   fontFamily: "Manrope",
              //   fontSize: 16,
              //   fontWeight: FontWeight.w500,
              //   color: Color(0xFF393939),
              // ),
              ),
        )
      ],
    );
  }
}
