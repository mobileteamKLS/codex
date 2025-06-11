import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/dimensions.dart';
import '../../core/img_assets.dart';
import '../../core/media_query.dart';
import '../../theme/app_color.dart';
import '../../widgets/appdrawer.dart';
import '../../widgets/header.dart';
import '../departure/listPage/departureClearanceList.dart';
import '../epan/pages/epan_list.dart';
import '../scn/page/scn_listing.dart';
import '../vessel/page/vessel_list.dart';
import 'model/menumodel.dart';

class MswSubmenu extends StatefulWidget {
  const MswSubmenu({super.key});

  @override
  State<MswSubmenu> createState() => _MswSubmenuState();
}

class _MswSubmenuState extends State<MswSubmenu> {
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
            Row(
              children: [
                Expanded(
                    child: HeaderWidget(
                  title: 'Maritime Single Window (MSW)',
                  onBack: () {
                    Navigator.pop(context);
                  },
                )),
              ],
            ),
            const SizedBox(height: 8,),
            const NavigationCard(
              icon: ship,
              title: 'Ship Registration',
              targetPage: VesselListing(),
            ),
            const NavigationCard(
              icon: ticket,
              title: 'Ship Call Number (SCN)',
              targetPage: Scnlisting(),
            ),
            const NavigationCard(
              icon: locationCheck,
              title: 'Pre-Arrival Notification (PAN)',
              targetPage: EpanListing(),
            ),
            // const NavigationCard(
            //   icon: anchorCheck,
            //   title: 'Arrival Clearance',
            //   targetPage: VesselListing(),
            // ),
            // const NavigationCard(
            //   icon: doubleCheck,
            //   title: 'Departure Clearance',
            //   targetPage: DepartureListing(),
            // ),

          ],
        ),
      ),
    );
  }
}
