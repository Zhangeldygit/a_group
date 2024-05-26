// import 'package:flutter/material.dart';

// class CurrentFacilityBottom extends StatelessWidget {
//   final Facility facility;
//   final User? user;
//   final VoidCallback onEdit;

//   const CurrentFacilityBottom({
//     super.key,
//     required this.facility,
//     required this.user,
//     required this.onEdit,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final ytheme = context.ytheme;

//     final isCreator = facility.creatorId == context.bloc<AuthManager>().state?.id;
//     final isDraft = facility.isDraft;
//     final isInReview = facility.isInReview;
//     final isComplex = facility.isComplex;

//     return Container(
//       decoration: BoxDecoration(
//         color: ytheme.menuBackground,
//         boxShadow: const [
//           BoxShadow(
//             blurRadius: 20.0,
//             color: Color(0x15000000),
//             offset: Offset(0.0, 2.0),
//           )
//         ],
//       ),
//       child: SafeArea(
//         child: Column(
//           children: [
//             if (isCreator && isDraft && !isInReview) YEditDraft(onEdit: onEdit),
//             if (!isComplex && !isCreator) const YContacts(),
//             if (isComplex && !isDraft) YChess(facility: facility, user: user),
//           ],
//         ),
//       ),
//     );
//   }
// }
