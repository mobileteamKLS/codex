import 'package:codex_pcs/theme/app_color.dart';
import 'package:flutter/material.dart';

class FilterResultChip extends StatelessWidget {
  final String text;
  final VoidCallback? onDelete;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? deleteIconColor;

  const FilterResultChip({
    Key? key,
    this.text = 'Created',
    this.onDelete,
    this.backgroundColor,
    this.textColor,
    this.deleteIconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.textColorSecondary,
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: TextStyle(
              color: textColor ?? AppColors.textColorSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (onDelete != null) ...[
            const SizedBox(width: 4),
            GestureDetector(
              onTap: onDelete,
              child: Container(
                width: 16,
                height: 16,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close,
                  size: 16,
                  color: deleteIconColor ??AppColors.textColorSecondary,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
