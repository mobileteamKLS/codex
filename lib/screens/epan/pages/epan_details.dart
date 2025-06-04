import 'dart:io';

import 'package:codex_pcs/widgets/snackbar.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import '../../../api/app_service.dart';
import '../../../core/dimensions.dart';
import '../../../core/global.dart';
import '../../../core/img_assets.dart';
import '../../../core/media_query.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/role_util.dart';
import '../../../widgets/appdrawer.dart';
import '../../../widgets/buttons.dart';
import '../../login/model/login_response_model.dart';
import '../model/epan_details_model.dart';
import 'epan_list.dart';

class EpanDetails extends StatefulWidget {
  final String refNo;
  final String vesselId;
  final int pvrId;
  final int marineBranchId;
  final bool isSubmit;

  const EpanDetails(
      {super.key,
      required this.refNo,
      required this.pvrId,
      required this.marineBranchId,
      required this.isSubmit,
      required this.vesselId});

  @override
  State<EpanDetails> createState() => _EpanDetailsState();
}

class _EpanDetailsState extends State<EpanDetails> {
  List<bool> _expanded = List.filled(10, false);
  bool isLoading = false;
  EpanDetailsModel vesselDetailsModel = EpanDetailsModel();
  TextEditingController commentController = TextEditingController();
  bool A = true;
  bool B = true;

  void _toggleAll() {
    bool expand = !_expanded.every((e) => e);
    setState(() {
      _expanded = List.filled(_expanded.length, expand);
    });
  }

  void getVesselByID() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await ApiService().request(
        endpoint: "/api_pcs1/epan/GetEpanViewByID",
        method: "POST",
        body: {
          "Id": widget.pvrId,
          "OrgId": loginDetailsMaster.organizationId,
          "OperationType": 6,
          "IsMY": int.parse(configMaster.clientID),
          "OrgBranchId": loginDetailsMaster.organizationBranchId,
          "CountryID": configMaster.countryId,
          "OrgType": loginDetailsMaster.orgTypeName
        },
      );

