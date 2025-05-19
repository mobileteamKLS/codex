import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../api/app_service.dart';
import '../../../core/dimensions.dart';
import '../../../core/global.dart';
import '../../../core/img_assets.dart';
import '../../../core/media_query.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/common_utils.dart';
import '../../../widgets/buttons.dart';
import '../../login/model/login_response_model.dart';
import '../model/vessel_details.dart';

class VesselDetails extends StatefulWidget {
  const VesselDetails({super.key});

  @override
  State<VesselDetails> createState() => _VesselDetailsState();
}

class _VesselDetailsState extends State<VesselDetails> {
  List<bool> _expanded = List.filled(5, false);
  bool isLoading = false;
   VesselDetailsModel vesselDetailsModel=VesselDetailsModel();

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
        endpoint: "/api_pcs1/Vessel/GetVesselByID",
        method: "POST",
        body: {
          "PVRId": 4780,
          "OrgId": 2024,
          "OperationType": 3,
          "CountryID": 130
        },
      );

      if (response is Map<String, dynamic> && response["StatusCode"] == 200) {
        vesselDetailsModel = VesselDetailsModel.fromJson(response["data"]);
        Utils.prints("IMO", vesselDetailsModel.imoNo??"");
      } else {
        Utils.prints("Login failed:", "${response["StatusMessage"]}");
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
          ],
        ),
        body: Stack(
          children: [
            Container(
              constraints: const BoxConstraints.expand(),
              margin: const EdgeInsets.only(bottom: 100),
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenDimension.onePercentOfScreenWidth *
                      AppDimensions.defaultPageHorizontalPadding),
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
                            const Expanded(
                              child: Text("VS12333333333",
                                  style: TextStyle(
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
                                style: const TextStyle(color: AppColors.primary),
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
                        children: [
                          buildSection(
                              0, "Vessel Details", vesselDetailsContent()),
                          buildSection(
                              1, "Owner/Agent Details", ownerAgentContent()),
                          buildSection(2, "Shipper Dimension",
                              shipperDimensionContent()),
                          buildSection(
                              3, "P&I Details", pAndIDetailsContent()),
                          buildSection(4, "Attached Documents",
                              attachedDocumentsContent()),
                        ],
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
        bottomSheet: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: Colors.white,
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ButtonWidgets.buildRoundedGradientButton(
                        text: 'Cancel',
                        isborderButton: true,
                        textColor: AppColors.primary,
                        verticalPadding: 10,
                        press: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ButtonWidgets.buildRoundedGradientButton(
                        text: 'Search',
                        press: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

      ),
      isLoading ? Utils.tintLoader() : const SizedBox(),
    ]);
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
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16)),
                AnimatedRotation(
                  duration: const Duration(milliseconds: 200),
                  turns: _expanded[index] ? 0.5 : 0,
                  child: Container(
                    margin: const EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.gradient1,),
                    child: Icon(Icons.keyboard_arrow_down_rounded,
                        color: AppColors.primary),
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

  Widget documentRow(String title, String expiry) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppStyle.defaultTitle),
                    Text(
                      "Expires on $expiry",
                      style: AppStyle.sideDescText,
                    ),
                  ]),
            ),
            const Icon(Icons.download_rounded, color: Colors.blue),
          ],
        ),
      );

  Widget vesselDetailsContent() {
    return Wrap(
      spacing: 16,
      runSpacing: 12,
      children: [
        infoBlock("Vessel ID", vesselDetailsModel.vesselId??""),
        infoBlock("IMO No.", vesselDetailsModel.imoNo??""),
        infoBlock("Vessel Nationality Type", "==="),
        infoBlock("Vessel Name", vesselDetailsModel.vslName??""),
        infoBlock("Official No",vesselDetailsModel.officialNo??""),
        infoBlock("Vessel Flag", vesselDetailsModel.nationality??""),
        infoBlock("Vessel Type", vesselDetailsModel.vslTypeValue??""),
        infoBlock("Vessel Class", "=="),
        infoBlock("Vessel Term", "=="),
        infoBlock("Cargo Type", "=="),
        infoBlock("MT /MV", vesselDetailsModel.shpPrefix??""),
        infoBlock("Call Sign", vesselDetailsModel.callsign??""),
        infoBlock("Type Of Agent",vesselDetailsModel.agentName??""),
        infoBlock("Agent Code", vesselDetailsModel.agentCode??""),
        infoBlock(
          "Port Of Registry",
          "${vesselDetailsModel.placeOfRegistyCode ?? ""} - ${vesselDetailsModel.placeOfRegistyName ?? ""}",
        ),
        infoBlock("ISPS Compliance", vesselDetailsModel.isps??""),
        infoBlock("CAP II Certificate", vesselDetailsModel.isCapiiCert??""),
        infoBlock("Safety Mgmt Certificate",vesselDetailsModel.isSafetyManagCert??""),
        infoBlock("Year Of Build",vesselDetailsModel.builtYear.toString()??""),
        infoBlock("Other Vessel Type", vesselDetailsModel.agentCode??""),
        infoBlock("Shipping Line Name / Operator","${vesselDetailsModel.shippingAgentCode ?? ""} - ${vesselDetailsModel.shippingAgent ?? ""}"),
      ],
    );
  }

  Widget ownerAgentContent() => Wrap(spacing: 16, runSpacing: 12, children: [
        infoBlock("Owner Name", vesselDetailsModel.ownerName??""),
        infoBlock("Owner Address",vesselDetailsModel.ownerAddress??""),
        infoBlock("Owner Country",vesselDetailsModel.ownerCountry??""),
        infoBlock("Agent Code", vesselDetailsModel.agencyCode??""),
        infoBlock("Ship Agent Name", vesselDetailsModel.agency??""),
        infoBlock("Ship Agent Address", "=="),
        infoBlock("Ship Agent Country", "BRUNEI DARUSS..."),
        infoBlock("Ship Agent State", "BRUNEI DARUSS..."),
        infoBlock("Ship Agent District", "BRUNEI DARUSS..."),
        infoBlock("Ship Agent Postcode", "BRUNEI DARUSS..."),
        infoBlock("Ship Agent E-Mail", "renuka.shirbavi..."),
        infoBlock("Ship Agent Mobile No", "7509171710"),
      ]);

  Widget shipperDimensionContent() =>
      Wrap(spacing: 16, runSpacing: 12, children: [
        infoBlock("Beam", "7654231"),
        infoBlock("LOA", "7654231"),
        infoBlock("LBP", "Foreign"),
        infoBlock("Position Of Bridge", "FU XING 21"),
        infoBlock("Area Of Operation", "70111000132"),
        infoBlock("Gross Tonnage", "CHINA"),
        infoBlock("Net Tonnage", "Container"),
        infoBlock("Tropical DWT", "Container"),
        infoBlock("Standard Draught", "Container"),
        infoBlock("Displacement", "COAL"),
        infoBlock("Vessel Capacity", "COAL"),
        infoBlock("Vessel With Gear", "BPSX5"),
        infoBlock("Type of Hull", "BPSX5"),
      ]);

  Widget pAndIDetailsContent() =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        infoRow("Name of P & I Club", "WEST OF ENGLAND INSURANCE SERVICES"),
        infoRow("P & I Validity Upto", "22/10/2025"),
      ]);

  Widget attachedDocumentsContent() => Column(children: [
        documentRow("Ship Registry Certificate", "31/10/2026"),
        documentRow("Tonnage Certificate", "31/10/2026"),
        documentRow("Load Line Certificate", "31/10/2026"),
        documentRow("Class Certificate", "31/10/2026"),
      ]);
}
