// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cluans_model.dart';
import 'cluans_widget.dart';
import 'add_cluan.dart';
import 'statistics.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
/**
 * Name: Dane Patzlaff
 * Date: 11/4/25
 * Description: Integrated Supabase with Cluan Tabbed application
 * Known Bugs: None known
 * Reflection: Debugging the supabase connections took some time, and I had to
 * rework my widget tree a bit, but the content is displaying properly, and didn't have
 * to deviate too much from famous painters to do so. Overall pleased
 */

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final supaCluanURL = 'https://yyabxwdfwyaiknzbbnxs.supabase.co';
  final supaAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl5YWJ4d2Rmd3lhaWtuemJibnhzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjE3Mzk3MDMsImV4cCI6MjA3NzMxNTcwM30.6Ge4dRQ4VIlIJLLyyJCleitR6vghYrlz_4I1w__NZvk';

  await Supabase.initialize(url: supaCluanURL, anonKey: supaAnonKey);
  runApp(
    ChangeNotifierProvider(
      create: (_) => CluansModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const MainApp(),
      ),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int selectedIndex = 0;

  final List<Widget> screens = const [
    CluansWidget(),
    AddCluanWidget(),
    StatisticsWidget(),
  ];

  void onTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //Select a Widget from the list to display it
    List<Widget>? appBarActions;

    if (selectedIndex == 0) {
      appBarActions = [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            context.read<CluansModel>().sortCluans(true);
          },
        ),
        IconButton(
          icon: const Icon(Icons.straighten),
          onPressed: () {
            context.read<CluansModel>().sortCluans(false);
          },
        ),
      ];
    } else {
      appBarActions = null;
    }

    //Sets up the bottom nav bar
    return Scaffold(
        appBar: AppBar(
          title: Text(['Cluans', 'Add Cluan', 'Statistics'][selectedIndex]),
          actions: appBarActions,
        ),
        body: screens[selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: onTap,
          selectedItemColor: const Color.fromARGB(255, 24, 3, 80),
          unselectedItemColor: Color.fromARGB(58, 163, 9, 58),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Cluans'),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add Cluan'),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: 'Stats',
            ),
          ],
        ),
      );
  }
}
