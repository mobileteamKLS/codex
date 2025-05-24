import 'dart:ui';

import '../theme/app_color.dart';

class ColorUtils{

  static Color getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'CREATED':
        return AppColors.draft;
      case 'APPROVED':
        return AppColors.gatedIn;
      case 'REJECTED':
        return AppColors.gateInRed;
      case 'INACTIVE':
        return AppColors.gateInYellow;
      default:
        return AppColors.gatedIn;
    }
  }
}