import 'package:flutter/material.dart';

part 'bar_spacer_painter.dart';

/// Create a custom progress bar.
///
/// [totalSteps] is used to determined the total of bar displayed.
class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,
    required this.totalSteps,
    this.currentStep = 0,
    this.indicatorColor = Colors.orange,
    this.backgroundColor = Colors.grey,
    this.barSpacerColor,
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.linear,
    this.height = 20,
  })  : assert(currentStep <= totalSteps, ''),
        assert(totalSteps > 0, '');

  /// The total number of steps in the progress bar.
  final int totalSteps;

  /// The index of current step in the progress bar.
  final int currentStep;

  /// The color of the progress bar indicator.
  final Color indicatorColor;

  /// The background color of the progress bar.
  final Color backgroundColor;

  /// The color of space between bar.
  ///
  /// To get the intended purpose filled it with the color that
  /// matched the parent of [ProgressBar] background.
  /// example:
  /// ```dart
  /// Scaffold(
  ///   color: Colors.white,
  ///   body: Center(
  ///     child: ProgressBar(
  ///       steps: 5,
  ///       backgroundColor: Colors.white,
  ///     ),
  ///   ),
  /// );
  /// ```
  /// If the value is null, it will use [Theme]
  /// scaffold background color.
  final Color? barSpacerColor;

  /// The duration of the animation that updates the progress bar.
  final Duration duration;

  /// The curve used for the animation that updates the progress bar.
  final Curve curve;

  /// The height of the progress bar.
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Container(
                key: const Key('progressBar_background'),
                color: backgroundColor,
              ),
              AnimatedContainer(
                key: const Key('progressBar_indicator'),
                width: constraints.maxWidth * currentStep / totalSteps,
                color: indicatorColor,
                curve: curve,
                duration: duration,
              ),
              Positioned.fill(
                child: CustomPaint(
                  key: const Key('progressBar_spacer'),
                  painter: BarSpacerPainter(
                    color: barSpacerColor ??
                        Theme.of(context).scaffoldBackgroundColor,
                    totalSteps: totalSteps,
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
