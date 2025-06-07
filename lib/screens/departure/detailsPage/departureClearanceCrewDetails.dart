// import 'dart:io';
//
// import 'package:codex_pcs/screens/vessel/page/vessel_list.dart';
// import 'package:codex_pcs/widgets/snackbar.dart';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:dio/dio.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:open_file/open_file.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:path_provider/path_provider.dart';
// import '../../../api/app_service.dart';
// import '../../../core/dimensions.dart';
// import '../../../core/global.dart';
// import '../../../core/img_assets.dart';
// import '../../../core/media_query.dart';
// import '../../../theme/app_color.dart';
// import '../../../theme/app_theme.dart';
// import '../../../utils/common_utils.dart';
// import '../../../utils/role_util.dart';
// import '../../../widgets/appdrawer.dart';
// import '../../../widgets/buttons.dart';
// import '../../login/model/login_response_model.dart';
// import '../../vessel/model/vessel_details_model.dart';
// import 'model/departuredetailsmodel.dart';
//
// class DepartureClearanceDetails extends StatefulWidget {
//   final LstDepartureCrew crew;
//
//   const DepartureClearanceDetails(
//       {super.key,
//         required this.crew,
// });
//
//   @override
//   State<DepartureClearanceDetails> createState() => _DepartureClearanceDetailsState();
// }
//
// class _DepartureClearanceDetailsState extends State<DepartureClearanceDetails> {
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(children: [
//       Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             'Crew Details',
//             style: TextStyle(color: Colors.white),
//           ),
//           iconTheme: const IconThemeData(color: Colors.white, size: 32),
//           toolbarHeight: 60,
//           flexibleSpace: Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Color(0xFF0057D8),
//                   Color(0xFF1c86ff),
//                 ],
//                 begin: Alignment.centerLeft,
//                 end: Alignment.centerRight,
//               ),
//             ),
//           ),
//           actions: [
//             // SvgPicture.asset(
//             //   userSettings,
//             //   height: 25,
//             // ),
//             // const SizedBox(
//             //   width: 10,
//             // ),
//           ],
//         ),
//         drawer: Appdrawer(),
//         body: Stack(
//           children: [
//             Container(
//               constraints: const BoxConstraints.expand(),
//               margin: (OrganizationService.isMarineDepartment)
//                   ? const EdgeInsets.only(bottom: 100)
//                   : const EdgeInsets.only(bottom: 0),
//               padding: EdgeInsets.only(
//                 left: ScreenDimension.onePercentOfScreenWidth *
//                     AppDimensions.defaultPageHorizontalPadding,
//                 right: ScreenDimension.onePercentOfScreenWidth *
//                     AppDimensions.defaultPageHorizontalPadding,
//                 bottom: (OrganizationService.isMarineDepartment) ? 0 : 20,
//               ),
//               color: AppColors.background,
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Padding(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: ScreenDimension.onePercentOfScreenWidth,
//                             vertical:
//                             ScreenDimension.onePercentOfScreenHight * 1.5),
//                         child: Row(
//                           children: [
//                             InkWell(
//                               onTap: () {
//                                 Navigator.pop(context);
//                               },
//                               child: const Icon(
//                                 Icons.keyboard_arrow_left_sharp,
//                                 color: AppColors.primary,
//                               ),
//                             ),
//                             const SizedBox(
//                               width: 5,
//                             ),
//
//                           ],
//                         )),
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(12),
//                         boxShadow: const [
//                           BoxShadow(
//                               color: Colors.black12,
//                               blurRadius: 6,
//                               offset: Offset(0, 2)),
//                         ],
//                       ),
//                       child: Column(
//                         children: [
//                           buildSection(
//                               0, "Vessel Details", vesselDetailsContent()),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Positioned(
//               top: 0,
//               left: 0,
//               right: 0,
//               child: IgnorePointer(
//                 child: CustomPaint(
//                   size: Size(MediaQuery.of(context).size.width,
//                       100), // Adjust the height as needed
//                   painter: AppBarPainterGradient(),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//         ]);
//   }
//
//   Widget buildSection(int index, String title, Widget content) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//             child: content,
//           ),
//       ],
//     );
//   }
//
//   Widget infoRow(String label, String value) => Padding(
//     padding: const EdgeInsets.symmetric(vertical: 4),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: AppStyle.sideDescText,
//         ),
//         Text(value, style: AppStyle.defaultTitle),
//       ],
//     ),
//   );
//
//   Widget infoBlock(String label, String value) {
//     return SizedBox(
//       width: (MediaQuery.of(context).size.width - 72) / 2, // Adjust for padding
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             label,
//             style: AppStyle.sideDescText,
//           ),
//           const SizedBox(height: 2),
//           Text(value, style: AppStyle.defaultTitle),
//         ],
//       ),
//     );
//   }
//
//   Widget vesselDetailsContent() {
//     return Wrap(
//       spacing: 16,
//       runSpacing: 12,
//       children: [
//         infoBlock("Name", "${widget.crew.crewListGivenName ?? ""} ${widget.crew.crewListFamilyName ?? ""}"),
//         infoBlock("Rank", widget.crew.crewListRankRating ?? ""),
//         infoBlock("Nationality", widget.crew.nat ?? ""),
//         infoBlock("Date of Birth",
//             vesselDetailsModel.vesselNationalityType ?? ""),
//         infoBlock("Place of Birth", vesselDetailsModel.vesselName ?? ""),
//         infoBlock("Gender", vesselDetailsModel.voyage ?? ""),
//         infoBlock("Date of Embarkation", "=="),
//         infoBlock("Date of Disembarkation", vesselDetailsModel.vesselTypeName ?? ""),
//         infoBlock("Nature of Identity Document", vesselDetailsModel.arrivalDt != null ? Utils.formatStringDate(vesselDetailsModel.arrivalDt, showTime: true):""),
//         infoBlock("Issuing State of Identity Document",  vesselDetailsModel.departureDt != null ? Utils.formatStringDate(vesselDetailsModel.departureDt, showTime: true):""),
//         infoBlock("No. of Identity Document", vesselDetailsModel.flagOfVessel ?? ""),
//         infoBlock("Expiry Date, vesselDetailsModel.berthNo ?? ""),
//         infoBlock("Gross Tonnage", vesselDetailsModel.grt != null
//             ? "${vesselDetailsModel.grt!.toStringAsFixed(3)} ${vesselDetailsModel.grtUnit}"
//             : ""),
//         infoBlock("Net Tonnage", vesselDetailsModel.nrt != null
//             ? "${vesselDetailsModel.nrt!} ${vesselDetailsModel.nrtUnit}"
//             : ""),
//         // infoBlock("Name of Master", vesselDetailsModel.name ?? ""),
//         infoBlock(
//           "Last Port of Registry",
//           "${vesselDetailsModel.lastPortCode ?? ""} - ${vesselDetailsModel.lastPortName ?? ""}",
//         ),
//         infoBlock("Next Port of Registry", "${vesselDetailsModel.nextPortCode ?? ""} - ${vesselDetailsModel.nextPortName ?? ""}",),
//         infoBlock("Number of Crew(s)", vesselDetailsModel.noofCrew != null
//             ? "${vesselDetailsModel.noofCrew!}"
//             : ""),
//         infoBlock("Number of Passengers(s)",
//             vesselDetailsModel.passengersOnBoard != null
//                 ? "${vesselDetailsModel.passengersOnBoard!}"
//                 : ""),
//         infoBlock(
//             "Name of Captain", vesselDetailsModel.nameofCaption ?? ""),
//         infoBlock(
//           "Port of Registry",  "${vesselDetailsModel.portRegistryCode ?? ""} - ${vesselDetailsModel.portRegistryName ?? ""}",),
//         infoBlock("Port of Departure",
//             "${vesselDetailsModel.departurePortCode ?? ""} - ${vesselDetailsModel.departurePortPortName ?? ""}"),
//       ],
//     );
//   }
//
//
//
//
//
//
// }