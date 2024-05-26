// Flutter imports:
import 'package:a_group/components/colors.dart';
import 'package:a_group/plots/plots_repository/models/plot_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

// Project imports:;

class MapDialogWidget extends StatefulWidget {
  final Plot plot;

  const MapDialogWidget({
    super.key,
    required this.plot,
  });

  @override
  State<MapDialogWidget> createState() => _MapDialogWidgetState();
}

class _MapDialogWidgetState extends State<MapDialogWidget> {
  YandexMapController? mapController;

  // Future<UserLocationView> onUserLocationAdded(UserLocationView view) async {
  //   return view.copyWith(
  //     pin: view.pin.copyWith(
  //       opacity: 1.0,
  //       zIndex: 100,
  //       icon: PlacemarkIcon.single(
  //         PlacemarkIconStyle(
  //           isFlat: true,
  //           scale: 0.4,
  //           zIndex: 100,
  //           image: BitmapDescriptor.fromAssetImage('lib/assets/icons/map_pin3.png'),
  //         ),
  //       ),
  //     ),
  //     arrow: view.arrow.copyWith(
  //       isVisible: false,
  //     ),
  //     accuracyCircle: view.accuracyCircle.copyWith(
  //       strokeWidth: 0,
  //       fillColor: Colors.transparent,
  //     ),
  //   );
  // }

  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          AppBar(
            title: Text(
              widget.plot.name ?? '',
              style: GoogleFonts.manrope(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            shadowColor: Colors.transparent,
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: AppColors.backgroundColor,
              ),
              child: YandexMap(
                // onUserLocationAdded: onUserLocationAdded,
                onMapCreated: (yandexMapController) async {
                  mapController = yandexMapController;

                  mapController?.toggleUserLayer(
                    visible: true,
                    headingEnabled: false,
                  );

                  final point = Point(
                    latitude: widget.plot.location?.latitude ?? 0,
                    longitude: widget.plot.location?.longitude ?? 0,
                  );
                  await mapController?.moveCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(target: point, zoom: 16),
                    ),
                    animation: const MapAnimation(
                      type: MapAnimationType.linear,
                      duration: 0.5,
                    ),
                  );
                },
                mapObjects: [
                  ClusterizedPlacemarkCollection(
                    // onClusterAdded: (_, cluster) async {
                    //   return cluster.copyWith(
                    //     appearance: cluster.appearance.copyWith(
                    //       opacity: 1,
                    //       icon: PlacemarkIcon.single(
                    //         PlacemarkIconStyle(
                    //           image: BitmapDescriptor.fromAssetImage('lib/assets/icons/circle.png'),
                    //           scale: 0.2,
                    //         ),
                    //       ),
                    //     ),
                    //   );
                    // },
                    mapId: const MapObjectId('clusterizedPlacemarkCollection'),
                    placemarks: [
                      PlacemarkMapObject(
                        mapId: const MapObjectId('clusterizedPlacemarkCollection'),
                        onTap: (mapObject, _) => {},
                        consumeTapEvents: true,
                        opacity: 1,
                        icon: PlacemarkIcon.single(
                          PlacemarkIconStyle(
                            image: BitmapDescriptor.fromAssetImage('lib/assets/icons/gps.png'),
                            scale: 0.2,
                            isFlat: true,
                          ),
                        ),
                        point: Point(
                          latitude: widget.plot.location?.latitude ?? 0,
                          longitude: widget.plot.location?.longitude ?? 0,
                        ),
                      )
                    ],
                    radius: 30,
                    minZoom: 19,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
