import 'package:a_group/components/colors.dart';
import 'package:a_group/plots/plots_repository/models/plot_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StatusCard extends StatelessWidget {
  const StatusCard({super.key, required this.plot});
  final Plot plot;

  @override
  Widget build(BuildContext context) {
    final images = plot.images?.where((element) => element.contains('.jpg')).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: images!.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: images.first,
                    fit: BoxFit.fitWidth,
                    height: 150,
                    width: double.infinity,
                  )
                : Image.asset(
                    'lib/assets/icons/plot.jpg',
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                  ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  plot.name ?? 'Name',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: GoogleFonts.raleway(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Text('${plot.price} тг', style: GoogleFonts.raleway(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Сот/Участок ${plot.acreage ?? 5}',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: GoogleFonts.raleway(color: AppColors.iconColor, fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            '${plot.status}',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: GoogleFonts.raleway(
                color: plot.status == 'Продается'
                    ? Colors.green
                    : plot.status == 'Продано'
                        ? Colors.red
                        : AppColors.iconColor,
                fontSize: 12,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
