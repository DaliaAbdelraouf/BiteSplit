import 'package:bitesplit/features/bill_split/views/bill_split_view.dart';
import 'package:bitesplit/features/home/views/home_view.dart';
import 'package:bitesplit/features/splash/views/splash_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hide the debug banner
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255)),
      routes: {
        SplashView.id: (context) => const SplashView(),
        BillSplitView.id: (context) => const BillSplitView(),
        HomeView.id: (context) => const HomeView(),
 
      },
      initialRoute: SplashView.id,
    );
  }
}

