import 'package:codex_pcs/core/global.dart';
import 'package:flutter/material.dart';

import '../../../api/app_service.dart';
import '../../../core/dimensions.dart';
import '../../../core/media_query.dart';
import '../../../theme/app_color.dart';
import '../../../utils/common_utils.dart';
import '../../../widgets/buttons.dart';
import '../../../widgets/snackbar.dart';
import 'login.dart';


class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController userNameController = TextEditingController();
  final formKey=GlobalKey<FormState>();
  bool _isLoading=false;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
            // image: DecorationImage(
            //     image: AssetImage(loginBgImage), fit: BoxFit.cover),
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
                              topLeft: Radius.circular(ScreenDimension.onePercentOfScreenWidth *AppDimensions. cardBorderRadiusCurve),
                            )

                        ),
                        child:Form(
                          key: formKey,
                          child: Column(
                            children: [
                              // SizedBox(
                              //   height: ScreenDimension.onePercentOfScreenHight*3,
                              // ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      "Forgot Password",
                                      style:  TextStyle(
                                          color: AppColors.textColorPrimary,
                                          letterSpacing: 0.8,
                                          fontSize: ScreenDimension.textSize * AppDimensions.headingText,
                                          fontWeight: FontWeight.w900)),

                                ],),
                              SizedBox(
                                height: ScreenDimension.onePercentOfScreenHight*1.5,
                              ),
                              TextFormField(
                                controller: userNameController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                    labelText: 'Registered Username',
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
                                height: ScreenDimension.onePercentOfScreenHight*2.5,
                              ),
                              ButtonWidgets.buildRoundedGradientButton(text: "SEND MAIL",
                                  press: _isLoading?null: (){

                                    if (formKey.currentState!.validate()) {
                                      Utils.hideKeyboard(context);
                                      getPassword();
                                    }
                                  }
                              ),
                              SizedBox(height: ScreenDimension.onePercentOfScreenHight * 2,),
                              GestureDetector(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        "Back to Login",
                                        style: TextStyle(
                                            color: AppColors.primary,
                                            letterSpacing: 0.8,
                                            fontSize: ScreenDimension.textSize *AppDimensions. titleText,
                                            fontWeight: FontWeight.w500)),

                                  ],
                                ),
                                onTap: (){
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const SignInScreen()));
                                },
                              ),
                              const Spacer(),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   crossAxisAlignment: CrossAxisAlignment.center,
                              //   children: [
                              //     Image.asset(lpaiImage2, height: ScreenDimension.onePercentOfScreenHight * 7,),
                              //     SizedBox(width: ScreenDimension.onePercentOfScreenWidth*1,),
                              //     Text.rich(
                              //       TextSpan(
                              //         children: [
                              //           TextSpan(
                              //             text: "Land Ports \n",
                              //             style:TextStyle(
                              //               fontSize: ScreenDimension.textSize * AppDimensions.bodyTextLarge,
                              //               color: const Color(0xff266d96),
                              //               fontWeight: FontWeight.w800,
                              //               height: 1.0,
                              //             ),
                              //
                              //           ),
                              //           TextSpan(
                              //             text: "Authority of India\n",
                              //             style:  TextStyle(
                              //               fontSize: ScreenDimension.textSize * AppDimensions.bodyTextLarge,
                              //               color: const Color(0xff266d96),
                              //               fontWeight: FontWeight.w800,
                              //               height: 1.0,
                              //
                              //             ),
                              //           ),
                              //           TextSpan(
                              //             text: "Systematic Seamless Secure",
                              //             style:  TextStyle(
                              //               fontSize: ScreenDimension.textSize * 1.0,
                              //               color: AppColors.textColorPrimary,
                              //               fontWeight: FontWeight.w600,
                              //
                              //             ),
                              //           ),
                              //
                              //         ],
                              //       ),
                              //       textAlign: TextAlign.start,
                              //     ),
                              //   ], ),
                              SizedBox(height: ScreenDimension.onePercentOfScreenHight * 1,),
                              Text.rich(
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
                                        fontSize: ScreenDimension.textSize *AppDimensions.bodyTextMedium,
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
              _isLoading
                  ? Utils.tintLoader()
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  void getPassword() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await ApiService().request(
        endpoint: "/api_pcs1/Login/GetForgotPwdDetails",
        method: "POST",
        body: {
          "Loginid": userNameController.text.trim(),
          "CountryId": configMaster.countryId,
          "ClientID": int.parse(configMaster.clientID)
        },
        includeToken: false,
      );

      if (response is Map<String, dynamic> && response["StatusCode"] == 200) {
        CustomSnackBar.show(context, message: "${response["StatusMessage"]}",backgroundColor: AppColors.successColor,leftIcon: Icons.check_circle);
      }
      else {
        CustomSnackBar.show(context, message: response["StatusMessage"],backgroundColor: Colors.red);
        Utils.prints("Login failed:", "${response["StatusMessage"]}");
      }
    } catch (e) {
      print("API Call Failed: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
