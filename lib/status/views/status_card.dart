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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl:
                  plot.images!.isNotEmpty ? plot.images?.first : 'https://t3.ftcdn.net/jpg/03/14/10/36/360_F_314103626_jMKyWmVEQI1uQQajMUxrAh8uzBLV6hEg.jpg',
              fit: BoxFit.fitWidth,
              height: 150,
              width: double.infinity,
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
      ],
    );
  }
}
