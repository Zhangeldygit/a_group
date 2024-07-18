import 'package:a_group/plots/plots_repository/models/plot_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class HeaderUserActions extends StatelessWidget {
  final Plot plot;

  const HeaderUserActions({
    super.key,
    required this.plot,
  });

  @override
  Widget build(BuildContext context) {
    final phone =
        MaskTextInputFormatter(mask: '+# (###) ###-##-##', filter: {"#": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy, initialText: plot.myUser?.phone);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: InkWell(
        onTap: () {},
        child: Row(
          children: [
            const UserPhoto(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserName(plot: plot),
                  TextField(
                    decoration: InputDecoration(
                      hintText: phone.getMaskedText(),
                      hintStyle: GoogleFonts.poppins(color: const Color(0xFFCFD7F6)),
                      enabled: false,
                      prefixIcon: const Icon(Icons.call, color: Color(0xFFCFD7F6)),
                    ),
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

class UserPhoto extends StatelessWidget {
  final EdgeInsets padding;
  // final User? user;
  final double? size;
  // final bool builder;

  const UserPhoto({
    super.key,
    // this.user,
    this.padding = const EdgeInsets.only(right: 8.0),
    this.size,
    // required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    const photoUrl = 'https://buffer.com/library/content/images/size/w1200/2023/10/free-images.jpg';

    return Padding(
      padding: padding,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.1,
        height: MediaQuery.of(context).size.height * 0.1,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: CachedNetworkImage(
          // cacheKey: '${user?.id}/$photoUrl',
          imageUrl: photoUrl,
          // memCacheWidth: photoSize.toInt(),
          // memCacheHeight: photoSize.toInt(),
          filterQuality: FilterQuality.medium,
          fit: BoxFit.cover,
          fadeInDuration: const Duration(milliseconds: 10),
          fadeInCurve: Curves.easeIn,
          errorWidget: (_, __, ___) => CircleAvatar(
            radius: 36 / 2,
            backgroundColor: Colors.grey,
            child: CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 36 / 2 - 1,
              child: Image.asset(''),
            ),
          ),
        ),
      ),
    );
  }
}

class UserName extends StatelessWidget {
  final Plot? plot;

  const UserName({super.key, this.plot});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          plot?.myUser?.name ?? 'Имя',
          softWrap: true,
          style: GoogleFonts.manrope(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          plot?.myUser?.userType == 'seller' ? 'Менеджер по продажам' : '',
          softWrap: true,
          style: GoogleFonts.manrope(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
