import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../theme/app_color.dart';

class Utils {
  static void prints(String tag, String message){
    if (kDebugMode) {
      print("$tag : $message");
    }}
  static Widget tintLoader() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          color: Colors.black.withOpacity(0.5),
          child: const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.primary,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Loading...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    // fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  static Widget customDivider({
    double space = 20,
    Color color = AppColors.black,
    bool hasColor = false,
    double? height = 0.5,
    double? thickness = 0.5,
  }) {
    return Column(
      children: [
        Divider(
          color: hasColor ? color.withOpacity(0.2) : color.withOpacity(0),
          height: height,
          thickness: thickness,
        ),
      ],
    );
  }
  static String formatDate(DateTime date) {
    return DateFormat('d MMM yyyy').format(date);
  }
}