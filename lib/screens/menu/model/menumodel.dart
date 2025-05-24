import 'package:codex_pcs/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RoundedIconButtonModel {
  final String icon;
  final String text;
  final Widget targetPage;
  final Color containerColor;

  RoundedIconButtonModel({
    required this.icon,
    required this.text,
    required this.targetPage,
    required this.containerColor,
  });
}

class NavigationCard extends StatelessWidget {
  final String icon;
  final String title;
  final Widget targetPage;

  const NavigationCard({
    super.key,
    required this.icon,
    required this.title,
    required this.targetPage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(8.0),
        color: AppColors.white
      ),
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFEAF1FF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: SvgPicture.asset(
            icon,
            height: 22,
            colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.black45,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => targetPage),
          );
        },
      ),
    );
  }
}

