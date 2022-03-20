import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:local_farm/core/firebase_repository.dart';
import 'package:local_farm/core/models/image_file.dart';

class SlideBanner extends StatefulWidget {
  const SlideBanner({Key? key}) : super(key: key);

  @override
  State<SlideBanner> createState() => _SlideBannerState();
}

class _SlideBannerState extends State<SlideBanner> {
  CarouselController carouselController = CarouselController();
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width / 970 * 250,
          child: CarouselSlider(
            carouselController: carouselController,
            items: FirebaseRepository()
                .banners
                .map(
                  (e) => Image.memory(
                    base64Decode(e.base64),
                    fit: BoxFit.cover,
                  ),
                )
                .toList(),
            options: CarouselOptions(
              scrollPhysics: const NeverScrollableScrollPhysics(),
              aspectRatio: 970 / 250,
              autoPlay: true,
              autoPlayCurve: Curves.easeIn,
              enableInfiniteScroll: true,
              viewportFraction: 1,
            ),
          ),
        ),
        Positioned.fill(
          left: 5,
          child: Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                carouselController.previousPage(
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeIn,
                );
              },
            ),
          ),
        ),
        Positioned.fill(
          right: 5,
          child: Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () {
                carouselController.nextPage(
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeIn,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
