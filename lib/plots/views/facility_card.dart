import 'package:a_group/plots/plots_repository/models/plot_model.dart';
import 'package:a_group/plots/views/current_facility/current_facility_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class FacilityCard extends StatelessWidget {
  final Plot plot;
  const FacilityCard({super.key, required this.plot});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CurrentFacilityScreen(plot: plot),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF151515),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: plot.images!.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: plot.images?.first ?? '',
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      height: 110,
                    )
                  : Image.asset(
                      'lib/assets/icons/map_pin3.png',
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      height: 110,
                    ),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                plot.name ?? '',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFFD0D0D0)),
              ),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "${plot.price} ТГ",
                style: GoogleFonts.poppins(fontSize: 9, fontWeight: FontWeight.w600, color: const Color(0xFF1A75FF)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      plot.district ?? '',
                      style: GoogleFonts.poppins(fontSize: 9, fontWeight: FontWeight.w600, color: const Color(0xFFB9B9B9)),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  SvgPicture.asset(
                    'lib/assets/icons/Vector.svg',
                    height: 16,
                  )
                ],
              ),
            ),
          ],
        ),
      ),

      // Container(
      //   margin: const EdgeInsets.symmetric(horizontal: 8),
      //   padding: const EdgeInsets.all(8),
      //   decoration: const BoxDecoration(
      //     color: AppColors.backgroundColor,
      //     border: Border(
      //       bottom: BorderSide(width: 0.2, color: Color(0xFF667085)),
      //     ),
      //   ),
      //   child: Row(
      //     children: [
      //       Stack(
      //         children: [
      //           ClipRRect(
      //             borderRadius: BorderRadius.circular(4.0),
      //             child: CachedNetworkImage(
      //               imageUrl: plot.images.first,
      //               // 'https://images.ctfassets.net/hrltx12pl8hq/a2hkMAaruSQ8haQZ4rBL9/8ff4a6f289b9ca3f4e6474f29793a74a/nature-image-for-website.jpg?fit=fill&w=600&h=400',
      //               // cacheKey: '$facilityId/$imageUrl',
      //               memCacheWidth: (108.0 * MediaQuery.of(context).devicePixelRatio).toInt(),
      //               filterQuality: FilterQuality.medium,
      //               // placeholder: (context, url) => Container(
      //               //   color: context.ytheme.bottomSheetContainerColor,
      //               //   width: YSizes.facilityListImagePreview,
      //               //   height: YSizes.facilityListImagePreview,
      //               // ),
      //               // errorWidget: (_, __, ___) => errorWidget,
      //               width: 108.0,
      //               height: 108.0,
      //               fit: BoxFit.cover,
      //             ),
      //           ),
      //         ],
      //       ),
      //       Expanded(
      //         child: Padding(
      //           padding: const EdgeInsets.symmetric(horizontal: 8),
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Header(plot: plot),
      //               // if (facility.isApartment || facility.isApartmentsComplex) _Apartments(facility),
      //               // if (facility.isCommerce || facility.isParking || facility.isPlot) _Commercials(facility),
      //               // if (facility.isHouse || facility.isHousesComplex) _Houses(facility),
      //               Footer(plot: plot),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
