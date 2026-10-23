// Activity 5: Customizing UI components with a theme
import 'package:flutter/material.dart';
import 'student.dart';

void main() {
  runApp(const ThemeDemoApp());
}

class ThemeDemoApp extends StatefulWidget {
  const ThemeDemoApp({super.key});

  @override
  State<ThemeDemoApp> createState() => _ThemeDemoAppState();
}

class _ThemeDemoAppState extends State<ThemeDemoApp> {
  bool _isDark = false;

  void _setDark(bool value) {
    setState(() {
      _isDark = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Activity 5',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(Brightness.light),
      darkTheme: buildTheme(Brightness.dark),
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      home: SettingsPage(isDark: _isDark, onDarkChanged: _setDark),
    );
  }
}

ThemeData buildTheme(Brightness brightness) {
  return ThemeData(
    colorSchemeSeed: studentColor,
    brightness: brightness,
    appBarTheme: const AppBarTheme(centerTitle: true),
    textTheme: const TextTheme(
      headlineSmall: TextStyle(fontWeight: FontWeight.bold),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        // Task 2: corner radius changed from 8 to 20
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      ),
    ),
  );
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key, required this.isDark, required this.onDarkChanged});

  final bool isDark;
  final ValueChanged<bool> onDarkChanged;

  void _showMessage(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Activity 5 - $studentName')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: colors.primary,
                foregroundColor: colors.onPrimary,
                child: const Icon(Icons.person),
              ),
              title: const Text(studentName),
              subtitle: Text('Theme color: $studentColorName'),
              trailing: const Icon(Icons.verified),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: SwitchListTile(
              title: const Text('Dark mode'),
              subtitle: const Text('Switch between light and dark theme'),
              secondary: const Icon(Icons.dark_mode),
              value: isDark,
              onChanged: onDarkChanged,
            ),
          ),
          const SizedBox(height: 16),
          Text('My skills', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              Chip(avatar: Icon(Icons.code), label: Text('Dart')),
              Chip(avatar: Icon(Icons.flutter_dash), label: Text('Flutter')),
              Chip(avatar: Icon(Icons.storage), label: Text('MySQL')),
              Chip(avatar: Icon(Icons.terminal), label: Text('Python')),
              Chip(avatar: Icon(Icons.source), label: Text('Git')),
              // Task 1: extra skill chip
              Chip(avatar: Icon(Icons.web), label: Text('HTML/CSS')),
            ],
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => _showMessage(context, 'Elevated button pressed'),
            child: const Text('Elevated'),
          ),
          const SizedBox(height: 8),
          OutlinedButton(
            onPressed: () => _showMessage(context, 'Outlined button pressed'),
            child: const Text('Outlined'),
          ),
          const SizedBox(height: 8),
          FilledButton.icon(
            onPressed: () => _showMessage(context, 'Saved!'),
            icon: const Icon(Icons.save),
            label: const Text('Save'),
          ),
        ],
      ),
    );
  }
}