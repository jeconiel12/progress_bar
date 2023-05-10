import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:progress_bar/progress_bar.dart';

const kDefaultDuration = 500;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Progress Bar Example',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Progress Bar Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _steps = 4;
  int _currentStep = 0;
  int _duration = kDefaultDuration;
  Color _backgroundColor = Colors.grey;
  Color _barColor = Colors.orange;
  Curve _curve = Curves.linear;

  void onCurveChanged(Curve? curve) {
    setState(() => _curve = curve!);
  }

  void onDurationChanged(String duration) {
    setState(() => _duration = int.parse(duration));
  }

  void increaseSteps() {
    if (_currentStep >= _steps) return;
    setState(() => _currentStep++);
  }

  void decreaseSteps() {
    if (_steps == 0 || _currentStep == 0) return;
    setState(() => _currentStep--);
  }

  void onStepsChanged(Set<int> newSteps) {
    setState(() {
      _currentStep = 0;
      _steps = newSteps.first;
    });
  }

  void onBackgroundColorChanged(Color color) {
    setState(() => _backgroundColor = color);
  }

  void onBarColorChanged(Color color) {
    setState(() => _barColor = color);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ProgressBar(
                currentStep: _currentStep,
                totalSteps: _steps,
                indicatorColor: _barColor,
                backgroundColor: _backgroundColor,
                duration: Duration(milliseconds: _duration),
                curve: _curve,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        showDialog<void>(
                          context: context,
                          builder: (context) {
                            return ColorDialog(
                              currentColor: _barColor,
                              onColorChanged: onBarColorChanged,
                            );
                          },
                        );
                      },
                      child: const Text('Bar Color'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        showDialog<void>(
                          context: context,
                          builder: (context) {
                            return ColorDialog(
                              currentColor: _barColor,
                              onColorChanged: onBackgroundColorChanged,
                            );
                          },
                        );
                      },
                      child: const Text('Background Color'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text('Numbers of steps'),
              const SizedBox(height: 12),
              SegmentedButton<int>(
                segments: const [
                  ButtonSegment(value: 2, label: Text('2')),
                  ButtonSegment(value: 3, label: Text('3')),
                  ButtonSegment(value: 4, label: Text('4')),
                  ButtonSegment(value: 5, label: Text('5'))
                ],
                selected: {_steps},
                onSelectionChanged: onStepsChanged,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton(
                    onPressed: increaseSteps,
                    child: const Icon(Icons.add),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    children: [
                      const Text('Current Step'),
                      Text('$_currentStep out of $_steps'),
                    ],
                  ),
                  const SizedBox(width: 12),
                  FloatingActionButton(
                    onPressed: decreaseSteps,
                    child: const Icon(Icons.remove),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              TextFormField(
                initialValue: kDefaultDuration.toString(),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Input Duration (e.g: 500)',
                  label: Text('Duration (in milliseconds)'),
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                ],
                keyboardType: TextInputType.number,
                onChanged: onDurationChanged,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  const Text('Curve'),
                  DropdownButtonFormField<Curve>(
                    value: _curve,
                    onChanged: onCurveChanged,
                    items: const [
                      DropdownMenuItem(
                        value: Curves.linear,
                        child: Text('Linear'),
                      ),
                      DropdownMenuItem(
                        value: Curves.ease,
                        child: Text('Ease'),
                      ),
                      DropdownMenuItem(
                        value: Curves.bounceIn,
                        child: Text('Bounce In'),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ColorDialog extends StatefulWidget {
  const ColorDialog({
    required this.onColorChanged,
    this.currentColor,
    super.key,
  });

  final ValueChanged<Color> onColorChanged;
  final Color? currentColor;

  @override
  State<ColorDialog> createState() => _ColorDialogState();
}

class _ColorDialogState extends State<ColorDialog> {
  late Color pickerColor;

  @override
  void initState() {
    super.initState();
    pickerColor = widget.currentColor ?? const Color.fromARGB(255, 179, 89, 37);
  }

  void onColorChanged(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Pick a color!'),
      content: SingleChildScrollView(
        child: MaterialPicker(
          pickerColor: pickerColor,
          onColorChanged: onColorChanged,
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          child: const Text('Got it'),
          onPressed: () {
            widget.onColorChanged(pickerColor);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
