import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HeaderImage extends StatefulWidget {
  // final String facilityId;
  final List<dynamic> images;
  final StreamController<int> streamController;

  const HeaderImage({
    super.key,
    // required this.facilityId,
    required this.images,
    required this.streamController,
  });

  @override
  State<HeaderImage> createState() => HeaderImageState();
}

class HeaderImageState extends State<HeaderImage> {
  late final PageController _pageViewController;

  @override
  void initState() {
    super.initState();

    widget.streamController.sink.add(0);

    _pageViewController = PageController(initialPage: min(0, widget.images.length - 1))
      ..addListener(() {
        widget.streamController.sink.add(_pageViewController.page?.round() ?? 0);
      });
  }

  @override
  void dispose() {
    _pageViewController
      ..removeListener(() {})
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) {
      return SizedBox(
        height: 260.0,
        child: Image.asset(
          'lib/assets/icons/map_pin3.png',
          height: 260.0,
          width: double.infinity,
        ),
      );
    }

    return SizedBox(
      height: 305.0,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 260.0,
        child: PageView.builder(
          controller: _pageViewController,
          itemCount: widget.images.length,
          itemBuilder: (_, index) {
            final image = widget.images[index];

            return GestureDetector(
              onTap: () async {
                // final lastPhotoIndex = await YImageSliderFullScreen.show(
                //   context: context,
                //   facilityId: widget.facilityId,
                //   facilityImages: widget.images,
                //   initIndex: index,
                // );

                // if (lastPhotoIndex != null) _pageViewController.jumpToPage(lastPhotoIndex);
              },
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                height: 260.0,
                width: MediaQuery.of(context).size.width,
                child: CachedNetworkImage(
                  // cacheKey: imageKey,
                  imageUrl: image,
                  alignment: Alignment.center,
                  memCacheWidth: (MediaQuery.of(context).size.width * MediaQuery.of(context).devicePixelRatio).toInt(),
                  fadeInDuration: const Duration(milliseconds: 10),
                  fadeInCurve: Curves.easeIn,
                  errorWidget: (_, __, ___) => Image.asset(
                    'lib/assets/icons/circle.png',
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fitWidth,
                  ),
                  height: 305.0,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
