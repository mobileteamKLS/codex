import 'package:codex_pcs/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RoundedIconButtonNew extends StatelessWidget {
  final String icon;
  final String text;
  final Widget targetPage;
  final Color containerColor;
  final Color iconColor;
  final Color textColor;

  const RoundedIconButtonNew({
    Key? key,
    required this.icon,
    required this.text,
    required this.targetPage,
    this.containerColor = Colors.blue,
    this.iconColor = Colors.white,
    this.textColor = Colors.black,
  }) : super(key: key);

  void _navigate(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => targetPage),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigate(context),
      child: Container(
          width: MediaQuery.sizeOf(context).width * 0.20,
          height: MediaQuery.sizeOf(context).height * 0.25,
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 100,
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: containerColor,
                ),
                child: SvgPicture.asset(
                  icon,
                  height: 32,
                  colorFilter: const ColorFilter.mode(AppColors.textColorPrimary, BlendMode.srcIn),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                text,
                softWrap: true,
                style: TextStyle(
                    color: textColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
            ],
          )),
    );
  }
}
