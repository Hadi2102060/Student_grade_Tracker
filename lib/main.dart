// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/subject_provider.dart';
import 'providers/app_state_provider.dart';
import 'theme/app_theme.dart';
import 'screens/add_subject_screen.dart';
import 'screens/subject_list_screen.dart';
import 'screens/summary_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SubjectProvider()),
        ChangeNotifierProvider(create: (_) => AppStateProvider()),
      ],
      child: Consumer<AppStateProvider>(
        builder: (context, appState, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Student Grade Tracker',
            theme: appState.isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppStateProvider>(context);

    final List<Widget> screens = const [
      AddSubjectScreen(),
      SubjectListScreen(),
      SummaryScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Grade Tracker'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(appState.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => appState.toggleTheme(),
            tooltip: 'Toggle Theme',
          ),
        ],
      ),
      body: screens[appState.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: appState.currentIndex,
        onTap: (index) => appState.setIndex(index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Add Subject',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Subject List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.summarize),
            label: 'Summary',
          ),
        ],
      ),
    );
  }
}
