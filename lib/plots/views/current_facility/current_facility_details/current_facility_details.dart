import 'package:a_group/plots/plots_repository/models/plot_model.dart';
import 'package:a_group/plots/views/current_facility/current_facility_details/description.dart';
import 'package:a_group/plots/views/current_facility/current_facility_details/map_preview.dart';
import 'package:flutter/material.dart';

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
      // ..add(Payments(plot: plot))
      // ..add(dividerWidget)
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
