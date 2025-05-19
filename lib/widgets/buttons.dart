import 'package:flutter/material.dart';

import '../../theme/app_color.dart';
class ButtonWidgets {
  static Widget buildRoundedGradientButton({
    required String text,
    required VoidCallback? press,
    Color color = AppColors.primary,
    Color? textColor = AppColors.white,
    Color? borderColor = AppColors.textFieldBorderColor,
    double horizontalPadding = 20,
    double verticalPadding = 12,
    double cornerRadius = 10,
    double textSize = 16,
    bool isborderButton = false,
    BuildContext? context,
  }) {
    final bool isDisabled = press == null;
    final Color buttonColor = isDisabled ? AppColors.textFieldBorderColor : color;
    final Color buttonTextColor = isDisabled ? isborderButton?AppColors.textFieldBorderColor: AppColors.white : (textColor ?? Colors.white);

    return GestureDetector(
      onTap: press,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        decoration: BoxDecoration(
          color: isborderButton ? Colors.transparent : (isDisabled ? AppColors.textFieldBorderColor : color),
          borderRadius: BorderRadius.circular(cornerRadius),
          border: isborderButton ? Border.all(color: buttonColor, width: 2) : null,
          gradient: (!isborderButton && !isDisabled) ? const LinearGradient(
            colors: [AppColors.primary, AppColors.secondary],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ) : null,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: buttonTextColor,
              fontWeight: FontWeight.normal,
              fontSize: textSize,
            ),
          ),
        ),
      ),
    );
  }
}