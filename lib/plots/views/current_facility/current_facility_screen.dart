import 'package:a_group/plots/plots_repository/models/plot_model.dart';
import 'package:a_group/plots/views/current_facility/current_facility_details/current_facility_details.dart';
import 'package:a_group/plots/views/current_facility/current_facility_header.dart';
import 'package:flutter/material.dart';

class CurrentFacilityScreen extends StatelessWidget {
  const CurrentFacilityScreen({super.key, required this.plot});
  final Plot plot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CurrentFacilityHeader(
                    plot: plot,
                    // user: user,
                    // onClose: () => _handleClose(widget.facility.type),
                    // onEdit: () => _handleEdit(widget.facility),
                  ),
                  CurrentFacilityDetails(plot: plot)
                ],
              ),
            ),
          ),
          // CurrentFacilityBottom(
          //   facility: facility ?? widget.facility,
          //   user: user,
          //   onEdit: () => _handleEdit(widget.facility),
          // ),
        ],
      ),
    );
  }
}
