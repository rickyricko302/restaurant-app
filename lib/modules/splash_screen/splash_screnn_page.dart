import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/modules/home/home_page.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeIn(
            duration: const Duration(seconds: 2),
            child: Image.asset('assets/images/icon.jpg')),
      ),
    );
  }
}
