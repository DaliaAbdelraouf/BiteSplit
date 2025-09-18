
import 'package:bitesplit/features/home/views/home_view.dart';
import 'package:bitesplit/features/splash/views/widgets/splash_view_body.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
   static const String id = 'SplashView';
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

   @override
  void initState() {
    navigationControl();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashViewBody(),
    );
  }

    void navigationControl() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
         Navigator.pushNamed(context, HomeView.id);
      },
    );
  }
}