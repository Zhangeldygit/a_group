import 'package:a_group/plots/plots_repository/models/plot_model.dart';
import 'package:a_group/plots/views/current_facility/current_facility_details/description.dart';
import 'package:a_group/plots/views/current_facility/current_facility_details/map_preview.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CurrentFacilityDetails extends StatelessWidget {
  final Plot plot;

  const CurrentFacilityDetails({
    super.key,
    required this.plot,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgets = [];

    const dividerWidget = Divider(
      height: 0.0,
      thickness: 0.5,
      // indent: indent,
      // endIndent: indent,
      color: Colors.grey,
    );

    widgets
      ..add(dividerWidget)
      ..add(Description(description: plot.description))
      ..add(dividerWidget)
      ..add(Divisibility(plot: plot))
      ..add(dividerWidget)
      ..add(MapPreviewWidget(plot: plot));

    return Material(
      color: Colors.transparent,
      elevation: 2.0,
      child: Container(
        color: const Color(0xFF0D0D0D),
        padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        child: Column(children: widgets),
      ),
    );
  }
}

class Divisibility extends StatelessWidget {
  const Divisibility({super.key, required this.plot});
  final Plot plot;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0, top: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Text(
                    'Делимость',
                    style: GoogleFonts.manrope(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  plot.divisibility ?? '',
                  maxLines: 3,
                  style: GoogleFonts.manrope(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
