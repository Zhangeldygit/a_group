import 'package:flutter/material.dart';
import 'package:a_group/components/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class CreatePlotMapDialogWidget extends StatefulWidget {
  const CreatePlotMapDialogWidget({super.key});

  @override
  State<CreatePlotMapDialogWidget> createState() => _CreatePlotMapDialogWidgetState();
}

class _CreatePlotMapDialogWidgetState extends State<CreatePlotMapDialogWidget> {
  YandexMapController? mapController;
  ClusterizedPlacemarkCollection? placeMarkers;
  Point? point;
  String? addressName;

  // @override
  // void dispose() {
  //   mapController?.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          AppBar(
            title: Text(
              'На карте',
              style: GoogleFonts.manrope(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            shadowColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pop(context, [point, addressName]),
            ),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: AppColors.backgroundColor,
              ),
              child: YandexMap(
                // onUserLocationAdded: onUserLocationAdded,
                onMapTap: (mapPoint) {
                  point = mapPoint;
                  final result = YandexSearch.searchByPoint(point: point!, searchOptions: const SearchOptions());
                  result.then((searchResult) {
                    searchResult.$2.then((value) {
                      addressName = value.items?.first.name;
                    });
                  });
                  mapController?.moveCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(target: mapPoint, zoom: 16),
                    ),
                    animation: const MapAnimation(
                      type: MapAnimationType.linear,
                      duration: 0.5,
                    ),
                  );

                  placeMarkers = ClusterizedPlacemarkCollection(
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
                          latitude: mapPoint.latitude,
                          longitude: mapPoint.longitude,
                        ),
                      )
                    ],
                    radius: 30,
                    minZoom: 19,
                  );
                  setState(() {});
                },
                onMapCreated: (yandexMapController) async {
                  mapController = yandexMapController;

                  mapController?.toggleUserLayer(
                    visible: true,
                    headingEnabled: false,
                  );

                  const point = Point(
                    latitude: 43.3000,
                    longitude: 76.9800,
                  );
                  await mapController?.moveCamera(
                    CameraUpdate.newCameraPosition(
                      const CameraPosition(target: point, zoom: 8),
                    ),
                    animation: const MapAnimation(
                      type: MapAnimationType.linear,
                      duration: 0.5,
                    ),
                  );
                },
                mapObjects: placeMarkers?.placemarks ?? [],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
