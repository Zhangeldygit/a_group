import 'package:a_group/auth/auth_repository/models/user_model.dart';
import 'package:a_group/plots/bloc/plots_bloc.dart';
import 'package:a_group/plots/plots_repository/firebase_plots_repository.dart';
import 'package:a_group/plots/plots_repository/models/plot_model.dart';
import 'package:a_group/plots/views/current_facility/current_facility_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FacilityCard extends StatefulWidget {
  final Plot plot;
  final MyUser? user;
  const FacilityCard({super.key, required this.plot, this.user});

  @override
  State<FacilityCard> createState() => _FacilityCardState();
}

class _FacilityCardState extends State<FacilityCard> {
  bool isFavorite = false;
  Box? favoritesBox;
  String address = '';
  String region = '';
  String district = '';

  void toggleFavorite() async {
    await Hive.openBox('plots_${widget.user?.userId}');
    setState(() {
      favoritesBox = Hive.box('plots_${widget.user?.userId}');
      if (isFavorite) {
        favoritesBox?.delete(widget.plot.id);
      } else {
        favoritesBox?.put(widget.plot.id, widget.plot);
      }
    });
    loadFavorites();
  }

  void loadFavorites() async {
    await Hive.openBox('plots_${widget.user?.userId}');
    favoritesBox = Hive.box('plots_${widget.user?.userId}');
    isFavorite = favoritesBox?.containsKey(widget.plot.id) ?? false;
    setState(() {});
  }

  @override
  void initState() {
    loadFavorites();
    extractParts(widget.plot.name ?? '');
    super.initState();
  }

  void extractParts(String name) {
    final parts = name.split(', ');
    if (parts.length >= 3) {
      address = parts.length >= 4 ? "${parts[parts.length - 2]}, ${parts[parts.length - 1]}" : parts[parts.length - 1];
      region = parts.length >= 3 ? parts[1] : '';
      district = parts.length >= 4 ? parts[2] : (parts.length >= 3 ? parts[1] : '');
    }
  }

  @override
  Widget build(BuildContext context) {
    final images = widget.plot.images?.where((element) => element.contains('.jpg')).toList();
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => GetPlotsBloc(FirebasePlotsRepo()),
              child: CurrentFacilityScreen(plot: widget.plot, user: widget.user),
            ),
          ),
        ).then(
          (value) {
            if (value != null) {
              context.read<GetPlotsBloc>().add(GetPlots(userType: widget.user?.userType, userId: widget.user?.userId));
            }
          },
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
              child: images!.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: widget.plot.images?.first ?? '',
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      height: 110,
                    )
                  : Image.asset(
                      'lib/assets/icons/plot.jpg',
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      height: 110,
                    ),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                address,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFFD0D0D0)),
              ),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "${widget.plot.price} ТГ",
                style: GoogleFonts.poppins(fontSize: 9, fontWeight: FontWeight.w600, color: const Color(0xFF1A75FF)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "Сот/Участок ${widget.plot.acreage}",
                style: GoogleFonts.poppins(fontSize: 9, fontWeight: FontWeight.w600, color: const Color(0xFFB9B9B9)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.plot.status ?? '',
                      style: GoogleFonts.poppins(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: widget.plot.status == 'Продается'
                              ? Colors.green
                              : widget.plot.status == 'Продано'
                                  ? Colors.red
                                  : const Color(0xFFB9B9B9)),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (widget.user?.userType == 'customer') {
                        toggleFavorite();
                      }
                    },
                    child: widget.user?.userType == 'customer'
                        ? Icon(isFavorite == false ? Icons.favorite_border : Icons.favorite, color: isFavorite == false ? Colors.white : Colors.red)
                        : SvgPicture.asset('lib/assets/icons/Vector.svg', height: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
