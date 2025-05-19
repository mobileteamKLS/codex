import 'package:flutter/material.dart';

import '../theme/app_color.dart';

class CustomSnackBar {
  static void show(
      BuildContext context, {
        required String message,
        Color backgroundColor = AppColors.warningColor,
        IconData? leftIcon = Icons.info, // Optional left icon
      }) {
    final snackBar = SnackBar(
      content: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Row(
                children: [
                  if (leftIcon != null)
                    Icon(leftIcon, color: Colors.white),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      message,
                      style: const TextStyle(color: Colors.white),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              child: const Icon(Icons.close, color: Colors.white),
              onTap: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          ],
        ),
      ),
      // margin: EdgeInsets.only(
      //     bottom: MediaQuery.of(context).size.height - 225,
      //     left: 10,
      //     right: 10),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 1500),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}