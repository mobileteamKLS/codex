import 'package:codex_pcs/screens/vessel/page/vessel_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../api/app_service.dart';
import '../../../core/dimensions.dart';
import '../../../core/img_assets.dart';
import '../../../core/media_query.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/common_utils.dart';
import '../../../widgets/buttons.dart';
import '../../../widgets/snackbar.dart';
import '../../../widgets/text_field.dart';
import '../model/vessel_details.dart';
import '../model/vessel_list.dart';

class VesselListing extends StatefulWidget {

  const VesselListing({super.key});

  @override
  State<VesselListing> createState() => _VesselListingState();
}

class _VesselListingState extends State<VesselListing> {
  bool isLoading = false;
  bool hasNoRecord = false;
  bool isFilterApplied = false;
  DateTime? selectedDate;
  String slotFilterDate = "Slot Date";
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<VesselListDetails> vesselDetailsList = [];
  List<bool> _isExpandedList = [];
  List<String> selectedFilters = [];
  List<VesselListDetails> filteredList = [];
  late TextEditingController fromDateController;
  late TextEditingController toDateController;
  TextEditingController bookingNoController = TextEditingController();
  TextEditingController chaController = TextEditingController();
  TextEditingController importerController = TextEditingController();


  @override
  void initState() {
    super.initState();
    getAllVessels();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Vessel Registration',
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
            GestureDetector(
              child: SvgPicture.asset(
                dropdown,
                height: 25,
                colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
              ),
              onTap: () {
              },
            ),
            const SizedBox(
              width: 14,
            ),
          ]),
      // drawer: AppDrawer(onDrawerCloseIcon: (){
      //   _scaffoldKey.currentState?.closeDrawer();
      // }, menuItems: menuItems,),
      body: Stack(
        children: [
          Container(
            constraints: const BoxConstraints.expand(),
            padding: EdgeInsets.symmetric(
                horizontal: ScreenDimension.onePercentOfScreenWidth *
                    AppDimensions.defaultPageHorizontalPadding),
            color: AppColors.background,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenDimension.onePercentOfScreenWidth,
                      vertical: ScreenDimension.onePercentOfScreenHight*1.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 6.0),
                            child: SvgPicture.asset(
                              menu,
                              height: ScreenDimension.onePercentOfScreenHight *
                                  AppDimensions.defaultIconSize,
                            ),
                          ),
                          Text(
                            'Vessel Listing',
                            style: AppStyle.defaultHeading,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          InkWell(
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: SvgPicture.asset(
                                searchScan,
                                colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                                height: ScreenDimension.onePercentOfScreenHight *
                                    AppDimensions.defaultIconSize,
                              ),
                            ),
                            onTap: () {
                              showVesselSearchBottomSheet(context);
                            },
                          ),
                          SizedBox(
                              width: ScreenDimension.onePercentOfScreenWidth *
                                  4),
                          InkWell(
                            onTap: () {
                              showVesselFilterBottomSheet(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: SvgPicture.asset(
                                filter,
                                height:
                                ScreenDimension.onePercentOfScreenHight *
                                    AppDimensions.defaultIconSize1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                isLoading
                    ? const Center(
                    child: SizedBox(
                        height: 100,
                        width: 100,
                        child: CircularProgressIndicator(color: AppColors.primary,)))
                    : Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, left: 0.0, bottom: 80),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 1.01,
                        child: (hasNoRecord)
                            ? Container(
                          height: 400,
                          child: const Center(
                            child: Text("No Data Found"),
                          ),
                        )
                            : selectedFilters.isNotEmpty ||
                            selectedDate != null
                            ? ListView.builder(
                          physics:
                          const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext, index) {
                            VesselListDetails
                            shipmentDetails =
                            filteredList.elementAt(index);
                            return buildVesselCard(
                                vesselDetails: shipmentDetails,index:  index);
                          },
                          itemCount: filteredList.length,
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(2),
                        )
                            : ListView.builder(
                          physics:
                          const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext, index) {
                            // List<ShipmentDetails> filteredList =
                            //     getFilteredShipmentDetails(
                            //         listShipmentDetails,
                            //         selectedFilters);
                            VesselListDetails
                            shipmentDetails =
                            vesselDetailsList
                                .elementAt(index);
                            return buildVesselCard(
                                vesselDetails: shipmentDetails,index:  index);
                          },
                          itemCount: vesselDetailsList.length,
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(2),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
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
      extendBody: true,
    );
  }

  void getAllVessels() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await ApiService().request(
        endpoint: "/api_pcs1/Vessel/GetAllVesselRegistration",
        method: "POST",
        body: {
          "Client": 1,
          "OrgId": 2024,
          "OperationType": 2,
          "OrgType": "MLO-ShippingAgent",
          "ServiceName": null,
          "VesselId": null,
          "ImoNo": null,
          "VesselName": null,
          "AgentName": null,
          "VesselType": null,
          "VesselStatus": null,
          "Nationality": null,
          "CurrentPortEntity": -1,
          "PlaceOfRegistry": 0,
          "PageIndex": 1,
          "PageSize": 10
        },
      );

      if (response is Map<String, dynamic> && response["StatusCode"] == 200) {
        if(response["data"]==null){
          return;
        }
        List<dynamic> jsonData= response["data"];
        setState(() {
          vesselDetailsList = jsonData
              .map((json) => VesselListDetails.fromJson(json))
              .toList();
          print("length--  = ${vesselDetailsList.length}");
          isLoading = false;
        });
      }
      else {
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

  void showVesselSearchBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (BuildContext context) {
        void search() async {
          String bookingNo = bookingNoController.text.trim();
          String cha = chaController.text.trim();
          String importer = importerController.text.trim();


          Navigator.pop(context);
        }

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return FractionallySizedBox(
              widthFactor: 1,
              child: Container(
                color: AppColors.white,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 16,
                            right: 16,top: 16,left: 16),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: SvgPicture.asset(
                                    searchBlack,
                                    height: ScreenDimension
                                        .onePercentOfScreenHight *
                                        AppDimensions.defaultIconSize,
                                  ),
                                ),
                                Text(
                                  'Search Vessel',
                                  style: AppStyle.defaultHeading,
                                ),
                              ],
                            ),
                            InkWell(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: SvgPicture.asset(
                                      cancel,
                                      height: ScreenDimension
                                          .onePercentOfScreenHight *
                                          AppDimensions.defaultIconSize,
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                      Utils.customDivider(
                        space: 0,
                        color: Colors.black,
                        hasColor: true,
                        thickness: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 16.0, bottom: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Enter details to search",
                              style: TextStyle(
                                fontSize: ScreenDimension.textSize *
                                    AppDimensions.titleText3,
                                color: AppColors.textColorPrimary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            GestureDetector(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: SvgPicture.asset(
                                      clear,
                                      height: ScreenDimension
                                          .onePercentOfScreenHight *
                                          AppDimensions.cardIconsSize2,
                                    ),
                                  ),
                                  Text("Clear",
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontSize: ScreenDimension.textSize *
                                            AppDimensions.bodyTextMedium,
                                        fontWeight: FontWeight.w500,
                                      )),
                                ],
                              ),
                              onTap: (){
                                bookingNoController.clear();
                                chaController.clear();
                                importerController.clear();
                                fromDateController.text = Utils.formatDate(DateTime.now()
                                    .subtract(const Duration(days: 2)));
                                toDateController.text = Utils.formatDate(DateTime.now());
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: bookingNoController,
                              labelText: "Vessel ID",
                              isValidationRequired: false,
                            ),
                            SizedBox( height: ScreenDimension.onePercentOfScreenHight*1.5),
                            CustomTextField(
                              controller: chaController,
                              labelText: "IMO Name",
                              isValidationRequired: false,
                            ),
                            SizedBox( height: ScreenDimension.onePercentOfScreenHight*1.5),
                            CustomTextField(
                              controller: importerController,
                              labelText: "Vessel Name",
                              isValidationRequired: false,
                            ),
                            SizedBox( height: ScreenDimension.onePercentOfScreenHight*1.5),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: ScreenDimension.onePercentOfScreenHight * 20,
                      ),
                      Utils.customDivider(
                        space: 0,
                        color: Colors.black,
                        hasColor: true,
                        thickness: 1,
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: ButtonWidgets.buildRoundedGradientButton(
                                text: 'Cancel',
                                isborderButton: true,
                                textColor: AppColors.primary,
                                verticalPadding: 10,
                                press: () {
                                  bookingNoController.clear();
                                  chaController.clear();
                                  importerController.clear();
                                  fromDateController.text = Utils.formatDate(DateTime.now()
                                      .subtract(const Duration(days: 2)));
                                  toDateController.text = Utils.formatDate(DateTime.now());
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: ButtonWidgets.buildRoundedGradientButton(
                                text: 'Search',
                                press: () {
                                  search();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
  void showVesselFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (BuildContext context) {
        TextEditingController originController = TextEditingController();
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return FractionallySizedBox(
              widthFactor: 1,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Filter/Sort',
                            style: AppStyle.defaultHeading,
                          ),
                          InkWell(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: SvgPicture.asset(
                                    clear,
                                    height: ScreenDimension
                                        .onePercentOfScreenHight *
                                        AppDimensions.cardIconsSize,
                                  ),
                                ),
                                Text("Clear",
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontSize: ScreenDimension.textSize *
                                          AppDimensions.bodyTextLarge,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ],
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                    Utils.customDivider(
                      space: 0,
                      color: Colors.black,
                      hasColor: true,
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 16.0, bottom: 0),
                      child: Text(
                        "SORT BY STATUS",
                        style: TextStyle(
                          fontSize: ScreenDimension.textSize *
                              AppDimensions.bodyTextSmall,
                          color: AppColors.textColorSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
                      child: Wrap(
                        spacing: 8.0,
                        children: [
                          FilterChip(
                            label: const Text(
                              'Draft',
                              style: TextStyle(color: AppColors.primary),
                            ),
                            selected: selectedFilters.contains('DRAFT'),
                            showCheckmark: false,
                            onSelected: (bool selected) {
                              setState(() {
                                selected
                                    ? selectedFilters.add('DRAFT')
                                    : selectedFilters.remove('DRAFT');
                              });
                            },
                            selectedColor: AppColors.primary.withOpacity(0.1),
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: BorderSide(
                                color: selectedFilters.contains('DRAFT')
                                    ? AppColors.primary
                                    : Colors.transparent,
                              ),
                            ),
                            checkmarkColor: AppColors.primary,
                          ),
                          FilterChip(
                            label: const Text(
                              'Gated-in',
                              style: TextStyle(color: AppColors.primary),
                            ),
                            selected: selectedFilters.contains('GATED-IN'),
                            showCheckmark: false,
                            onSelected: (bool selected) {
                              setState(() {
                                selected
                                    ? selectedFilters.add('GATED-IN')
                                    : selectedFilters.remove('GATED-IN');
                              });
                            },
                            selectedColor: AppColors.primary.withOpacity(0.1),
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: BorderSide(
                                color: selectedFilters.contains('GATED-IN')
                                    ? AppColors.primary
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                          FilterChip(
                            label: const Text(
                              'Gate-in Pending',
                              style: TextStyle(color: AppColors.primary),
                            ),
                            selected:
                            selectedFilters.contains('PENDING FOR GATE-IN'),
                            showCheckmark: false,
                            onSelected: (bool selected) {
                              setState(() {
                                selected
                                    ? selectedFilters.add('PENDING FOR GATE-IN')
                                    : selectedFilters
                                    .remove('PENDING FOR GATE-IN');
                              });
                            },
                            selectedColor: AppColors.primary.withOpacity(0.1),
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: BorderSide(
                                color: selectedFilters
                                    .contains('PENDING FOR GATE-IN')
                                    ? AppColors.primary
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                          FilterChip(
                            label: const Text(
                              'Gate-in Rejected',
                              style: TextStyle(color: AppColors.primary),
                            ),
                            selected:
                            selectedFilters.contains('REJECT FOR GATE-IN'),
                            showCheckmark: false,
                            onSelected: (bool selected) {
                              setState(() {
                                selected
                                    ? selectedFilters.add('REJECT FOR GATE-IN')
                                    : selectedFilters
                                    .remove('REJECT FOR GATE-IN');
                              });
                            },
                            selectedColor: AppColors.primary.withOpacity(0.1),
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: BorderSide(
                                color: selectedFilters
                                    .contains('REJECT FOR GATE-IN')
                                    ? AppColors.primary
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Utils.customDivider(
                      space: 0,
                      color: Colors.black,
                      hasColor: true,
                      thickness: 1,
                    ),
                    Padding(
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
                                setState(() {
                                  selectedFilters.clear();
                                  isFilterApplied = false;
                                  selectedDate = null;
                                  slotFilterDate = "Slot Date";
                                });
                                Navigator.pop(context);
                                filterShipments();
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: ButtonWidgets.buildRoundedGradientButton(
                              text: 'Apply',
                              press: () {
                                Navigator.pop(context);
                                filterShipments();
                                setState(() {
                                  isFilterApplied = true;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
  void filterShipments() {
    setState(() {
      filteredList =
          getFilteredShipmentDetails(vesselDetailsList, selectedFilters);
    });
  }

  List<VesselListDetails> getFilteredShipmentDetails(
      List<VesselListDetails> listShipmentDetails, List<String> selectedFilters) {
    return listShipmentDetails.where((shipment) {
      bool matchFound = selectedFilters.any((filter) {
        return shipment.status.toUpperCase() == filter;
      });
      return matchFound;
    }).toList();
  }

  Widget buildVesselCard({
    required VesselListDetails vesselDetails,
    required int index
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // VSR Number and Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  vesselDetails.refNo,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDDF3F6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    vesselDetails.status,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF00A1B7),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Details
            buildLabelValue('IMO No.', vesselDetails.imoNo),
            buildLabelValue('Vessel Name', vesselDetails.vslName),
            buildLabelValue('Call Sign', vesselDetails.callsign),
            buildLabelValue('Port of Registry', "=="),

            const SizedBox(height: 8),

            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>VesselDetails()));
              },

              child: const Row(
                children: [
                  Text(
                    'Show More Details',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF2A7DE1),
                    ),
                  ),
                  SizedBox(width: 6),
                  Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFF2A7DE1)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLabelValue(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              '$label:',
              style: AppStyle.sideDescText,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppStyle.defaultTitle
            ),
          ),
        ],
      ),
    );
  }


}
