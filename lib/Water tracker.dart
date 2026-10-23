// Activity 2: A StatefulWidget that changes when you tap
import 'package:flutter/material.dart';
import 'student.dart';

void main() {
  runApp(const WaterTrackerApp());
}

class WaterTrackerApp extends StatelessWidget {
  const WaterTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Activity 2',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: studentColor),
      home: const WaterTrackerPage(),
    );
  }
}

class WaterTrackerPage extends StatefulWidget {
  const WaterTrackerPage({super.key});

  @override
  State<WaterTrackerPage> createState() => _WaterTrackerPageState();
}

class _WaterTrackerPageState extends State<WaterTrackerPage> {
  int _glasses = 0;
  static const int _goal = 6; // Task 1: changed from 8 to 6

  void _addGlass() {
    setState(() {
      if (_glasses < _goal) _glasses++;
    });
  }

  void _removeGlass() {
    setState(() {
      if (_glasses > 0) _glasses--;
    });
  }

  void _reset() {
    setState(() {
      _glasses = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build() called: $_glasses glasses');
    final ColorScheme colors = Theme.of(context).colorScheme;
    final bool goalReached = _glasses >= _goal;

    return Scaffold(
      appBar: AppBar(title: const Text('Activity 2 - $studentName')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.local_drink,
              size: 96,
              color: goalReached ? Colors.green : colors.primary,
            ),
            const SizedBox(height: 16),
            Text(
              '$_glasses / $_goal glasses',
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              goalReached
                  ? 'Hydration complete. You did it!' // Task 1: own words
                  : 'Keep drinking water!',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: 240,
              child: LinearProgressIndicator(value: _glasses / _goal, minHeight: 12),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton.filledTonal(
                  onPressed: _removeGlass,
                  icon: const Icon(Icons.remove),
                  iconSize: 32,
                ),
                const SizedBox(width: 24),
                IconButton.filled(
                  onPressed: _addGlass,
                  icon: const Icon(Icons.add),
                  iconSize: 32,
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextButton(onPressed: _reset, child: const Text('Reset')),
          ],
        ),
      ),
    );
  }
}