import 'package:flutter/material.dart';
import 'package:wepool/utils/colors.dart';

class HoloCircularIndicatorWithChild extends StatefulWidget {
  final double progress; // Target progress (0.0 - 1.0)
  final double size; // Outer circle size
  final double strokeWidth; // Thickness of progress bar
  final Color progressColor; // Progress bar color
  final Color backgroundColor; // Background color of progress bar
  final Widget child; // Any widget inside the hollow space

  const HoloCircularIndicatorWithChild({
    super.key,
    required this.progress,
    required this.child,
    required this.size,
    required this.strokeWidth,
    this.progressColor = AppColors.primary,
    this.backgroundColor = AppColors.lightBlue,
  });

  @override
  _HoloCircularIndicatorWithChildState createState() => _HoloCircularIndicatorWithChildState();
}

class _HoloCircularIndicatorWithChildState extends State<HoloCircularIndicatorWithChild>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;
  double _animatedSize = 100; // Default size

  @override
  void initState() {
    super.initState();

    // Animation controller for smooth progress transition
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1), // Smooth progress animation
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: widget.progress).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward(); // Start animation

    _progressAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed && widget.progress == 1.0) {
        // Wait 500ms after progress completes, then shrink
        Future.delayed(Duration(milliseconds: 500), () {
          if (mounted) {
            setState(() {
              _animatedSize = 40; // Shrinking effect
            });
          }
        });
      }
    });
  }

  @override
  void didUpdateWidget(HoloCircularIndicatorWithChild oldWidget) {
    super.didUpdateWidget(oldWidget);

    _progressAnimation = Tween<double>(begin: _progressAnimation.value, end: widget.progress).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward(from: 0); // Restart animation

    if (widget.progress == 1.0) {
      Future.delayed(Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() {
            _animatedSize = 40; // Shrinking effect
          });
        }
      });
    } else {
      setState(() {
        _animatedSize = widget.size; // Keep original size
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Animated Circular Progress Indicator
          AnimatedContainer(
            duration: Duration(milliseconds: 800), // Smooth shrinking effect
            curve: Curves.easeOut,
            width: _animatedSize,
            height: _animatedSize,
            child: AnimatedBuilder(
              animation: _progressAnimation,
              builder: (context, child) {
                return CircularProgressIndicator(
                  value: _progressAnimation.value, // Smooth animated progress
                  strokeWidth: widget.strokeWidth,
                  backgroundColor: widget.backgroundColor,
                  color: widget.progressColor,
                );
              },
            ),
          ),

          // Custom Child Widget (Button, Image, Icon, etc.)
          widget.child,
        ],
      ),
    );
  }
}
