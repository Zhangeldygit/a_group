import 'package:a_group/plots/plots_repository/models/plot_model.dart';
import 'package:a_group/plots/views/current_facility/header_address.dart';
import 'package:a_group/plots/views/current_facility/header_images.dart';
import 'package:a_group/plots/views/current_facility/header_info.dart';
import 'package:a_group/plots/views/current_facility/header_user_actions.dart';
import 'package:flutter/material.dart';

class CurrentFacilityHeader extends StatelessWidget {
  const CurrentFacilityHeader({super.key, required this.plot});
  final Plot plot;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(
          child: HeaderImages(
            plot: plot,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: const BoxDecoration(
            color: Color(0xFF0D0D0D),
            border: Border(
              bottom: BorderSide(
                color: Color(0xFFDDDDDD),
                width: 0.5,
              ),
            ),
          ),
          child: Column(
            children: [
              HeaderAddress(plot: plot),
              HeaderInfo(plot: plot),
              HeaderUserActions(plot: plot),
            ],
          ),
        )
      ],
    );
  }
}
