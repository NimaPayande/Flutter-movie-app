import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyCarouselSlider extends StatelessWidget {
  MyCarouselSlider(
      {required this.itemBuilder,
      required this.itemCount,
      this.viewportFraction = .5,
      Key? key})
      : super(key: key);
  Widget Function(BuildContext context, int index, int realindex)? itemBuilder;
  final int itemCount;
  final double viewportFraction;
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      options: CarouselOptions(
          enableInfiniteScroll: true,
          reverse: true,
          viewportFraction: viewportFraction,
          enlargeCenterPage: true,
          aspectRatio: 1.5),
    );
  }
}
