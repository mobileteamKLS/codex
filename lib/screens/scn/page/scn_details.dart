
import 'package:flutter/material.dart';
import '../../../api/app_service.dart';
import '../../../core/dimensions.dart';
import '../../../core/global.dart';
import '../../../core/media_query.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/role_util.dart';
import '../../../widgets/appdrawer.dart';
import '../model/scn_details_model.dart';


class SCNDetails extends StatefulWidget {
  final String refNo;
  final String port;
  final String scn;
  final String vslName;
  final int voyageId;
  const SCNDetails({super.key, required this.refNo, required this.voyageId, required this.port, required this.scn, required this.vslName});

  @override
  State<SCNDetails> createState() => _SCNDetailsState();
}

class _SCNDetailsState extends State<SCNDetails> {
  List<bool> _expanded = List.filled(5, false);
  bool isLoading = false;
  ScnDetailsModel vesselDetailsModel=ScnDetailsModel();
  TextEditingController commentController = TextEditingController();

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
        endpoint: "/api_pcs1/voyage/ScnViewData",
        method: "POST",
        body: {
          "OperationType1": 3,
          "Client": int.parse(configMaster.clientID),
          "ORG_ID": loginDetailsMaster.organizationId,
          "VOY_ID": widget.voyageId
        },
      );

      if (response is Map<String, dynamic> && response["StatusCode"] == 200) {
        vesselDetailsModel = ScnDetailsModel.fromJson(response["data"]);

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
            'SCN',
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
          actions: const [
          ],
        ),
        drawer: Appdrawer(),
        body: Stack(
          children: [
            Container(
              constraints: const BoxConstraints.expand(),
              padding: EdgeInsets.symmetric(
                horizontal: ScreenDimension.onePercentOfScreenWidth *
                    AppDimensions.defaultPageHorizontalPadding,
                vertical: ScreenDimension.onePercentOfScreenHight *
                    AppDimensions.defaultPageVerticalPadding,

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
                                style: const TextStyle(color: AppColors.primary),
                              ),
                            ),
                          ],
                        )),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.only(
                          top: 12, left: 10, bottom: 12, right: 10),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Port Name",style: AppStyle.sideDescText,),
                          Text(widget.port??"",style: AppStyle.defaultTitle,),
                        ],
                      ),
                    ),
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
                              0, "Voyage Details", voyageDetailsContent()),
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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.gradient1,),
                    child: const Icon(Icons.keyboard_arrow_down_rounded,
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

  Widget voyageDetailsContent() {
    return Wrap(
      spacing: 16,
      runSpacing: 12,
      children: [
        infoBlock("SCN", widget.scn??""),
        infoBlock("Vessel ID", vesselDetailsModel.vesselId??""),
        infoBlock("IMO No.", vesselDetailsModel.imoNo??""),
        infoBlock("Vessel Nationality Type",vesselDetailsModel.vesselNationalityType??""),
        infoBlock("Vessel Name", widget.vslName??""),
        infoBlock("Vessel Flag", vesselDetailsModel.vesselFlag??""),
        infoBlock("Vessel Type", vesselDetailsModel.vslTypeText??""),
        infoBlock("Vessel Class", vesselDetailsModel.vesselClassText??""),
        infoBlock("Call Sign", vesselDetailsModel.callSign??""),
        infoBlock("Inbound Voyage", vesselDetailsModel.voyageNo??""),
        infoBlock("Outbound Voyage", vesselDetailsModel.voyageOut??""),
        infoBlock("Purpose of Call",vesselDetailsModel.visitPurpose??""),
        infoBlock("Last Port of Call","${vesselDetailsModel.lastPortCallCode ?? ""} - ${vesselDetailsModel.lastPortCallName ?? ""}"),
        infoBlock("Next Port of Call","${vesselDetailsModel.callingPortCode ?? ""} - ${vesselDetailsModel.callingPortName ?? ""}"),
        infoBlock("ETA",vesselDetailsModel.eta != null ? Utils.formatStringDate(vesselDetailsModel.eta,showTime: true) ?? "" : ""),
        infoBlock("ETD",vesselDetailsModel.etd != null ? Utils.formatStringDate(vesselDetailsModel.etd,showTime: true) ?? "" : ""),
        infoBlock("Outbound Handling",vesselDetailsModel.isOutboundAgent??""),
        infoBlock("Agent Name",vesselDetailsModel.psaName??""),
        infoBlock("Agent Code",vesselDetailsModel.psaCode??""),
        infoBlock("Gross Tonnage",vesselDetailsModel.grossTonnage != null ? "${vesselDetailsModel.grossTonnage!.toStringAsFixed(3)} ${vesselDetailsModel.grossTonnageUnit}": ""),
        infoBlock("Net Tonnage",vesselDetailsModel.netTonnageUnit != null ? "${vesselDetailsModel.netTonnage!.toStringAsFixed(3)} ${vesselDetailsModel.netTonnageUnit}": ""),
        infoBlock("Oil Cess Paid",(vesselDetailsModel.isOilCessPaid ?? 0) == 1 ? "Yes" : "No"),
        infoBlock("Shipping Line Name / Operator","${vesselDetailsModel.shippingAgentCode ?? ""} - ${vesselDetailsModel.shippingAgent ?? ""}"),
        ],
    );
  }


}

