// ignore_for_file: unused_field

import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/pages/login_signup/create_account_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({super.key});

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  final _pageController = PageController();
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const PageViewModel(
      title: "La gestion associative, reinventee",
      description:
          "Je veux vous donner les outils pour gerer \n votre association autrement: plus facilement,\n plus efficacement, et avec plus d impact.",
      imagePath: 'assets/images/launcher.png',
    ),

    const PageViewModel(
      title: "Chaque contribution compte",
      description:
          "Ensemble, faisons en sorte que chaque \n contribution compte. Notre gestion des \n activites et des depenses sociales vous \n aide a preserver vos ressources et a \n les fait grandir.",
      imagePath: 'assets/images/mental.png',
    ),
    const PageViewModel(
      title: "Gerer moins, realisez plus",
      description:
          "AntMobile, la solution qui automatise \n la gestion de votre association pour \n plus de temps et efficacite.",
      imagePath: 'assets/images/marketing.png',
    ),
  ];
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNext() {
    if (_currentIndex < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      _onFinish();
    }
  }

  void _onFinish() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => CreateAccountPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged:
                (index) => setState(() {
                  _currentIndex = index;
                }),
            itemBuilder: (context, index) {
              return _pages[index];
            },
          ),
          _currentIndex == _pages.length - 1
              ? SizedBox.shrink()
              : Positioned(
                bottom: 20,
                left: 20,
                child: const Text(
                  "Suivant",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
          Positioned(
            bottom: 10,
            right: 10,
            child: IconButton(
              onPressed:
                  _currentIndex == _pages.length - 1 ? _onFinish : _onNext,
              icon: Image.asset(
                'assets/icons/arrorright.png',
                width: 32,
                height: 32,
              ),
            ),
          ),
          _smoothIndicatorWidget(pages: _pages, controller: _pageController),
        ],
      ),
    );
  }

  Widget _smoothIndicatorWidget({
    required List pages,
    required PageController controller,
  }) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 30,
      child: Center(
        child: SmoothPageIndicator(
          controller: controller,
          count: pages.length,
          effect: SwapEffect(
            dotHeight: 8,
            dotWidth: 8,
            dotColor: Colors.grey.shade200,
            activeDotColor: LightThemeColors.colorPrimary,
          ),
        ),
      ),
    );
  }
}

class PageViewModel extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  const PageViewModel({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(imagePath, height: 240),
        const SizedBox(height: 60),
        _buildPageTitle(title: title),
        const SizedBox(height: 20),
        _buildPageDescription(description: description),
        const SizedBox(height: 60),
      ],
    );
  }

  Widget _buildPageTitle({required String title}) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: FittedBox(
        child: Text(
          title,
          style: GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildPageDescription({required String description}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        description,
        textAlign: TextAlign.center,
        style: GoogleFonts.robotoCondensed(
          fontSize: 16,
          color: Colors.grey[700],
        ),
      ),
    );
  }
}
