import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/dimensions.dart';
import '../../../core/media_query.dart';
import '../../../theme/app_color.dart';
import 'get_started_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenDimension().init(context);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: Colors.white,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'CODEX',
                  style: TextStyle(
                    fontSize: ScreenDimension.textSize * 8,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: ClipPath(
              clipper: BottomCurveClipper(),
              child: Container(
                height: ScreenDimension.onePercentOfScreenHight * 35,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.secondary,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Center(
                  child: Text(
                    'Kale Logistics Solution',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize:
                          ScreenDimension.textSize * AppDimensions.headingText3,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context,
          CupertinoPageRoute(builder: (context) => const GetStartedScreen()));
    });
  }
}

class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(0, size.height * 0.1);
    path.quadraticBezierTo(
        size.width / 2, size.height * 0.4, size.width, size.height * 0.1);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
