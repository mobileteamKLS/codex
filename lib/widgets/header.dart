import 'package:flutter/material.dart';

import '../theme/app_color.dart';
class HeaderWidget extends StatefulWidget {

  String title;
  VoidCallback onBack;
  String? clearText;
  VoidCallback? onClear;
  Color? titleTextColor;

  HeaderWidget({super.key, required this.title, this.titleTextColor, required this.onBack, this.clearText = "", this.onClear});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              InkWell(
                onTap : () {
                  widget.onBack();
                },
                child: const Icon(
                  Icons.keyboard_arrow_left_sharp,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 5,),
              Expanded(
                child:  Text(
                    widget.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: AppColors.textColorPrimary,
                    )
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: InkWell(
              onTap: () {
                widget.onClear!();
              },
              child: Row(
                children: [
                  (widget.clearText! != "") ? const Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Icon(
                      size: 22,
                      Icons.refresh_rounded,
                      color: AppColors.secondary,
                    ),
                  ) : SizedBox(),
                  Text(
                      widget.clearText!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: AppColors.secondary,
                      )
                  ),
                ],
              )),
        )
      ],
    );
  }
}