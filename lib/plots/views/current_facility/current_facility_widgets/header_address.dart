import 'package:a_group/plots/plots_repository/models/plot_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderAddress extends StatelessWidget {
  final Plot plot;

  const HeaderAddress({
    super.key,
    required this.plot,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  plot.name ?? '',
                  style: GoogleFonts.manrope(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Material(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: InkWell(
                child: Container(
                  width: 38.0,
                  height: 38.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFFBEFB50),
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(
                      color: const Color(0xFFBEFB50),
                      width: 0.5,
                    ),
                  ),
                  child: const Icon(Icons.gesture_outlined),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // Future<void> _showDialog(BuildContext context) async {
  //   return showDialog(
  //     barrierColor: Color(0xFF181818),
  //     useSafeArea: false,
  //     context: context,
  //     builder: (_) => MapDialogWidget(facility: facility),
  //   );
  // }
}
