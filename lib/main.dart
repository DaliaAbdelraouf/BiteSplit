import 'package:bitesplit/app/theme.dart';
import 'package:bitesplit/features/bill_split/views/bill_split_view.dart';
import 'package:bitesplit/features/home/views/home_view.dart';
import 'package:bitesplit/features/splash/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode,            
      darkTheme: darkMode,         
      themeMode: themeProvider.themeMode, 
      routes: {
        SplashView.id: (context) => const SplashView(),
        BillSplitView.id: (context) => const BillSplitView(),
        HomeView.id: (context) => const HomeView(),
 
      },
      initialRoute: SplashView.id,
    );
  }
}

