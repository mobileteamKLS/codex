import 'package:codex_pcs/core/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../core/dimensions.dart';
import '../core/img_assets.dart';
import '../core/media_query.dart';
import '../screens/login/pages/login.dart';
import '../theme/app_color.dart';
import '../utils/common_utils.dart';
import 'custom_text.dart';

class CustomDivider extends StatelessWidget {
  final double space;
  final Color color;
  final bool hascolor;
  double? height;
  double? thickness;

  CustomDivider(
      {Key? key,
        this.height = 0.5,
        this.thickness = 0.5,
        this.space = 20,
        this.color = AppColors.black,
        this.hascolor = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
            color: hascolor == true
                ? color.withOpacity(0.2)
                : color.withOpacity(0),
            height: height,
            thickness: thickness),
      ],
    );
  }
}

class Appdrawer extends StatefulWidget {
  const Appdrawer({super.key});

  @override
  State<Appdrawer> createState() => _AppdrawerState();
}

class _AppdrawerState extends State<Appdrawer> {
  @override
  Widget build(BuildContext context) {
    return  Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildDrawerHeader(),
        ],
      ),
    );
  }
  Widget _buildDrawerHeader() {
    return SizedBox(
      // height: ScreenDimension.onePercentOfScreenHight * 29,
      child: DrawerHeader(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // _buildLogoSection(),
            SizedBox(height: ScreenDimension.onePercentOfScreenHight),
            // CustomDivider(
            //   space: 0,
            //   color: AppColors.textColorPrimary,
            //   hascolor: true,
            //   thickness: 1,
            // ),
            SizedBox(height: ScreenDimension.onePercentOfScreenHight),
            _buildProfileSection(),
          ],
        ),
      ),
    );
  }

  // Widget _buildLogoSection() {
  //   return Expanded(
  //     child: Row(
  //       children: [
  //         Image.asset(
  //           lpaiImage2,
  //           height: ScreenDimension.onePercentOfScreenHight * 7,
  //         ),
  //         SizedBox(width: ScreenDimension.onePercentOfScreenWidth),
  //         Text.rich(
  //           TextSpan(
  //             children: [
  //               TextSpan(
  //                 text: "Land Ports \n",
  //                 style: TextStyle(
  //                   fontSize: ScreenDimension.textSize * AppDimensions.bodyTextLarge,
  //                   color: const Color(0xff266d96),
  //                   fontWeight: FontWeight.w800,
  //                   height: 1.0,
  //                 ),
  //               ),
  //               TextSpan(
  //                 text: "Authority of India\n",
  //                 style: TextStyle(
  //                   fontSize: ScreenDimension.textSize * AppDimensions.bodyTextLarge,
  //                   color: const Color(0xff266d96),
  //                   fontWeight: FontWeight.w800,
  //                   height: 1.0,
  //                 ),
  //               ),
  //               TextSpan(
  //                 text: "Systematic Seamless Secure",
  //                 style: TextStyle(
  //                   fontSize: ScreenDimension.textSize * 1.0,
  //                   color: AppColors.textColorPrimary,
  //                   fontWeight: FontWeight.w600,
  //                 ),
  //               ),
  //             ],
  //           ),
  //           textAlign: TextAlign.start,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildProfileSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "PROFILE",
          fontColor: AppColors.textColorPrimary,
          fontSize: ScreenDimension.textSize * AppDimensions.TEXTSIZE_1_3,
          fontWeight: FontWeight.w500,
          textAlign: TextAlign.start,
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.gradient1,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.draft,
                radius: ScreenDimension.onePercentOfScreenHight * AppDimensions.TEXTSIZE_2_3,
                child: Text(loginDetailsMaster.firstName[0],style: const TextStyle(color: AppColors.cardTextColor),),

              ),
              SizedBox(width: ScreenDimension.onePercentOfScreenWidth * AppDimensions.WIDTH2),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                  CustomText(
                    text: loginDetailsMaster.firstName,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w600,
                    fontColor: AppColors.textColorPrimary,
                    fontSize: ScreenDimension.textSize * AppDimensions.TEXTSIZE_1_5,
                  ),
                  CustomText(
                    text: loginDetailsMaster.orgTypeName,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w600,
                    fontColor: AppColors.textColorPrimary,
                    fontSize: ScreenDimension.textSize * AppDimensions.TEXTSIZE_1_2,
                  ),
                ],),
              ),
              InkWell(
                onTap: () async {
                  // Navigator.pop(context);
                  bool? isTrue =
                      await Utils.confirmationDialog(context,"Are you sure you want to log out ?","Log out");
                  if(isTrue!){
                    Navigator.pushAndRemoveUntil(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const SignInScreen(),
                      ),
                          (route) => false,
                    );
                  }

                },
                child: SvgPicture.asset(
                  logout,
                  height: ScreenDimension.onePercentOfScreenHight * AppDimensions.ICONSIZE_2_6,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
