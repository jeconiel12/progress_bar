part of 'progress_bar.dart';

@visibleForTesting

/// A custom painter used to draw the separators above the progress bar.
class BarSpacerPainter extends CustomPainter {
  const BarSpacerPainter({
    required this.color,
    required this.totalSteps,
  });

  /// The color of separator.
  final Color color;

  /// The current step in the progress bar.
  final int totalSteps;

  @override
  void paint(Canvas canvas, Size size) {
    final barWidth = size.width / totalSteps;
    final barEdge = barWidth * .5 / 4;

    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    for (var i = 1; i <= totalSteps; i++) {
      final path1 = Path()
        ..moveTo(barWidth * i - barEdge, 0)
        ..lineTo(barWidth * i, 0)
        ..lineTo(barWidth * i, size.height)
        ..lineTo(barWidth * i - barEdge, size.height)
        ..lineTo(barWidth * i, size.height / 2)
        ..close();

      canvas.drawPath(path1, paint);

      final path2 = Path()
        ..moveTo(barWidth * i, 0)
        ..lineTo(barWidth * i, size.height)
        ..lineTo(barWidth * i + barEdge, size.height / 2)
        ..close();

      canvas.drawPath(path2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
