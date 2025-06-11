
import 'package:codex_pcs/core/img_assets.dart';
import 'package:codex_pcs/screens/login/pages/get_started_screen.dart';
import 'package:codex_pcs/screens/login/pages/privacy_policy.dart';
import 'package:codex_pcs/screens/menu/dashboard.dart';
import 'package:codex_pcs/utils/common_utils.dart';
import 'package:flutter/material.dart';

import '../../../api/app_service.dart';
import '../../../core/dimensions.dart';
import '../../../core/global.dart';
import '../../../core/media_query.dart';
import '../../../theme/app_color.dart';
import '../../../utils/role_util.dart';
import '../../../widgets/buttons.dart';
import '../../../widgets/snackbar.dart';
import '../../onboarding.dart';
import '../model/login_response_model.dart';
import 'forgot_password.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = true;
  bool isLoading=false;
  final formKeyForMail = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.white,
        child: Container(
          width: double.infinity,

          decoration:  BoxDecoration(
            gradient: const LinearGradient(colors: [
              AppColors.primary,
              AppColors.secondary,
            ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,),
              borderRadius:BorderRadius.only(
                  bottomLeft: Radius.circular(ScreenDimension.onePercentOfScreenWidth * 6)
              )


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
                    horizontal: ScreenDimension.onePercentOfScreenWidth*AppDimensions.headingTextHorizontalPadding,
                  ),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "MSW \n",
                          style:TextStyle(
                              fontSize: ScreenDimension.textSize * AppDimensions.headingText,
                              color: AppColors.white,
                              fontWeight: FontWeight.w700,
                            ),

                        ),
                        TextSpan(
                          text: "Maritime Single Window",
                          style:  TextStyle(
                              fontSize: ScreenDimension.textSize * AppDimensions.headingText,
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
                  right: 0,
                  left: 0,
                  child: Column(
                    children: [
                      Container(
                        height:ScreenDimension.onePercentOfScreenHight*75,
                        padding: EdgeInsets.all(
                            ScreenDimension.onePercentOfScreenHight * AppDimensions.cardPadding),
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius:BorderRadius.only(
                              topRight: Radius.circular(ScreenDimension.onePercentOfScreenWidth * AppDimensions.cardBorderRadiusCurve),
                              topLeft: Radius.circular(ScreenDimension.onePercentOfScreenWidth * AppDimensions.cardBorderRadiusCurve),
                            )

                        ),
                        child:Form(
                          key: formKeyForMail,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Login",
                                    style:  TextStyle(
                                        color: AppColors.textColorPrimary,
                                        letterSpacing: 0.8,
                                        fontSize: ScreenDimension.textSize * AppDimensions.headingText,
                                        fontWeight: FontWeight.w700)),

                                ],),
                              SizedBox(
                                height: ScreenDimension.onePercentOfScreenHight*2,
                              ),
                              TextFormField(
                                controller: usernameController,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                    labelText: 'User Id',
                                    contentPadding: EdgeInsets.only(left:8 ),
                                    suffixIcon: Icon(Icons.person_2_outlined),
                                    suffixIconColor: AppColors.primary),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Username Required.';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: ScreenDimension.onePercentOfScreenHight*1.5,
                              ),
                              TextFormField(
                                controller: passwordController,
                                obscureText: isPasswordVisible,
                                decoration:  InputDecoration(
                                    labelText: 'Password',
                                    contentPadding: const EdgeInsets.only(left:8 ),
                                    suffixIcon: IconButton(
                                      icon: Icon(

                                        isPasswordVisible
                                            ? Icons.visibility_off_outlined
                                            :Icons.visibility_outlined ,
                                        color: AppColors.primary,
                                      ),
                                      onPressed: () {

                                        setState(() {
                                          isPasswordVisible = !isPasswordVisible;
                                        });
                                      },
                                    ),
                                    suffixIconColor: AppColors.primary),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Password Required.';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: ScreenDimension.onePercentOfScreenHight*2.5,
                              ),
                              ButtonWidgets.buildRoundedGradientButton(text: "LOGIN", press: (){
                                if (formKeyForMail.currentState!.validate()){
                                  Utils.hideKeyboard(context);
                                  getUserAuthenticationDetails();
                                }

                                // Navigator.pushReplacement(
                                //   context,
                                //   MaterialPageRoute(builder: (_) => const OnboardingScreen()),
                                // );
                              }),
                              SizedBox(height: ScreenDimension.onePercentOfScreenHight * 2,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    child: Row(
                                      children: [
                                        const Icon(Icons.arrow_back_ios_rounded,color: AppColors.textColorPrimary,),
                                        Text(
                                          "Back",
                                          style:  TextStyle(
                                              color: AppColors.primary,
                                              letterSpacing: 0.8,
                                              fontSize: ScreenDimension.textSize * AppDimensions.titleText,
                                              fontWeight: FontWeight.w700)),

                                      ],
                                    ),
                                    onTap: (){
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (_) => const GetStartedScreen()),
                                      );
                                    },
                                  ),
                                  GestureDetector(
                                    child: Text(
                                      "Forgot Password",
                                      style: TextStyle(
                                          color: AppColors.primary,
                                          letterSpacing: 0.8,
                                          fontSize: ScreenDimension.textSize * AppDimensions.titleText,
                                          fontWeight: FontWeight.w700)),
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (_)=>const ForgotPassword()));
                                    },
                                  ),

                                ],
                              ),
                              const Spacer(),
                              (configMaster.clientID=="2")? Image.asset(
                                mpbad,
                                height: 100,
                              ):Image.network(
                                '${configMaster.applicationUIURL}${configMaster.clientLogo}',
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                        : null,
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.error);
                                },
                              ),
                              SizedBox(height: ScreenDimension.onePercentOfScreenHight * 0.5,),
                              InkWell(
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Read ",
                                        style:  TextStyle(
                                            fontSize: ScreenDimension.textSize * AppDimensions.bodyTextMedium,
                                            color: AppColors.textColorPrimary,
                                            fontWeight: FontWeight.w500,
                                          ),

                                      ),
                                      TextSpan(
                                        text: "Privacy Policy",
                                        style: TextStyle(
                                            fontSize: ScreenDimension.textSize *AppDimensions.bodyTextMedium,
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.w500,
                                          ),

                                      ),
                                      TextSpan(
                                        text: " and ",
                                        style: TextStyle(
                                            fontSize: ScreenDimension.textSize * AppDimensions.bodyTextMedium,
                                            color: AppColors.textColorPrimary,
                                            fontWeight: FontWeight.w500,
                                          ),

                                      ),
                                      TextSpan(
                                        text: "Terms & Conditions",
                                        style: TextStyle(
                                            fontSize: ScreenDimension.textSize *  AppDimensions.bodyTextMedium,
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.w500,
                                          ),

                                      ),

                                    ],
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                onTap: (){
                                  _showPrivacyPolicyBottomSheet(context);
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: ScreenDimension.onePercentOfScreenHight * 2),
                                child: Text("Kale Logistics Solution", style: TextStyle(
                                  color: AppColors.textColorSecondary, fontSize: ScreenDimension.textSize * AppDimensions.bodyTextMedium, fontWeight: FontWeight.w400,
                                ),),
                              ),

                            ],
                          ),
                        ) ,
                      ),

                    ],
                  )),
              isLoading
                  ? Utils.tintLoader()
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  void getUserAuthenticationDetails() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await ApiService().request(
        endpoint: "/api_pcs1/Login/GetUserAuthenticationDetails",
        method: "POST",
        includeToken: false,
        body: {
          "Loginid": usernameController.text.trim(),
          "Password": passwordController.text.trim(),
          "Country": "IN",
        },
      );

      if (response is Map<String, dynamic> && response["StatusCode"] == 200) {
        loginDetailsMaster=LoginDetails.fromJson(response["data"]);
        Utils.prints("Login firstname:", loginDetailsMaster.firstName);
        OrganizationService.setUserData(loginDetailsMaster);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const Dashboard()),(route) => false,);
      }
      else {
        CustomSnackBar.show(context, message: "${response["StatusMessage"]}",backgroundColor: Colors.red);
        Utils.prints("Login failed:", "${response["StatusMessage"]}");
      }
    } catch (e) {
      print("API Call Failed: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showPrivacyPolicyWebView(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PrivacyPolicyWebView(),
      ),
    );
  }

  // Method 3: Show in bottom sheet
  void _showPrivacyPolicyBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.8,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Privacy Policy',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: const PrivacyPolicyWebView(showAppBar: false),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
