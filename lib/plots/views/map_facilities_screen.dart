import 'package:a_group/components/clusterized_icon_painter.dart';
import 'package:a_group/plots/plots_repository/models/plot_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapFacilitiesScreen extends StatefulWidget {
  const MapFacilitiesScreen({super.key, required this.plots});
  final List<Plot> plots;

  @override
  State<MapFacilitiesScreen> createState() => _MapFacilitiesScreenState();
}

class _MapFacilitiesScreenState extends State<MapFacilitiesScreen> {
  late final YandexMapController _mapController;
  var _mapZoom = 0.0;

  @override
  void dispose() {
    _mapController.deselectGeoObject();
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'На карте',
          style: GoogleFonts.manrope(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: YandexMap(
        onMapCreated: (controller) async {
          _mapController = controller;
          await _mapController.moveCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: Point(
                  latitude: widget.plots.first.location?.latitude == 0 ? 43.238949 : widget.plots.first.location?.latitude ?? 43.238949,
                  longitude: widget.plots.first.location?.longitude == 0 ? 76.889709 : widget.plots.first.location?.longitude ?? 76.889709,
                ),
                zoom: 15,
              ),
            ),
          );
        },
        onCameraPositionChanged: (cameraPosition, _, __) {
          setState(() {
            _mapZoom = cameraPosition.zoom;
          });
        },
        mapObjects: [
          _getClusterizedCollection(
            placemarks: _getPlacemarkObjects(context),
          ),
        ],
      ),
    );
  }

  ClusterizedPlacemarkCollection _getClusterizedCollection({
    required List<PlacemarkMapObject> placemarks,
  }) {
    return ClusterizedPlacemarkCollection(
        mapId: const MapObjectId('clusterized-1'),
        placemarks: placemarks,
        radius: 50,
        minZoom: 15,
        onClusterAdded: (self, cluster) async {
          return cluster.copyWith(
            appearance: cluster.appearance.copyWith(
              opacity: 1.0,
              icon: PlacemarkIcon.single(
                PlacemarkIconStyle(
                  image: BitmapDescriptor.fromBytes(
                    await ClusterIconPainter(cluster.size).getClusterIconBytes(),
                  ),
                ),
              ),
            ),
          );
        },
        onClusterTap: (self, cluster) async {
          await _mapController.moveCamera(
            animation: const MapAnimation(type: MapAnimationType.linear, duration: 0.3),
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: cluster.placemarks.first.point,
                zoom: _mapZoom + 1,
              ),
            ),
          );
        });
  }

  List<PlacemarkMapObject> _getPlacemarkObjects(BuildContext context) {
    return widget.plots
        .map(
          (point) => PlacemarkMapObject(
            mapId: MapObjectId('MapObject ${point.id}'),
            point: Point(latitude: point.location?.latitude ?? 43.238949, longitude: point.location?.longitude ?? 76.889709),
            opacity: 1,
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(
                image: BitmapDescriptor.fromAssetImage(
                  'lib/assets/icons/gps.png',
                ),
                scale: 0.2,
                isFlat: true,
              ),
            ),
          ),
        )
        .toList();
  }
}
