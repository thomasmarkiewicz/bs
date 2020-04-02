import 'package:flutter/material.dart';
import 'features/workout/presentation/pages/workout/workout_page.dart';
import 'injection_container.dart' as di;

void main() async {
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.grey.shade800,
    accentColor: Colors.redAccent,
    accentColorBrightness: Brightness.light,
    disabledColor: Colors.grey.shade100,
    //canvasColor: Colors.indigo.shade50,
    // cardColor:
    // disabledColor:
    // buttonColor:
    // ToggleButtonsThemeData toggleButtonsTheme
    // hintColor:
    // errorColor:
    // FloatingActionButtonThemeData
    // bottomSheetTheme
  );

  final darkTheme = ThemeData(
    brightness: Brightness.dark,
    //primaryColor: Colors.grey.shade800,
    accentColor: Colors.redAccent,
    accentColorBrightness: Brightness.dark,
    disabledColor: Colors.grey.shade700,
    buttonColor: Colors.grey.shade500,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Body Sculpting',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      home: WorkoutPage(),
    );
  }
}
