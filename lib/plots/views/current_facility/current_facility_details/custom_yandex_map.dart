// import 'package:a_group/components/colors.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:yandex_mapkit/yandex_mapkit.dart';

// class MapFacilityMarker {
//   final List<GeoPoint> facilities;
//   final Function(ClusterizedPlacemarkCollection, Cluster)? onClusterTap;
//   final Function(PlacemarkMapObject, Point)? onTap;

//   const MapFacilityMarker(
//     this.facilities, {
//     this.onClusterTap,
//     this.onTap,
//   });
// }

// class CustomYandexMap extends StatefulWidget {
//   final GeoPoint? initialLocation;
//   final Function(Point)? onMapTap;
//   final MapFacilityMarker? markers;
//   final bool nightModeEnable;
//   final bool showNavigator;
//   final MapFacilitiesCubit? mapFacilitiesCubit;
//   final Function? onFacilitiesTap;

//   const CustomYandexMap({
//     super.key,
//     this.initialLocation,
//     this.markers,
//     this.onMapTap,
//     this.nightModeEnable = false,
//     this.showNavigator = false,
//     this.mapFacilitiesCubit,
//     this.onFacilitiesTap,
//   });

//   @override
//   State<StatefulWidget> createState() => _CustomYandexMapState();
// }

// class _CustomYandexMapState extends State<CustomYandexMap> {
//   late final CustomYandexMapModel _model;

//   @override
//   void initState() {
//     super.initState();
//     _model = createModel(context, CustomYandexMapModel.new);

//     _loadFaciltiies();
//   }

//   Future<void> _loadFaciltiies() async {
//     if (widget.initialLocation != null) {
//       final facilities = widget.markers?.facilities ?? [];
//       setState(() {
//         _model
//           ..placemarks = _addPlacemarks(facilities)
//           ..clusterMarkers = _addMarkersOnMap(facilities);
//       });
//       return;
//     }
//     if (widget.mapFacilitiesCubit != null) {
//       widget.mapFacilitiesCubit!.stream.listen((state) {
//         if (state is MapFacilitiesLoadedState) {
//           final facilities = state.facilities ?? [];
//           _model
//             ..placemarks = _addPlacemarks(facilities)
//             ..clusterMarkers = _addMarkersOnMap(facilities);

