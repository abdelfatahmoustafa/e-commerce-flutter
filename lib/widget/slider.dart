import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:async';

class AutoSlider extends StatefulWidget {
  final List<String> imagePaths;

  const AutoSlider({super.key, required this.imagePaths});

  @override
  State<AutoSlider> createState() => _AutoSliderState();
}

class _AutoSliderState extends State<AutoSlider> {
  final PageController _controller = PageController(viewportFraction: 0.9);
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < widget.imagePaths.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _controller.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Column(
        children: [
          SizedBox(
            height: 180,
            child: PageView(
              controller: _controller,
              children: widget.imagePaths
                  .map(
                    (path) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(path, fit: BoxFit.cover),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 10),
          SmoothPageIndicator(
            controller: _controller,
            count: widget.imagePaths.length,
            effect: WormEffect(
              dotHeight: 8,
              dotWidth: 8,
              activeDotColor: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
