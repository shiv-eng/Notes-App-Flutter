import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/utils/app_theme.dart';
import 'core/view_model/note_view_model.dart';
import 'view/screens/notes_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  ThemeMode _themeMode = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NoteViewModel(),
      child: MaterialApp(
        title: 'My Notes',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: _themeMode,
        debugShowCheckedModeBanner: false, 
        home: NotesScreen(
          onThemeChanged: (isDarkMode) {
            setState(() {
              _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
            });
          },
        ),
      ),
    );
  }
}