//           setState(() {});
//           _model.calculateCameraPosition(facilities: facilities);
//         }
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         YandexMap(
//           onMapTap: _onMapTap,
//           nightModeEnabled: widget.nightModeEnable,
//           onUserLocationAdded: _model.onUserLocationAdded,
//           onMapCreated: (yandexMapController) async {
//             _model.mapController = yandexMapController;
//             await _toogleUserLocationOnMap();
//             if (widget.initialLocation != null) {
//               _model
//                 ..zoom = 16
//                 ..calculateCameraPosition(initialLocation: widget.initialLocation);
//             }
//           },
//           fastTapEnabled: true,
//           mapObjects: _model.clusterMarkers,
//         ),
//         Positioned(
//           top: (context.height - kToolbarHeight - 80) / 2,
//           right: 10,
//           child: CustomYandexMapButtons(
//             zoomIn: _model.zoomIn,
//             zoomOut: _model.zoomOut,
//             moveToUserPosition: _model.moveToUserPosition,
//           ),
//         ),
//         if (widget.showNavigator) _showNavigatorButton,
//       ],
//     );
//   }

//   List<PlacemarkMapObject> _addPlacemarks(List<GeoPoint> facilities) {
//     return facilities
//         .where((e) => e.location != null)
//         .map(
//           (facility) => PlacemarkMapObject(
//             mapId: MapObjectId(facility.id),
//             onTap: (mapObject, _) => _onPlacemarkTap(mapObject, facilities),
//             consumeTapEvents: true,
//             opacity: 1,
//             icon: YMapMixin.defaultIcon,
//             point: Point(
//               latitude: facility.latitude,
//               longitude: facility.longitude,
//             ),
//           ),
//         )
//         .toList();
//   }

//   List<MapObject<dynamic>> _addMarkersOnMap(List<GeoPoint> facilities) {
//     return facilities.isNotEmpty
//         ? [
//             ClusterizedPlacemarkCollection(
//               onClusterTap: (_, cluster) => _onClusterTap(cluster: cluster, facilities: facilities),
//               onClusterAdded: (_, cluster) async {
//                 return cluster.copyWith(
//                   appearance: cluster.appearance.copyWith(
//                     opacity: 1,
//                     icon: PlacemarkIcon.single(
//                       PlacemarkIconStyle(
//                         image: await _model.setMapIconImage(context, cluster.placemarks.length),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//               mapId: const MapObjectId('clusterizedPlacemarkCollection'),
//               minZoom: 19,
//               radius: 30,
//               placemarks: _model.placemarks.toSet().toList(),
//             ),
//           ]
//         : const [];
//   }

//   Future<void> _toogleUserLocationOnMap() async {
//     final isLocationGranted = await Permission.location.request();
//     if (isLocationGranted != PermissionStatus.granted) {
//       return;
//     }

//     await _model.mapController?.toggleUserLayer(
//       visible: true,
//       headingEnabled: false,
//     );
//   }

//   void _onMapTap(Point point) {
//     widget.onMapTap?.call(point);
//     if (_model.selectedMarker != null) {
//       final markerIndex = _model.placemarks.indexWhere((element) => element.mapId == _model.selectedMarker);
//       _model.placemarks[markerIndex] = _model.placemarks[markerIndex].copyWith(icon: YMapMixin.defaultIcon);
//       _model.selectedMarker = null;
//       setState(() {});
//     }
//   }

//   Widget get _showNavigatorButton {
//     return Positioned(
//       left: 0,
//       right: 0,
//       bottom: 0,
//       child: SafeArea(
//         child: YButton(
//           padding: YSpaces.p16,
//           onPressed: () => _onShowNavigatorBottomSheet(context),
//           title: 'В навигатор',
//         ),
//       ),
//     );
//   }

//   void _onShowNavigatorBottomSheet(BuildContext context) {
//     final latitude = widget.initialLocation?.latitude ?? 0;
//     final longitude = widget.initialLocation?.longitude ?? 0;

//     showModalBottomSheet(
//       context: context,
//       useRootNavigator: true,
//       showDragHandle: true,
//       backgroundColor: AppColors.backgroundColor,
//       shape: RoundedRectangleBorder(borderRadius: YDecoration.brBottomSheet),
//       builder: (_) => CustomMapDialogNavigator(
//         latitude: latitude,
//         longitude: longitude,
//       ),
//     );
//   }

//   void _onPlacemarkTap(PlacemarkMapObject mapObject, List<GeoPoint> facilities) {
//     if (widget.onFacilitiesTap != null) {
//       final selected = facilities.firstWhere((e) => e.id == mapObject.mapId.value);
//       widget.onFacilitiesTap?.call([selected]);
//     }
//     if (_model.selectedMarker != mapObject.mapId) {
//       if (_model.selectedMarker != null) {
//         final markerIndex = _model.placemarks.indexWhere((element) => element.mapId == _model.selectedMarker);
//         _model.placemarks[markerIndex] = _model.placemarks[markerIndex].copyWith(icon: YMapMixin.defaultIcon);
//       }
//       final markerIndex = _model.placemarks.indexWhere((element) => element.mapId == mapObject.mapId);
//       _model.placemarks[markerIndex] = _model.placemarks[markerIndex].copyWith(icon: YMapMixin.selectedIcon);
//       _model.selectedMarker = mapObject.mapId;
//       setState(() {});
//     }
//   }

//   Future<void> _onClusterTap({required Cluster cluster, List<MapFacility> facilities = const []}) async {
//     _model.zoom = (await _model.mapController?.getCameraPosition())?.zoom ?? _model.zoom;
//     if (cluster.placemarks.length > 40 && _model.zoom < 14) {
//       _model.zoom += 1;
//       _model.mapController?.moveCamera(
//         CameraUpdate.newCameraPosition(
//           CameraPosition(
//             target: cluster.appearance.point,
//             zoom: _model.zoom,
//           ),
//         ),
//         animation: const MapAnimation(
//           type: MapAnimationType.linear,
//           duration: 0.15,
//         ),
//       );
//       return;
//     }
//     if (widget.onFacilitiesTap != null) {
//       final selectedFacilities = cluster.placemarks.map((e) => facilities.firstWhere((f) => f.id == e.mapId.value)).toList();
//       widget.onFacilitiesTap?.call(selectedFacilities);
//     }
//   }

//   @override
//   void dispose() {
//     _model.dispose();
//     super.dispose();
//   }
// }
