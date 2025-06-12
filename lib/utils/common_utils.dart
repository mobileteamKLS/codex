import 'dart:ui';

import 'package:codex_pcs/core/global.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../theme/app_color.dart';
import '../theme/app_theme.dart';

class Utils {
  static void prints(String tag, String message) {
    if (kDebugMode) {
      print("$tag : $message");
    }
  }

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

  static String formatNonUTCDate(String input) {
    DateTime dateTime = DateFormat("dd/MM/yyyy HH:mm").parse(input);
    return DateFormat("dd MMM yyyy, HH:mm").format(dateTime);
  }

  static String formatDate(DateTime date) {
    return DateFormat('d MMM yyyy').format(date);
  }

  static String formatStringUTCDate(String? dateString,
      {bool showTime = false, bool onlyTime = false}) {
    if (dateString == null || dateString.isEmpty) {
      return '-';
    }
    try {
      DateTime date = DateTime.parse(dateString);
      if (onlyTime) {
        return DateFormat('HH:mm').format(date);
      }
      if (showTime) {
        return DateFormat('dd MMM yyyy, HH:mm').format(date);
      }
      return DateFormat('dd MMM yyyy').format(date);
    } catch (e) {
      try {
        DateTime date = DateFormat('yyyy-MM-dd').parse(dateString);

        if (onlyTime) {
          return DateFormat('HH:mm').format(date);
        }

        if (showTime) {
          return DateFormat('dd MMM yyyy, HH:mm').format(date);
        }

        return DateFormat('dd MMM yyyy').format(date);
      } catch (e) {
        debugPrint('Error formatting date: $e');
        return dateString;
      }
    }
  }

  static void hideKeyboard(context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static Future<bool?> confirmationDialog(
      BuildContext context, String msg, String buttonText) {
    return showDialog<bool>(
      barrierColor: AppColors.textColorPrimary.withOpacity(0.5),
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          title: const Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                color: AppColors.textColorPrimary,
              ),
              Text(
                "  Confirmation",
                style: TextStyle(
                    fontSize: 18,
                    color: AppColors.textColorPrimary,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          content: Text(
            "$msg",
            style: TextStyle(
                fontSize: 16,
                color: AppColors.textColorPrimary,
                fontWeight: FontWeight.w400),
          ),
          actions: <Widget>[
            InkWell(
              onTap: () {
                Navigator.of(context).pop(false);
              },
              child: const Text(
                "Cancel",
                style: TextStyle(
                    fontSize: 16,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width / 100 * 1.8,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pop(true);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.primary),
                child: Text(
                  "$buttonText",
                  style: TextStyle(
                      fontSize: 16,
                      color: AppColors.white,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  static Widget buildCompactLabelValue(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: AppStyle.sideDescText,
          ),
          const SizedBox(height: 2),
          Text(value, style: AppStyle.defaultTitle),
        ],
      ),
    );
  }
}
