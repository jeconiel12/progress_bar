import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:progress_bar/progress_bar.dart';

import '../helpers/helpers.dart';

class _TestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TestPageState();
}

class _TestPageState extends State<_TestPage> {
  int _currentStep = 2;

  void _incrementStep() {
    setState(() {
      _currentStep += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ProgressBar(
              key: const Key('progressBar'),
              totalSteps: 5,
              currentStep: _currentStep,
            ),
            ElevatedButton(
              onPressed: _incrementStep,
              child: const Text('Next Step'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  group('Progress Bar', () {
    testWidgets('throws asserts correctly', (tester) async {
      // Test that an exception is thrown when currentStep > totalSteps.
      expect(
        () => ProgressBar(totalSteps: 4, currentStep: 5),
        throwsAssertionError,
      );

      // Test that an exception is thrown when totalSteps <= 0.
      expect(
        () => ProgressBar(totalSteps: 0),
        throwsAssertionError,
      );
    });

    testWidgets('default value provided correctly', (tester) async {
      await tester.pumpApp(const ProgressBar(totalSteps: 5));

      final progressBar = tester.widget<ProgressBar>(
        find.byType(ProgressBar),
      );

      // Assert that the default values are as expected.
      expect(progressBar.totalSteps, 5);
      expect(progressBar.currentStep, 0);
      expect(progressBar.indicatorColor, Colors.orange);
      expect(progressBar.backgroundColor, Colors.grey);
      expect(progressBar.barSpacerColor, null);
      expect(progressBar.duration, const Duration(milliseconds: 500));
      expect(progressBar.curve, Curves.linear);
      expect(progressBar.height, 20);
    });

    group('progressBar_background', () {
      const backgroundKey = Key('progressBar_background');

      final backgroundFinder = find.byKey(backgroundKey);

      testWidgets('rendered correctly', (tester) async {
        await tester.pumpApp(const ProgressBar(totalSteps: 5));

        expect(backgroundFinder, findsOneWidget);
      });

      testWidgets('rendered with correct color', (tester) async {
        await tester.pumpApp(
          const ProgressBar(
            totalSteps: 5,
            backgroundColor: Colors.yellow,
          ),
        );

        final backgroundWidget = tester.widget<Container>(backgroundFinder);

        expect(backgroundWidget.color, Colors.yellow);
      });
    });

    group('progressBar_indicator', () {
      const indicatorKey = Key('progressBar_indicator');
      const backgroundKey = Key('progressBar_background');

      final indicatorFinder = find.byKey(indicatorKey);
      final backgroundFinder = find.byKey(backgroundKey);

      testWidgets('rendered correctly', (tester) async {
        await tester.pumpApp(const ProgressBar(totalSteps: 5));

        expect(indicatorFinder, findsOneWidget);
      });

      testWidgets('rendered with correct color', (tester) async {
        await tester.pumpApp(
          const ProgressBar(
            totalSteps: 5,
            indicatorColor: Colors.yellow,
          ),
        );

        final indicatorWidget =
            tester.widget<AnimatedContainer>(indicatorFinder);

        expect(
          (indicatorWidget.decoration! as BoxDecoration).color,
          Colors.yellow,
        );
      });

      testWidgets('width changes with current step', (tester) async {
        await tester.pumpApp(_TestPage());

        // The initial width should be 2/5 of the available width
        expect(
          tester.getSize(indicatorFinder).width,
          tester.getSize(backgroundFinder).width * 2 / 5,
        );

        // Tap the button to increment current step
        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        // The width should now be 3/5 of the available width
        expect(
          tester.getSize(indicatorFinder).width,
          tester.getSize(backgroundFinder).width * 3 / 5,
        );

        // Tap the button again to increment current step
        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        // The width should now be 4/5 of the available width
        expect(
          tester.getSize(indicatorFinder).width,
          tester.getSize(backgroundFinder).width * 4 / 5,
        );
      });
    });

    group('progressBar_spacer', () {
      const spacerKey = Key('progressBar_spacer');
      final spacerFinder = find.byKey(spacerKey);

      testWidgets('rendered correctly', (tester) async {
        await tester.pumpApp(const ProgressBar(totalSteps: 5));

        expect(spacerFinder, findsOneWidget);
      });

      testWidgets('rendered with correct parameter value', (tester) async {
        await tester.pumpApp(
          const ProgressBar(
            totalSteps: 5,
            barSpacerColor: Colors.white,
          ),
        );

        final customPaint = tester.widget<CustomPaint>(spacerFinder);
        final barSpacePainter = customPaint.painter! as BarSpacerPainter;

        expect(barSpacePainter.color, Colors.white);
        expect(barSpacePainter.totalSteps, 5);
      });
    });
  });
}
