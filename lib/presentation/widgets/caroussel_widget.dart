// ignore_for_file: deprecated_member_use
import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarousselWidget extends StatelessWidget {
  const CarousselWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Stack(
        children: [
          Container(
            height: 180.0,
            width: double.infinity,
            decoration: BoxDecoration(
              color: LightThemeColors.colorPrimary,
              borderRadius: BorderRadius.circular(20),
            ),
          ),

          Positioned(
            right: 211,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                bottomLeft: Radius.circular(34.0),
              ),
              child: Image.asset(
                'assets/images/backgroundcard.png',
                height: 189.0,
                color: Colors.white.withOpacity(0.4),
                colorBlendMode: BlendMode.modulate,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SlideCarouselWidget extends StatefulWidget {
  const SlideCarouselWidget({super.key});

  @override
  State<SlideCarouselWidget> createState() => _CarouselImageWidgetState();
}

class _CarouselImageWidgetState extends State<SlideCarouselWidget> {
  List imagesList = [
    'assets/images/fianarantsoa.png',
    'assets/images/sambavaville.png',
    'assets/images/morondava.png',
    'assets/images/toliara.png',
    'assets/images/antomaro.png',
  ];

  int _currentIndex = 0;
  final _carouselController = CarouselSliderController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CarouselSlider(
          items: _buildImageList(images: imagesList),
          carouselController: _carouselController,
          options: CarouselOptions(
            height: 180.0,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 300),
            enlargeCenterPage: true,
            aspectRatio: 16 / 9,
            viewportFraction: 0.8,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),

        const SizedBox(height: 16.0),

        AnimatedSmoothIndicator(
          activeIndex: _currentIndex,
          count: imagesList.length,
          effect: WormEffect(
            dotHeight: 8.0,
            dotWidth: 8.0,
            dotColor: Colors.grey.shade200,
            activeDotColor: LightThemeColors.colorPrimary,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildImageList({required List images}) {
    return images.map((image) => _buildImageContaainer(image: image)).toList();
  }

  Container _buildImageContaainer({required dynamic image}) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: LightThemeColors.colorPrimary,
        borderRadius: BorderRadius.circular(12.0),
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
      ),
    );
  }
}
