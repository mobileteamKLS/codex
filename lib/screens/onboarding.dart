
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/dimensions.dart';
import '../core/img_assets.dart';
import '../core/media_query.dart';
import '../modal/onboarding_data.dart';
import '../theme/app_color.dart';
import '../widgets/buttons.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController controller;

  @override
  void initState() {
    controller = PageController();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));
    super.initState();
  }

  int currentPage = 0;
  List colors = const [
   AppColors.white,
   AppColors.white,
   AppColors.white,
   AppColors.white,
  ];

  List<OnboardingData> contents = [

    OnboardingData(
      title: "Welcome to Anchorage Logistics Marketplace",
      image: welcomeImage,
      desc: "ALM is a logistics platform that simplifies cargo booking, pricing, and management for efficient freight services.",
    ),
    OnboardingData(
      title: "Seamless Air Cargo Trade",
      image: welcomeImage,
      desc: "Effortless global air cargo booking and shipping management for shippers, freight forwarders, and airlines on one platform.",
    ),
    OnboardingData(
      title: "Finish",
      image: welcomeImage,
      desc: "You're all set! Explore the features, view updates, and track progress with ease.",
    ),
  ];


  Future<void> completeOnboarding() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setBool('onboardingSeen', true);
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (_) => const ProviderDashboardScreen()),
    // );
  }

  @override
  Widget build(BuildContext context) {
    ScreenDimension().init(context);


    return Scaffold(
      backgroundColor:AppColors.white,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            left: 0,
            child: PageView.builder(
              physics: const BouncingScrollPhysics(),
              controller: controller,
              onPageChanged: (value) => setState(() => currentPage = value),
              itemCount: contents.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: ScreenDimension.onePercentOfScreenWidth * 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        contents[i].image,
                        height:  ScreenDimension.onePercentOfScreenHight * 25,
                      ),
                      SizedBox(
                        height:  ScreenDimension.onePercentOfScreenHight * 3,
                      ),
                     Text(contents[i].title,
                          style: TextStyle(
                            color: AppColors.textColorPrimary,fontSize: ScreenDimension.textSize*AppDimensions.headingText,fontWeight: FontWeight.w600
                          ),
                          textAlign: TextAlign.center),
                      SizedBox(height: ScreenDimension.onePercentOfScreenHight * 2),
                      Text(  contents[i].desc,
                          style: TextStyle(
                              color: AppColors.textColorSecondary,fontSize: ScreenDimension.textSize*AppDimensions.bodyTextMedium,fontWeight: FontWeight.w400
                          ),
                          textAlign: TextAlign.center),
                    ],
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                if (currentPage == 0)
                  Padding(
                    padding:   const EdgeInsets.all(30),
                    child: ButtonWidgets.buildRoundedGradientButton(
                      text: 'Get Started',
                      press: () {
                        controller.nextPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeIn,
                        );
                      },
                    ),
                  )else if(currentPage + 1 == contents.length)
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: ButtonWidgets.buildRoundedGradientButton(
                      text: 'Start',
                      press: completeOnboarding,
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            controller.jumpToPage(5);
                          },
                          style: TextButton.styleFrom(
                            elevation: 0,
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: ScreenDimension.screenWidth * 4,
                            ),
                          ),
                          child: Text( "Skip",
                              style: TextStyle(
                                  color: AppColors.primary,fontSize: ScreenDimension.textSize*1.9,fontWeight: FontWeight.w400
                              ),
                              textAlign: TextAlign.center),
                        ),

                        SizedBox(height: ScreenDimension.onePercentOfScreenHight,),

                        ButtonWidgets.buildRoundedGradientButton(
                          text: 'Next',
                          press: () {
                            controller.nextPage(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeIn,
                            );
                          },
                        )

                      ],
                    ),
                  )
              ],
            ),
          ),

          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: SizedBox(
              height: 3,
              child: LinearProgressIndicator(
                value: (currentPage + 1) / contents.length,
                backgroundColor: AppColors.textFieldBorderColor,
                color: AppColors.primary,
                minHeight: 4.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
