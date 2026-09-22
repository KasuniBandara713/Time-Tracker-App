import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:localstorage/localstorage.dart';

import 'screens/HomeScreen.dart';
//import 'screens/TaskManagementScreen.dart';
//import 'screens/ProjectManagementScreen.dart';
import 'provider/TimeEntryProvider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();

  //final LocalStorage storage = LocalStorage('time_tracker');

  runApp(
    ChangeNotifierProvider<TimeEntryProvider>(
      create: (_) => TimeEntryProvider(storage: localStorage),

      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Time Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 0, 4, 0),
        ),
        useMaterial3: true,
      ),
      home:  const HomeScreen(),
    );
  }
}