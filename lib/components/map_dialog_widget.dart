// import 'package:flutter/material.dart';

// class MapDialogWidget extends StatelessWidget {
//   final Facility facility;

//   const MapDialogWidget({
//     super.key,
//     required this.facility,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final ytheme = context.ytheme;

//     return SafeArea(
//       bottom: false,
//       child: Column(
//         children: [
//           YAppBar(
//             title: facility.name.capitalizeAllSentence,
//             shadowColor: Colors.transparent,
//           ),
//           Expanded(
//             child: Container(
//               width: context.width,
//               decoration: BoxDecoration(
//                 color: ytheme.menuBackground,
//               ),
//               child: CustomYandexMap(
//                 initialLocation: facility.location,
//                 nightModeEnable: context.darkMode,
//                 showNavigator: true,
//                 markers: MapFacilityMarker(
//                   [
//                     MapFacility(
//                       id: facility.id,
//                       location: facility.location,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
