import 'package:a_group/plots/plots_repository/models/plot_model.dart';
import 'package:a_group/plots/views/current_facility/current_facility_details/map_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapPreviewWidget extends StatefulWidget {
  final Plot plot;

  const MapPreviewWidget({
    super.key,
    required this.plot,
  });

  @override
  State<MapPreviewWidget> createState() => _MapPreviewWidgetState();
}

class _MapPreviewWidgetState extends State<MapPreviewWidget> {
  YandexMapController? _controller;
  // Location? get _getLocation => widget.facility.location;

  @override
  void dispose() {
    _controller?.deselectGeoObject();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final ytheme = context.ytheme;
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.only(top: 16.0),
        height: 232.0,
        color: const Color(0xFF0D0D0D),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
              child: Text(
                'На карте',
                style: GoogleFonts.manrope(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => _showDialog(context),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ColoredBox(
                    color: Colors.black.withOpacity(0.8),
                    child: Image.network(
                      'https://static-maps.yandex.ru/1.x/?l=map&pt=${widget.plot.location?.longitude ?? 0},${widget.plot.location?.latitude ?? 0},pm2dgm&z=17&size=425,232&l=map,sat',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      color: Colors.transparent,
                      colorBlendMode: BlendMode.darken,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showDialog(BuildContext context) async {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (_) => MapDialogWidget(plot: widget.plot),
    );
  }
}
