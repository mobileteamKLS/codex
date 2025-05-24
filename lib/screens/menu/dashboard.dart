import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/dimensions.dart';
import '../../core/img_assets.dart';
import '../../core/media_query.dart';
import '../../theme/app_color.dart';
import '../../widgets/appdrawer.dart';
import '../../widgets/menucard.dart';
import 'model/menumodel.dart';
import 'msw_submenu.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<RoundedIconButtonModel> mainMenuMaster = [
    RoundedIconButtonModel(
      icon: ship,
      text: "Maritime\n Single Window",
      targetPage: const MswSubmenu(),
      containerColor: AppColors.lightOrange2 ,
    ),
    // RoundedIconButtonModel(
    //   icon: search,
    //   text: "Maritime\n Single Window",
    //   targetPage: const MswSubmenu(),
    //   containerColor: AppColors.lightPurple,
    // ),
    // RoundedIconButtonModel(
    //   icon: search,
    //   text: "Maritime\n Single Window",
    //   targetPage: const MswSubmenu(),
    //   containerColor: AppColors.lightPurple,
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white, size: 32),
        toolbarHeight: 60,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF0057D8),
                Color(0xFF1c86ff),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        actions: [
          SvgPicture.asset(
            userSettings,
            height: 25,
          ),
          const SizedBox(
            width: 10,
          ),
          SvgPicture.asset(
            notificationBell,
            height: 25,
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      drawer: Appdrawer(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(
            vertical: ScreenDimension.onePercentOfScreenHight *
                AppDimensions.defaultPageVerticalPadding,
            horizontal: ScreenDimension.onePercentOfScreenWidth *
                AppDimensions.cardPadding),
        decoration: const BoxDecoration(
          color: AppColors.background,
        ),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1.1,
                ),
                itemCount: mainMenuMaster.length,
                itemBuilder: (context, index) {
                  return RoundedIconButtonNew(
                    icon: mainMenuMaster[index].icon,
                    text: mainMenuMaster[index].text,
                    targetPage: mainMenuMaster[index].targetPage,
                    containerColor: mainMenuMaster[index].containerColor,
                    iconColor: AppColors.textColorPrimary,
                    textColor: AppColors.textColorPrimary,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