      if (response is Map<String, dynamic> && response["StatusCode"] == 200) {
        vesselDetailsModel = EpanDetailsModel.fromJson(response["data"]);
        print("{vesselDetailsModel.doesyourCompliant ?? 0}");
      } else {
        Utils.prints("failed:", "${response["StatusMessage"]}");
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print("API Call Failed: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void approveReject(String comment, int opType) async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await ApiService().request(
        endpoint: "/api_pcs1/Epan/SetApproval",
        method: "POST",
        body: {
          "OrgId": loginDetailsMaster.organizationId,
          "OperationType": 7,
          "CreatedBy": loginDetailsMaster.userId,
          "UpdatedBy": loginDetailsMaster.userId,
          "BranchId": loginDetailsMaster.organizationBranchId,
          "Status" : opType,
          "NAId": widget.pvrId,
          "Remark": comment
        },
      );

      if (response is Map<String, dynamic> && response["StatusCode"] == 200) {
        Utils.prints("Status", response["StatusMessage"]);
        CustomSnackBar.show(context,
            message: response["StatusMessage"],
            backgroundColor: AppColors.successColor,
            leftIcon: Icons.check_circle);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const EpanListing()),
        );
      } else {
        Utils.prints("Login failed:", "${response["StatusMessage"]}");
        CustomSnackBar.show(context,
            message: response["StatusMessage"], backgroundColor: Colors.red);
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print("API Call Failed: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getVesselByID();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        appBar: AppBar(
          title: const Text(
            'PAN',
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
            // SvgPicture.asset(
            //   userSettings,
            //   height: 25,
            // ),
            // const SizedBox(
            //   width: 10,
            // ),
          ],
        ),
        drawer: Appdrawer(),
        body: Stack(
          children: [
            Container(
              constraints: const BoxConstraints.expand(),
              margin: (OrganizationService.isMarineDepartment)
                  ? const EdgeInsets.only(bottom: 100)
                  : const EdgeInsets.only(bottom: 0),
              padding: EdgeInsets.only(
                left: ScreenDimension.onePercentOfScreenWidth *
                    AppDimensions.defaultPageHorizontalPadding,
                right: ScreenDimension.onePercentOfScreenWidth *
                    AppDimensions.defaultPageHorizontalPadding,
                bottom: (OrganizationService.isMarineDepartment) ? 0 : 20,
              ),
              color: AppColors.background,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenDimension.onePercentOfScreenWidth,
                            vertical:
                                ScreenDimension.onePercentOfScreenHight * 1.5),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.keyboard_arrow_left_sharp,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Text(widget.refNo,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color: AppColors.textColorPrimary,
                                  )),
                            ),
                            GestureDetector(
                              onTap: _toggleAll,
                              child: Text(
                                _expanded.every((e) => e)
                                    ? 'Collapse All'
                                    : 'Expand All',
                                style:
                                    const TextStyle(color: AppColors.primary),
                              ),
                            ),
                          ],
                        )),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(0, 2)),
                        ],
                      ),
                      child: Column(
                        // children: [
                        //   // buildSection(
                        //   //     0, "Vessel Details", vesselDetailsContent()),
                        //   // buildSection(
                        //   //     1, "Vessel Contact Details", vesselContactContent()),
                        //   // buildSection(
                        //   //     2, "Vessel Dimensions", vesselDimensionContent()),
                        //   // buildSection(
                        //   //     3, "Cargo / Passenger Details", cargoPassengerContent()),
                        //   // buildSection(
                        //   //     4, "ISPS Details", ispsDetailsContent()),
                        //
                        //
                        // ],
                        children: buildAllSections(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: IgnorePointer(
                child: CustomPaint(
                  size: Size(MediaQuery.of(context).size.width,
                      100), // Adjust the height as needed
                  painter: AppBarPainterGradient(),
                ),
              ),
            ),
          ],
        ),
        bottomSheet: RoleConditionWidget(
          condition: (OrganizationService.isMarineDepartment &&
              widget.isSubmit &
                  (widget.marineBranchId ==
                      loginDetailsMaster.organizationBranchId)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              color: Colors.white,
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ButtonWidgets.buildRoundedGradientButton(
                          text: 'Reject',
                          isborderButton: true,
                          textColor: AppColors.primary,
                          verticalPadding: 10,
                          press: () {
                            showRejectWithCommentsBottomSheet(
                              context: context,
                              onSubmit: (comment) {
                                approveReject(comment, 4);
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ButtonWidgets.buildRoundedGradientButton(
                          text: 'Approve',
                          press: () async {
                            bool? isTrue = await Utils.confirmationDialog(
                                context,
                                "Are you sure you want to Approve ?",
                                "Approve");
                            if (isTrue!) {
                              approveReject("", 3);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      isLoading ? Utils.tintLoader() : const SizedBox(),
    ]);
  }

  Widget ispsMeasuresComplaintsContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        fullWidthInfoBlock(
            "Has a DoS been issued at the last port/marine facility?",
            (vesselDetailsModel.ispScodecomplaints1?.toInt() == 1)
                ? "Yes"
                : "No"),
        fullWidthInfoBlock(
            "Was a full watch kept at all vessel's access during stay in port?",
            (vesselDetailsModel.ispScodecomplaints2?.toInt() == 1)
                ? "Yes"
                : "No"),
        fullWidthInfoBlock(
            "Are crew as specified in the crew list?",
            (vesselDetailsModel.ispScodecomplaints3?.toInt() == 1)
                ? "Yes"
                : "No"),
        fullWidthInfoBlock(
            "Has a checks been made on stoways or others unlawful person onboard?",
            (vesselDetailsModel.ispScodecomplaints4?.toInt() == 1)
                ? "Yes"
                : "No"),
        fullWidthInfoBlock(
            "Are cargo on board duly manifest?",
            (vesselDetailsModel.ispScodecomplaints5?.toInt() == 1)
                ? "Yes"
                : "No"),
        fullWidthInfoBlock(
            "Is cargo storage plan available?",
            (vesselDetailsModel.ispScodecomplaints6?.toInt() == 1)
                ? "Yes"
                : "No"),
        fullWidthInfoBlock(
            "Any stores, spare part and requisition received at last port/marine facility?",
            (vesselDetailsModel.ispScodecomplaints7?.toInt() == 1)
                ? "Yes"
                : "No"),
        fullWidthInfoBlock(
            "Are records kept for the above?",
            (vesselDetailsModel.ispScodecomplaints8?.toInt() == 1)
                ? "Yes"
                : "No"),
        fullWidthInfoBlock(
            "Are dangerous goods onboard?If above is Yes,State IMDG Code Class",
            (vesselDetailsModel.ispScodecomplaints9?.toInt() == 1)
                ? "Yes"
                : "No",showDivider: false),
        SizedBox(
            height:
            ((vesselDetailsModel.ispScodecomplaints9?.toInt() == 1))
                ? 8
                : 0),
        ((vesselDetailsModel.ispScodecomplaints9?.toInt() == 1))
            ? Text(
          vesselDetailsModel.ispScodecomplaints9Yes ?? "",
          style: AppStyle.defaultTitle,
        )
            : const SizedBox(),
        if(vesselDetailsModel.ispScodecomplaints9?.toInt() == 1)const SizedBox(height: 12),
        Divider(
          color: Colors.grey[300],
          thickness: 0.5,
          height: 1,
        ),
        const SizedBox(height: 12),
        fullWidthInfoBlock(
            "	Prohibited goods under UN Security Council / Resolution onboard? If above is Yes,please specify",
            (vesselDetailsModel.ispScodecomplaints10?.toInt() == 1)
                ? "Yes"
                : "No",
            showDivider: false),
        SizedBox(
            height:
            ((vesselDetailsModel.ispScodecomplaints10?.toInt() == 1))
                ? 8
                : 0),
        ((vesselDetailsModel.ispScodecomplaints10?.toInt() == 1))
            ? Text(
          vesselDetailsModel.ispScodecomplaints10Yes ?? "",
          style: AppStyle.defaultTitle,
        )
            : const SizedBox(),
      ],
    );
  }

  Widget ispsSecurityCertificateContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        fullWidthInfoBlock(
            "Was last port of call an ISPS compliant marine facility?",
            (vesselDetailsModel.convention1?.toInt() == 1) ? "Yes" : "No"),

        fullWidthInfoBlock(
            "	Any control measures imposed at last port? if Yes give details?",
            (vesselDetailsModel.convention2?.toInt() == 1) ? "Yes" : "No",showDivider: false),

        SizedBox(
            height:
            ((vesselDetailsModel.convention2?.toInt() == 1))
                ? 8
                : 0),
        ((vesselDetailsModel.convention2?.toInt() == 1))
            ? Text(
          vesselDetailsModel.convention2Yes ?? "",
          style: AppStyle.defaultTitle,
        )
            : const SizedBox(),
        if(vesselDetailsModel.convention2?.toInt() == 1)const SizedBox(height: 12),
        Divider(
          color: Colors.grey[300],
          thickness: 0.5,
          height: 1,
        ),
        const SizedBox(height: 12),

        fullWidthInfoBlock("Have you conducted a SSA for your ship?",
            (vesselDetailsModel.convention3?.toInt() == 1) ? "Yes" : "No"),

        fullWidthInfoBlock("Do you have a SSP onboard the ship?",
            (vesselDetailsModel.convention4?.toInt() == 1) ? "Yes" : "No"),

        fullWidthInfoBlock(
            "If yes to above, is this plan (SSP) being implemented?",
            (vesselDetailsModel.convention5?.toInt() == 1) ? "Yes" : "No"),

        fullWidthInfoBlock("Any ship crew trained as SSO?",
            (vesselDetailsModel.convention6?.toInt() == 1) ? "Yes" : "No"),

        fullWidthInfoBlock(
            "Crew have awareness training on security procedures?",
            (vesselDetailsModel.convention7?.toInt() == 1) ? "Yes" : "No"),

        fullWidthInfoBlock("Has full gangway watch been kept at last port?",
            (vesselDetailsModel.convention8?.toInt() == 1) ? "Yes" : "No"),

        fullWidthInfoBlock("Has there any unlawful boarding at last port?",
            (vesselDetailsModel.convention9?.toInt() == 1) ? "Yes" : "No"),

        fullWidthInfoBlock("Has Stowaway search conducted?",
            (vesselDetailsModel.convention10?.toInt() == 1) ? "Yes" : "No"),

        fullWidthInfoBlock("Has any stowaways found?",
            (vesselDetailsModel.convention11?.toInt() == 1) ? "Yes" : "No"),

        // Last item without divider
        fullWidthInfoBlock(
            "Declaration by master that no unlawful loading done at last port",
            (vesselDetailsModel.convention12?.toInt() == 1) ? "Yes" : "No",
            showDivider: false),
      ],
    );
  }

  Widget tenPortContent(){
    return Column(
      children: [
        Container(color: AppColors.cardBg,
            padding: EdgeInsets.all(8),
            child: portCallsContent()),
        SizedBox(height: 16),
        additionalSecurityReasonSection(),
        SizedBox(height: 16),
        weaponReasonSection(),
      ],
    );
  }

  Widget unSecurityContent() {
    return Container(
      color: AppColors.cardBg,
      padding: EdgeInsets.all(8),
      child: Column(
        children: vesselDetailsModel.prohibitedGoodsDetails?.asMap().entries.map((entry) {
          int index = entry.key;
          var portCall = entry.value;
          bool isLast = index == vesselDetailsModel.prohibitedGoodsDetails!.length - 1;

          return Column(
            children: [
              unSecurityItem(portCall),
              if (!isLast) ...[
                const SizedBox(height: 12),
                Divider(
                  color: Colors.grey[300],
                  thickness: 0.5,
                  height: 1,
                ),
                const SizedBox(height: 12),
              ],
            ],
          );
        }).toList() ?? [],
      ),
    );

  }

  Widget unSecurityItem(ProhibitedGoodsDetails item) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Port label and name
          Text(
            "Country of Origin",
            style: AppStyle.sideDescText,
          ),
          const SizedBox(height: 2),
          Text(
            item.countryOrginName ?? "",
            style: AppStyle.defaultTitle,
          ),
          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Items / Commodity",
                      style: AppStyle.sideDescText,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.itemCommodity ?? "",
                      style: AppStyle.defaultTitle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget portCallsContent() {
    return Column(
      children: vesselDetailsModel.listofLastTenPortofCall?.asMap().entries.map((entry) {
        int index = entry.key;
        var portCall = entry.value;
        bool isLast = index == vesselDetailsModel.listofLastTenPortofCall!.length - 1;

        return Column(
          children: [
            portCallItem(portCall),
            if (!isLast) ...[
              const SizedBox(height: 12),
              Divider(
                color: Colors.grey[300],
                thickness: 0.5,
                height: 1,
              ),
              const SizedBox(height: 12),
            ],
          ],
        );
      }).toList() ?? [],
    );

  }

  Widget portCallItem(ListofLastTenPortofCall portCall) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Port label and name
          Text(
            "Port",
            style: AppStyle.sideDescText,
          ),
          SizedBox(height: 2),
          Text(
           "${portCall.portcode ?? ""}-${portCall.portName ?? ""}",
            style: AppStyle.defaultTitle.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12),

          // Three column layout for dates and security level
          Row(
            children: [
              // Arrival column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Arrival",
                      style: AppStyle.sideDescText,
                    ),
                    SizedBox(height: 2),
                    Text(
                        portCall.arrival != null ? Utils.formatStringDate(portCall.arrival,) ?? "" : "",
                      style: AppStyle.defaultTitle,
                    ),
                  ],
                ),
              ),

              // Departure column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Departure",
                      style: AppStyle.sideDescText,
                    ),
                    SizedBox(height: 2),
                    Text(
                      portCall.departure != null ? Utils.formatStringDate(portCall.departure,) ?? "" : "",
                      style: AppStyle.defaultTitle,
                    ),
                  ],
                ),
              ),

              // Security Level column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Security Level",
                      style: AppStyle.sideDescText,
                    ),
                    SizedBox(height: 2),
                    Text(
                      portCall.secutityLevel??"",
                      style: AppStyle.defaultTitle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget additionalSecurityReasonSection() {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(vesselDetailsModel.lastPortRemark!="")Text(
            "Reason Why the Vessel Has Fewer Than 10 Port Calls :",
            style: AppStyle.sideDescText,
          ),
          if(vesselDetailsModel.lastPortRemark!="")Text(
            vesselDetailsModel.lastPortRemark ?? "" ,
            style: AppStyle.defaultTitle,
          ),
          if(vesselDetailsModel.lastPortRemark!="")SizedBox(height: 6),
          Text(
            "Were there any special or additional security measures taken during any ship/port interface or ship-to-ship activity at the ports mentioned in the last 10 ports of call?",
            style: AppStyle.sideDescText,
          ),

          Text(
            (vesselDetailsModel.specialoradditionalsecurity == null)
                ? ""
                : (vesselDetailsModel.specialoradditionalsecurity == 1 ? "Yes" : "No")
            ,
            style: AppStyle.defaultTitle,
          ),
          SizedBox(
              height:
                  (vesselDetailsModel.specialoradditionalsecurity  == 1)
                      ? 6
                      : 0),
          (vesselDetailsModel.specialoradditionalsecurity  == 1)
              ? Text(
                  "If yes, please specify",
                  style: AppStyle.sideDescText,
                )
              : const SizedBox(),
          SizedBox(
              height:
                  ((vesselDetailsModel.specialoradditionalsecurity ?? 0) == 1)
                      ? 4
                      : 0),
          ((vesselDetailsModel.specialoradditionalsecurity ?? 0) == 1)
              ? Text(
                  vesselDetailsModel.specialoradditionalsecurityYes ?? "",
                  style: AppStyle.defaultTitle,
                )
              : const SizedBox(),
        ],
      ),
    );
  }
  Widget weaponReasonSection() {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Are there any Weapons On Board?",
            style: AppStyle.sideDescText,
          ),
          SizedBox(height: 4),
          Text(
            (vesselDetailsModel.weaponsOnBoard == null)
                ? ""
                : (vesselDetailsModel.weaponsOnBoard == 1 ? "Yes" : "No")
            ,
            style: AppStyle.defaultTitle,
          ),
          SizedBox(
              height:
              (vesselDetailsModel.weaponsOnBoard  == 1)
                  ? 6
                  : 0),
          (vesselDetailsModel.weaponsOnBoard  == 1)
              ? Text(
            "If yes, please refer",
            style: AppStyle.sideDescText,
          )
              : const SizedBox(),
          SizedBox(
              height:
              (vesselDetailsModel.weaponsOnBoard  == 1)
                  ? 4
                  : 0),
          (vesselDetailsModel.weaponsOnBoard == 1)
              ? Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        vesselDetailsModel.weaponsOnBoardFileName??"",
                        style: AppStyle.defaultTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if(vesselDetailsModel.weaponsOnBoardSaverFileName!=null)
                      GestureDetector(
                      child: SvgPicture.asset(
                        download,
                        colorFilter: const ColorFilter.mode(
                            AppColors.primary, BlendMode.srcIn),
                        height: ScreenDimension.onePercentOfScreenHight *
                            AppDimensions.defaultIconSize,
                      ),
                      onTap: () {
                        _downloadDocument(vesselDetailsModel.weaponsOnBoardFileName!,vesselDetailsModel.weaponsOnBoardSaverFileName!,vesselDetailsModel.docFileFolder!);
                      },
                    ),
                  ],
                ),
              ],
            ),
          )
              : const SizedBox(),
        ],
      ),
    );
  }

  Widget attachedDocumentPanContent(){
    return Column(
      children:(vesselDetailsModel.crewUplPanRandomFile!=""||vesselDetailsModel.passengerUplPanRandomFile!=null||vesselDetailsModel.dgCargoUplPanRandomFile!=null)?[
        if(vesselDetailsModel.crewUplPanRandomFile!=null)documentRow("Crew List","-",vesselDetailsModel.crewUplPanActualFile!,vesselDetailsModel.crewUplPanRandomFile!,isExpiry: true,hideDownload: (vesselDetailsModel.crewUplPanActualFile==null ||vesselDetailsModel.crewUplPanActualFile=="")),
        if(vesselDetailsModel.passengerUplPanRandomFile!=null)documentRow("Passenger List","-",vesselDetailsModel.passengerUplPanActualFile!,vesselDetailsModel.passengerUplPanRandomFile!,isExpiry: true,hideDownload: (vesselDetailsModel.passengerUplPanActualFile==null ||vesselDetailsModel.passengerUplPanActualFile=="")),
        if(vesselDetailsModel.dgCargoUplPanRandomFile!=null)documentRow("DG Cargo","-",vesselDetailsModel.dgCargoUplPanActualFile!,vesselDetailsModel.dgCargoUplPanRandomFile!,isExpiry: true,hideDownload: (vesselDetailsModel.dgCargoUplPanActualFile==null ||vesselDetailsModel.dgCargoUplPanActualFile=="")),
      ]: [
        documentRow("No documents available", "","","")
    ],
    );
  }


  List<Widget> buildAllSections() {
    List<Widget> sections = [];
    int index = 0;
    sections
        .add(buildSection(index++, "Vessel Details", vesselDetailsContent()));
    sections.add(buildSection(
        index++, "Vessel Contact Details", vesselContactContent()));
    sections.add(
        buildSection(index++, "Vessel Dimensions", vesselDimensionContent()));
    sections.add(buildSection(
        index++, "Cargo / Passenger Details", cargoPassengerContent()));
    sections.add(buildSection(index++, "ISPS Details", ispsDetailsContent()));
    if ((vesselDetailsModel.validIssc?.toInt() == 1) &&
        (vesselDetailsModel.doesyourCompliant?.toInt() == 1)) {
      sections.add(buildSection(
          index++,
          "Measures to be taken when an ISPS code complaints ship arrives from a non ISPS complaints port/marine facility.",
          ispsMeasuresComplaintsContent()));
    } else if (!(vesselDetailsModel.validIssc?.toInt() == 1) &&
        (vesselDetailsModel.doesyourCompliant?.toInt() == 1)) {
      sections.add(buildSection(
          index++,
          "Measures to be taken for a convention ship that do not carry the International Ship Security Certificate on board.",
          ispsSecurityCertificateContent()));
      sections.add(buildSection(
          index++,
          "Measures to be taken when an ISPS code complaints ship arrives from a non ISPS complaints port/marine facility",
          ispsMeasuresComplaintsContent()));
    } else if (!(vesselDetailsModel.validIssc?.toInt() == 1) &&
        !(vesselDetailsModel.doesyourCompliant?.toInt() == 1)) {
      sections.add(buildSection(
          index++,
          "Measures to be taken for a convention ship that do not carry the International Ship Security Certificate on board.",
          ispsSecurityCertificateContent()));
    }
    sections.add(buildSection(index++, "Last 10 Port of Calls - In chronological order (most recent call first)", tenPortContent()));
    sections.add(buildSection(index++, "Attached Documents PAN", attachedDocumentPanContent()));
    sections.add(buildSection(index++, "Attached Documents", attachedDocumentsContent()));
    return sections;
  }

  Widget buildSection(int index, String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => setState(() => _expanded[index] = !_expanded[index]),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              border: index != 0
                  ? Border(
                      top: BorderSide(color: Colors.grey.shade300, width: 1),
                    )
                  : null,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                ),
                const SizedBox(width: 8), // Add spacing between text and icon
                AnimatedRotation(
                  duration: const Duration(milliseconds: 200),
                  turns: _expanded[index] ? 0.5 : 0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.gradient1,
                    ),
                    child: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (_expanded[index])
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: content,
          ),
      ],
    );
  }

  Widget documentRow(
    String title,
    String expiry,
    String fileName,
    String savedName, {
    bool isExpiry = false,
    bool isVesselFolder = false,
    bool hideDownload = false,
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppStyle.defaultTitle),
                    SizedBox(height: 2),
                    Text(
                      isExpiry ? "$expiry" : "Expires on $expiry",
                      style: AppStyle.sideDescText,
                    ),
                  ]),
            ),
            if (!hideDownload)
              GestureDetector(
                child: SvgPicture.asset(
                  download,
                  colorFilter: const ColorFilter.mode(
                      AppColors.primary, BlendMode.srcIn),
                  height: ScreenDimension.onePercentOfScreenHight *
                      AppDimensions.defaultIconSize,
                ),
                onTap: () {
                  _downloadDocument(
                      fileName,
                      savedName,
                      isVesselFolder
                          ? vesselDetailsModel.docVesselFileFolder!
                          : vesselDetailsModel.docFileFolder!);
                },
              ),
          ],
        ),
      );

  Widget pIRow(String title, String expiry) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Name Of P & I Club',
                  style: AppStyle.sideDescText,
                ),
                const SizedBox(height: 2),
                Text(title, style: AppStyle.defaultTitle),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'P & I Validity Upto',
                  style: AppStyle.sideDescText,
                ),
                const SizedBox(height: 2),
                Text(Utils.formatStringDate(expiry),
                    style: AppStyle.defaultTitle),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _downloadDocument(
      String fileName, String savedName, String folderLocation) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Downloading document...'),
              ],
            ),
          );
        },
      );

      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        if (androidInfo.version.sdkInt >= 33) {
          await Permission.photos.request();
          await Permission.manageExternalStorage.request();
        } else {
          await Permission.storage.request();
        }
      }

      String? savePath;
      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        if (androidInfo.version.sdkInt >= 30) {
          savePath = await _saveFileWithSAF(fileName);
        } else {
          final directory = await getExternalStorageDirectory();
          savePath = '${directory?.path}/${fileName}';
        }
      } else if (Platform.isIOS) {
        final directory = await getApplicationDocumentsDirectory();
        savePath = '${directory.path}/${fileName}';
      }

      if (savePath == null) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not determine save location')),
        );
        return;
      }
      String downloadPath =
          "${configMaster.applicationUIURL}$folderLocation${savedName}";
      await _performDownload(downloadPath, savePath);

      Navigator.pop(context);

      final result = await OpenFile.open(savePath);
      if (result.type != ResultType.done) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to open file: ${result.message}')),
        );
      }
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Download failed: ${e.toString()}')),
      );
    }
  }

  Future<void> _performDownload(
      String sourcePath, String destinationPath) async {
    print(sourcePath);
    try {
      final dio = Dio();
      await dio.download(
        sourcePath,
        destinationPath,
        options: Options(
          receiveTimeout: const Duration(minutes: 5),
          sendTimeout: const Duration(minutes: 5),
        ),
        onReceiveProgress: (received, total) {
          debugPrint(
              'Download progress: ${(received / total * 100).toStringAsFixed(0)}%');
        },
      );
    } on DioException catch (e) {
      debugPrint('Dio error: ${e.message}');
      rethrow;
    } catch (e) {
      debugPrint('Download error: $e');
      rethrow;
    }
  }

  Future<String?> _saveFileWithSAF(String fileName) async {
    try {
      final directory = await getDownloadsDirectory();
      if (directory != null) {
        final savePath = '${directory.path}/$fileName';
        return savePath;
      }

      final result = await FilePicker.platform.saveFile(
        dialogTitle: 'Save Document',
        fileName: fileName,
      );

      return result;
    } catch (e) {
      debugPrint('Error saving file with SAF: $e');
      return null;
    }
  }


  Widget infoRow(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppStyle.sideDescText,
        ),
        Text(value, style: AppStyle.defaultTitle),
      ],
    ),
  );

  Widget infoBlock(String label, String value) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width - 72) / 2, // Adjust for padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppStyle.sideDescText,
          ),
          SizedBox(height: 2),
          Text(value, style: AppStyle.defaultTitle),
        ],
      ),
    );
  }

  Widget fullWidthInfoBlock(String label, String value,
      {bool showDivider = true}) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  label,
                  style: AppStyle.sideDescText,
                ),
              ),
              SizedBox(width: 16),
              Text(value, style: AppStyle.defaultTitle),
            ],
          ),
        ),
        if (showDivider) ...[
          SizedBox(height: 12),
          Divider(
            color: Colors.grey[300],
            thickness: 0.5,
            height: 1,
          ),
          SizedBox(height: 12),
        ],
      ],
    );
  }

  Widget vesselDetailsContent() {
    return Wrap(
      spacing: 16,
      runSpacing: 12,
      children: [
        infoBlock("SCN", vesselDetailsModel.vcnNo ?? ""),
        infoBlock("Vessel ID", widget.vesselId ?? ""),
        infoBlock("IMO No.", "${vesselDetailsModel.imono ?? ""}"),
        infoBlock("Vessel Nationality Type",
            vesselDetailsModel.nationalityType ?? ""),
        infoBlock("Vessel Name", vesselDetailsModel.vesselName ?? ""),
        infoBlock("Inbound Voyage", vesselDetailsModel.inboundVoyageNo ?? ""),
        infoBlock("Call Sign", vesselDetailsModel.callSign ?? ""),
        infoBlock("Vessel Flag", vesselDetailsModel.nationality ?? ""),
        infoBlock("Vessel Type", vesselDetailsModel.vesselTypeValue ?? ""),
        infoBlock("Purpose of Call", vesselDetailsModel.purposeofCall ?? ""),
        infoBlock(
          "Port Of Registry",
          "${vesselDetailsModel.portOfRegistryCode ?? ""} - ${vesselDetailsModel.portOfRegistryName ?? ""}",
        ),
        infoBlock("Outbound Handling", (vesselDetailsModel.isOutboundAgentCode ?? 0) == 1 ? "Yes" : "No",),
        infoBlock("Estimated Date and Time of Arrival",
           vesselDetailsModel.eta != null ? Utils.formatStringDate(vesselDetailsModel.eta, showTime: true):""),
        infoBlock("Estimated Date and Time of Departure",
            vesselDetailsModel.etd != null ? Utils.formatStringDate(vesselDetailsModel.etd, showTime: true): ""),
        infoBlock(
            "Shipping Line / Operator", vesselDetailsModel.shippingagentValue ?? ""),
        infoBlock("Last Port of Call", "${vesselDetailsModel.lastPortofCallCode ?? ""} - ${vesselDetailsModel.lastPortofCallName ?? ""}"),
        infoBlock("Next Port of Call","${vesselDetailsModel.nextPortofCallCode ?? ""} - ${vesselDetailsModel.nextPortofCallName ?? ""}"),
        infoBlock("Year of Built", vesselDetailsModel.yearBuilt != null
            ? vesselDetailsModel.yearBuilt!
            : ""),
        infoBlock("Berth No", vesselDetailsModel.berthNo ?? ""),
        infoBlock("Port Name", vesselDetailsModel.portNamesWithValue ?? ""),
      ],
    );
  }

  Widget vesselContactContent() => Wrap(spacing: 16, runSpacing: 12, children: [
        infoBlock("Agent Code", vesselDetailsModel.agentCode ?? ""),
        infoBlock("Ship Agent Name", vesselDetailsModel.agentName ?? ""),
        infoBlock("Ship Agent Address", vesselDetailsModel.agentAddress ?? ""),
        infoBlock("Ship Agent Country", vesselDetailsModel.countryName ?? ""),
        infoBlock("Ship Agent State", vesselDetailsModel.statename ?? ""),
        infoBlock("Ship Agent City", vesselDetailsModel.cityname ?? ""),
        infoBlock(
            "Ship Agent Postcode", "${vesselDetailsModel.agentPinCode ?? ""}"),
        infoBlock("Ship Agent Email", vesselDetailsModel.agentEmail ?? ""),
        infoBlock(
            "Ship Agent Mobile No.", "${vesselDetailsModel.agentMobNo ?? ""}"),
      ]);

  Widget vesselDimensionContent() =>
      Wrap(spacing: 16, runSpacing: 12, children: [
        infoBlock(
            "Gross Tonnage",
            vesselDetailsModel.grt != null
                ? "${vesselDetailsModel.grt!.toStringAsFixed(3)} ${vesselDetailsModel.grossUnit}"
                : ""),
        infoBlock(
            "Net Tonnage",
            vesselDetailsModel.nrt != null
                ? "${vesselDetailsModel.nrt!.toStringAsFixed(3)} ${vesselDetailsModel.netUnit}"
                : ""),
      ]);

  Widget cargoPassengerContent() =>
      Wrap(spacing: 16, runSpacing: 12, children: [
        infoBlock("Cargo Type",vesselDetailsModel.cargoTypeValue ?? ""),
        infoBlock(
            "Dangerous Cargo On Board",
            (vesselDetailsModel.dangerousCargoonBoard == null)
                ? ""
                : (vesselDetailsModel.dangerousCargoonBoard == 1
                    ? "Yes"
                    : "No")),
        if(vesselDetailsModel.dangerousCargoonBoard==1)infoBlock("IMDG Code Class:", vesselDetailsModel.imdgCodeClassTextWithComma ?? ""),
        infoBlock("Cargo To Discharge", vesselDetailsModel.cargotoDischarge ?? ""),
        infoBlock("Dangerous Good",(vesselDetailsModel.dangeroudGoods ?? 0) == 1 ? "Yes" : "No",),
        infoBlock(
            "Prohibited Goods Under UN Security Council / Resolution On Board?",
          (vesselDetailsModel.prohibitedgoodsUn ?? 0) == 1 ? "Yes" : "No",),
        if(vesselDetailsModel.prohibitedgoodsUn==1)unSecurityContent(),
        infoBlock("Name of Master", vesselDetailsModel.nameofMaster ?? ""),
        infoBlock("Number of Crew(S)", vesselDetailsModel.totalNoofCrew != null ? "${vesselDetailsModel.totalNoofCrew!}": ""),
        infoBlock("Number of Passenger(S)",vesselDetailsModel.totalNoofPassenger != null ? "${vesselDetailsModel.totalNoofPassenger!}": ""),
      ]);

  Widget ispsDetailsContent() {
    return Column(
      children: [
        // First row - single item full width
        Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Valid ISSC Certification",
                style: AppStyle.sideDescText,
              ),
              const SizedBox(height: 2),
              Text(
                (vesselDetailsModel.validIssc == null)
                    ? ""
                    : (vesselDetailsModel.validIssc == 1 ? "Yes" : "No")
                ,
                style: AppStyle.defaultTitle,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Second row - certificate with download icon
        if (vesselDetailsModel.validIssc == 1)
          Container(
            width: double.infinity,
            color: AppColors.cardBg,
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Valid ISSC Certificate",
                  style: AppStyle.sideDescText,
                ),
                SizedBox(height: 2),
               Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Expires on ${vesselDetailsModel.ispsDocExpityDate != null ? Utils.formatStringDate(vesselDetailsModel.ispsDocExpityDate, showTime: false) ?? "" : ""}",
                      style: AppStyle.defaultTitle,
                    ),
                    if(vesselDetailsModel.isscFilename!="")GestureDetector(
                      child: SvgPicture.asset(
                        download,
                        colorFilter: const ColorFilter.mode(
                            AppColors.primary, BlendMode.srcIn),
                        height: ScreenDimension.onePercentOfScreenHight *
                            AppDimensions.defaultIconSize,
                      ),
                      onTap: () {
                        _downloadDocument(vesselDetailsModel.isscFilename!,vesselDetailsModel.isscSaverFilename!,vesselDetailsModel.docFileFolder!);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        if (vesselDetailsModel.validIssc == 1)const SizedBox(height: 12),
        if (vesselDetailsModel.validIssc == 1)Wrap(
          spacing: 16,
          runSpacing: 12,
          children: [
            infoBlock("Issued by", vesselDetailsModel.issuedBy ?? ""),
            infoBlock("Security Level", vesselDetailsModel.securityLevel ?? ""),
          ],
        ),
        if (vesselDetailsModel.validIssc == 1) const SizedBox(height: 12),

        // Fourth row - two columns for the longer text items
        Wrap(
          spacing: 16,
          runSpacing: 12,
          children: [
            infoBlock(
                "Is The Ship Carrying DG 1 & 2",
                (vesselDetailsModel.istheShipCarryingDg == null)
                    ? ""
                    : (vesselDetailsModel.istheShipCarryingDg == 1 ? "Yes" : "No")
            ),
            infoBlock(
                "Does Your Compliant Ship Arrives From A Non-Compliant Port?",
                (vesselDetailsModel.doesyourCompliant == null)
                    ? ""
                    : (vesselDetailsModel.doesyourCompliant == 1 ? "Yes" : "No")
            ),
          ],
        ),
      ],
    );
  }

  // Widget pAndIDetailsContent() =>
  //     Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
  //       infoRow("Name of P & I Club", "WEST OF ENGLAND INSURANCE SERVICES"),
  //       infoRow("P & I Validity Upto", "22/10/2025"),
  //     ]);

  // Widget attachedDocumentsContent() => Column(children: [
  //       documentRow("Ship Registry Certificate", "31/10/2026"),
  //       documentRow("Tonnage Certificate", "31/10/2026"),
  //       documentRow("Load Line Certificate", "31/10/2026"),
  //       documentRow("Class Certificate", "31/10/2026"),
  //     ]);

  // Widget pAndIDetailsContent() {
  //   return Column(
  //     children: vesselDetailsModel.pAndIList != null
  //         ? vesselDetailsModel.pAndIList!.map((pi) {
  //       return pIRow(
  //           pi.piName ,
  //           pi.piValidityUpto
  //       );
  //     }).toList()
  //         : [
  //       infoRow("No P & I Details available", "")
  //     ],
  //   );
  // }
  Widget attachedDocumentsContent() {
    return Column(
      children: vesselDetailsModel.listofPaymentSlip != null
          ? vesselDetailsModel.listofPaymentSlip!.map((document) {
        return documentRow(
            document.docTitle ?? "Untitled Document",
            document.docExpiry ?? "No expiry date",
            document.fileName!,
            document.saveFileName!,
            isVesselFolder: true
        );
      }).toList()
          : [
        documentRow("No documents available", "","","")
      ],
    );
  }

  void showRejectWithCommentsBottomSheet({
    required BuildContext context,
    String title = 'Reject with Comments',
    String commentHint = 'Enter your comments here',
    String buttonText = 'Submit',
    String initialComment = '',
    required Function(String) onSubmit,
  }) {
    String? errorText;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return StatefulBuilder(
         builder: (context ,setState){
           return Padding(
             padding: EdgeInsets.only(
               bottom: MediaQuery.of(context).viewInsets.bottom,
             ),
             child: Container(
               padding: const EdgeInsets.all(16),
               child: Column(
                 mainAxisSize: MainAxisSize.min,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text(
                         title,
                         style: const TextStyle(
                           fontSize: 18,
                           fontWeight: FontWeight.w500,
                         ),
                       ),
                       IconButton(
                         icon: const Icon(Icons.close),
                         onPressed: () {
                           commentController.clear();
                           Navigator.pop(context);
                         },
                       ),
                     ],
                   ),
                   const SizedBox(height: 16),
                   const Text(
                     'Comment*',
                     style: TextStyle(
                       fontSize: 14,
                       color: Colors.grey,
                     ),
                   ),
                   const SizedBox(height: 8),
                   TextField(
                     controller: commentController,
                     decoration: InputDecoration(
                       hintText: commentHint,
                       border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(8),
                         borderSide: BorderSide(color: Colors.grey.shade300),
                       ),
                       contentPadding: const EdgeInsets.symmetric(
                         horizontal: 12,
                         vertical: 16,
                       ),
                       errorText: errorText,
                     ),
                     minLines: 3,
                     maxLines: 5,
                     onChanged: (value) {
                       if (errorText != null) {
                         setState(() {
                           errorText = null;
                         });
                       }
                     },
                   ),
                   const SizedBox(height: 24),
                   SizedBox(
                     width: double.infinity,
                     height: 48,
                     child: ButtonWidgets.buildRoundedGradientButton(
                         press: () {
                           final comment = commentController.text.trim();
                           if (comment.isEmpty) {
                             setState(() {
                               errorText = 'Comment cannot be empty';
                             });
                             return;
                           }
                           if (comment.isNotEmpty) {
                             onSubmit(comment);
                             commentController.clear();
                             Navigator.pop(context);
                           }
                         },
                         text: "Submit"),
                   ),
                   const SizedBox(height: 16),
                 ],
               ),
             ),
           );
         },
        );
      },
    );
  }
}
