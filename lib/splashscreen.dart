
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:unemployementjournal/app_colors.dart';
import 'package:unemployementjournal/homescreen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});
  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Homescreen()),
      );
    });

    return Scaffold(
      body: Container(
        color: AppColors.primary,
        child: const Center(
          child: Text(
            'Unemployment Journal',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'AzeretMono',
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}