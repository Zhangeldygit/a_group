import 'dart:async';

import 'package:a_group/plots/plots_repository/models/plot_model.dart';
import 'package:a_group/plots/views/current_facility/header_image.dart';
import 'package:flutter/material.dart';

class HeaderImages extends StatefulWidget {
  final Plot plot;

  const HeaderImages({
    super.key,
    required this.plot,
  });

  @override
  State<HeaderImages> createState() => _YHeaderImagesState();
}

class _YHeaderImagesState extends State<HeaderImages> {
  final StreamController<int> streamController = StreamController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        HeaderImage(
          // facilityId: widget.facility.id,
          images: widget.plot.images ?? [],
          streamController: streamController,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              )),
        ),
        // _HeaderSummary(
        //   facility: widget.facility,
        //   length: widget.images.length,
        //   streamController: streamController,
        // ),
      ],
    );
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }
}
