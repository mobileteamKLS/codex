import 'package:codex_pcs/screens/login/pages/login.dart';
import 'package:flutter/material.dart';

import '../../../api/app_service.dart';
import '../../../core/dimensions.dart';
import '../../../core/global.dart';
import '../../../core/img_assets.dart';
import '../../../core/media_query.dart';
import '../../../theme/app_color.dart';
import '../../../utils/common_utils.dart';
import '../../../widgets/buttons.dart';
import '../../../widgets/dropdown.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  bool isLoading=false;
  late Future<List<ConfigurationData>> _countriesFuture;
  ConfigurationData? _selectedCountry;


  @override
  void initState() {
    super.initState();
    _loadCountries();
  }
  @override
  void didChangeDependencies() {
    precacheImage(const AssetImage(loginBgImage), context);
    super.didChangeDependencies();
  }


  void _loadCountries() {
    _countriesFuture = getAllRegions();
  }

  @override
  Widget build(BuildContext context) {
    ScreenDimension().init(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(loginBgImage), fit: BoxFit.cover),
        ),
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: Stack(
          children: [
            Positioned(
              top: 90,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenDimension.onePercentOfScreenWidth *
                      AppDimensions.headingTextHorizontalPadding,
                ),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Let's Get Started, \n",
                        style: TextStyle(
                          fontSize: ScreenDimension.textSize *
                              AppDimensions.headingText,
                          color: AppColors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: "Select your region",
                        style: TextStyle(
                          fontSize: ScreenDimension.textSize *
                              AppDimensions.headingText,
                          color: AppColors.white,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                right: 10,
                left: 10,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(
                          ScreenDimension.onePercentOfScreenHight *
                              AppDimensions.cardPadding),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(
                              ScreenDimension.onePercentOfScreenWidth *
                                  AppDimensions.cardBorderRadiusCurve)),
                      child: Column(
                        children: [
                          FutureBuilder<List<ConfigurationData>>(
                            future: _countriesFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.error_outline, color: Colors.red, size: 48),
                                      const SizedBox(height: 16),
                                      const Text(
                                        'Error loading Regions',
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 16),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          textStyle: const TextStyle(color: Colors.white
                                          )
                                        ),
                                        onPressed: () {
                                          _loadCountries();
                                        },
                                        child: const Text('Retry',style: TextStyle(color: Colors.white),),
                                      ),
                                    ],
                                  ),
                                );
                              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                return const Center(child: Text('No countries available'));
                              } else {
                                return CountryDropdown(
                                  countries: snapshot.data!,
                                  onChanged: (ConfigurationData? country) {
                                    setState(() {
                                      _selectedCountry = country;
                                      configMaster=country!;
                                      mobileBaseURL=country.mobileAppURL;
                                    });
                                    print('Selected country: ${country?.countryCode}');
                                    if (country != null) {
                                      print('Community Code: ${country.communityCode}');
                                      print('Mobile App URL: ${country.mobileAppURL}');
                                      print('Mobile App URL--: $mobileBaseURL');
                                    }
                                  },
                                );
                              }
                            },
                          ),
                          SizedBox(
                            height: ScreenDimension.onePercentOfScreenHight,
                          ),
                          ButtonWidgets.buildRoundedGradientButton(
                              text: "Continue",
                              press:_selectedCountry==null?null: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignInScreen(),
                                  ),
                                  (route) => false,
                                );
                              }),
                          SizedBox(
                            height: ScreenDimension.onePercentOfScreenHight * 2,
                          ),
                          Text("App Version 1.0",
                              style: TextStyle(
                                  color: AppColors.textColorSecondary,
                                  letterSpacing: 0.8,
                                  fontSize: ScreenDimension.textSize *
                                      AppDimensions.bodyTextMedium,
                                  fontWeight: FontWeight.w400)),

                          SizedBox(
                            height:
                                ScreenDimension.onePercentOfScreenHight * 0.5,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical:
                              ScreenDimension.onePercentOfScreenHight * 2),
                      child: Text(
                        "Kale Logistics Solution",
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: ScreenDimension.textSize *
                              AppDimensions.bodyTextMedium,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Future<List<ConfigurationData>> getAllRegions() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await ApiService().request(
        endpoint: "/api_pcs1/MobileApp/GetMobileAppConfiguration",
        method: "GET",
        body: {
        },
        includeApiKey: false,
        includeToken: false,
      );

      if (response is Map<String, dynamic> && response["StatusCode"] == 200) {
        final List<dynamic> countriesJson = response['data'];
        setState(() {
          isLoading = false;
        });
        return countriesJson.map((json) => ConfigurationData.fromJson(json)).toList();
      } else {
        setState(() {
          isLoading = false;
        });
        throw Exception('Failed to load countries');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("API Call Failed: $e");
      throw Exception('Error fetching countries: $e');
    }
  }
}
