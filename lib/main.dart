import 'package:bitesplit/app/theme.dart';
import 'package:bitesplit/features/bill_split/views/bill_split_view.dart';
import 'package:bitesplit/features/home/views/home_view.dart';
import 'package:bitesplit/features/home/views/widgets/navbar_control.dart';
import 'package:bitesplit/features/splash/views/splash_view.dart';
import 'package:bitesplit/models/people_group.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(PeopleGroupAdapter());

  await Hive.openBox<PeopleGroup>('groups');
  
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

@override
Widget build(BuildContext context) {
  final themeProvider = Provider.of<ThemeProvider>(context);

  return ScreenUtilInit(
    designSize: Size(375, 812),
    minTextAdapt: true,                
    splitScreenMode: true,              
    builder: (context, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightMode,
        darkTheme: darkMode,
        themeMode: themeProvider.themeMode,
        routes: {
          SplashView.id: (context) => const SplashView(),
          BillSplitView.id: (context) => const BillSplitView(),
          NavbarControl.id: (context) => const NavbarControl(),
          HomeView.id: (context) => const HomeView(),
        },
        initialRoute: SplashView.id,
      );
    },
  );
}
}

