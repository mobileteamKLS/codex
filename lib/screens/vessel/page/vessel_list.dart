import 'package:codex_pcs/screens/vessel/page/vessel_details.dart';
import 'package:codex_pcs/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

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
import '../../../widgets/custom_chip.dart';
import '../../../widgets/snackbar.dart';
import '../../../widgets/text_field.dart';
import '../model/vessel_details_model.dart';
import '../model/vessel_list_model.dart';

class VesselListing extends StatefulWidget {
  const VesselListing({super.key});

  @override
  State<VesselListing> createState() => _VesselListingState();
}

class _VesselListingState extends State<VesselListing> {
  bool isLoading = false;
  bool hasNoRecord = false;
  int currentPage = 1;
  final int pageSize = 200;
  bool hasMoreData = true;
  ScrollController _scrollController = ScrollController();
  bool isFilterApplied = false;
  DateTime? selectedDate;
  String slotFilterDate = "Slot Date";
  List<VesselListModel> vesselDetailsList = [];
  List<String> selectedFilters = [];
  String? selectedFilter;
  String? selectedFilterTextValue;

  List<VesselListModel> filteredList = [];
  TextEditingController vesselIdController = TextEditingController();
  TextEditingController imoNumberController = TextEditingController();
  TextEditingController vesselNameController = TextEditingController();

  late List<Map<String, String>> statusList = [];

  String vesselId = "";
  String imoName = "";
  String vesselName = "";

  bool _isLoadingMore = false;
  double _lastScrollPosition = 0.0;

  @override
  void initState() {
    super.initState();
    if (OrganizationService.isShippingAgent) {
      statusList = [
        {"label": "Created", "value": "Created"},
        {"label": "Submitted", "value": "Submitted"},
        {"label": "Approved", "value": "Approved"},
        {"label": "Rejected", "value": "Rejected"},
        {"label": "Inactive", "value": "Inactive"},
        {"label": "Blacklisted", "value": "Suspended"},
        {"label": "Cancelled", "value": "Cancelled"},
      ];
    } else {
      statusList = [
        {"label": "Submitted", "value": "Submitted"},
        {"label": "Approved", "value": "Approved"},
        {"label": "Rejected", "value": "Rejected"},
        {"label": "Inactive", "value": "Inactive"},
        {"label": "Blacklisted", "value": "Suspended"},
        {"label": "Cancelled", "value": "Cancelled"},
      ];
    }
    _scrollController.addListener(_scrollListener);
    getAllVessels();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    final currentPosition = _scrollController.position.pixels;
    final maxExtent = _scrollController.position.maxScrollExtent;

    const threshold = 200.0;

    if (currentPosition >= (maxExtent - threshold)) {
      if (!isLoading && !_isLoadingMore && hasMoreData) {
        print("Loading more data... Current page: $currentPage");
        _loadMoreData();
      }
    }
  }

  void _loadMoreData() async {
    if (_isLoadingMore) return;

    setState(() {
      _isLoadingMore = true;
    });

    _lastScrollPosition = _scrollController.position.pixels;

    currentPage++;
    await getAllVessels(
        status: selectedFilter,
        imoName: imoName,
        vesselId: vesselId,
        vesselName: vesselName);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _lastScrollPosition,
          duration: Duration(milliseconds: 100),
          curve: Curves.easeOut,
        );
      }
    });

    setState(() {
      _isLoadingMore = false;
    });
  }

  Future<void> getAllVessels(
      {String? vesselId,
      String? imoName,
      String? vesselName,
      String? status}) async {
    if (isLoading && !_isLoadingMore) return;

    if (currentPage == 1) {
      setState(() {
        isLoading = true;
      });
    }
    print(status);
    try {
      final response = await ApiService().request(
        endpoint: "/api_pcs1/Vessel/GetAllVesselRegistration",
        method: "POST",
        body: {
          "Client": loginDetailsMaster.userAccountTypeId,
          "OrgId": loginDetailsMaster.organizationId,
          "OperationType": 2,
          "OrgType": loginDetailsMaster.orgTypeName,
          "ServiceName": null,
          "VesselId": vesselId,
          "ImoNo": imoName,
          "VesselName": vesselName,
          "AgentName": null,
          "VesselType": null,
          "VesselStatus": status,
          "Nationality": null,
          "CurrentPortEntity": -1,
          "PlaceOfRegistry": 0,
          "PageIndex": currentPage,
          "PageSize": pageSize
        },
      );

      if (response is Map<String, dynamic> && response["StatusCode"] == 200) {
        if (response["data"] == null) {
          setState(() {
            hasMoreData = false;
            if (currentPage == 1) isLoading = false;
          });
          return;
        }

        List<dynamic> jsonData = response["data"];

        if (response["Status"] == "05") {
          hasNoRecord = true;
        } else {
          hasNoRecord = false;
        }
        List<VesselListModel> newVessels =
            jsonData.map((json) => VesselListModel.fromJson(json)).toList();

        setState(() {
          if (currentPage == 1) {
            vesselDetailsList = newVessels;
            isLoading = false;
          } else {
            vesselDetailsList.addAll(newVessels);
          }

          hasMoreData = jsonData.length == pageSize;

          print(
              "Page $currentPage loaded. Total vessels: ${vesselDetailsList.length}");
        });
      } else {
        Utils.prints("API failed:", "${response["StatusMessage"]}");
        setState(() {
          if (currentPage == 1) isLoading = false;
        });
      }
    } catch (e) {
      print("API Call Failed: $e");
      setState(() {
        if (currentPage == 1) isLoading = false;
      });
    }
  }

  Future<void> _refreshData() async {
    setState(() {
      currentPage = 1;
      hasMoreData = true;
      vesselDetailsList.clear();
      _isLoadingMore = false;
    });
    await getAllVessels();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Ship Registration',
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
          actions: []),
      drawer: const Appdrawer(),
      body: Stack(
        children: [
          Container(
            constraints: const BoxConstraints.expand(),
            padding: EdgeInsets.symmetric(
                horizontal: ScreenDimension.onePercentOfScreenWidth *
                    AppDimensions.defaultPageHorizontalPadding),
            color: AppColors.background,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenDimension.onePercentOfScreenWidth,
                      vertical: ScreenDimension.onePercentOfScreenHight * 1.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
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
                                colorFilter: const ColorFilter.mode(
                                    AppColors.primary, BlendMode.srcIn),
                                height:
                                    ScreenDimension.onePercentOfScreenHight *
                                        AppDimensions.defaultIconSize,
                              ),
                            ),
                            onTap: () {
                              showVesselSearchBottomSheet(context);
                            },
                          ),
                          SizedBox(
                              width:
                                  ScreenDimension.onePercentOfScreenWidth * 4),
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
                if (selectedFilter != null)
                  FilterResultChip(
                    text: selectedFilterTextValue ?? "",
                    backgroundColor: AppColors.white,
                    textColor: AppColors.textColorSecondary,
                    onDelete: () {
                      setState(() {
                        selectedFilter = null;
                        selectedFilterTextValue = null;
                      });
                      getAllVessels(
                          status: selectedFilter,
                          imoName: imoName,
                          vesselId: vesselId,
                          vesselName: vesselName);
                    },
                  ),
                isLoading
                    ? const Center(
                        child: SizedBox(
                            height: 100,
                            width: 100,
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            )))
                    : Expanded(
                        child: SingleChildScrollView(
                          controller: _scrollController,
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
                                  : ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (BuildContext, index) {
                                        VesselListModel shipmentDetails =
                                            vesselDetailsList.elementAt(index);
                                        return buildVesselCardV2(
                                            vesselDetails: shipmentDetails,
                                            index: index);
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
                size: Size(MediaQuery.of(context).size.width, 100),
                painter: AppBarPainterGradient(),
              ),
            ),
          ),
        ],
      ),
      extendBody: true,
    );
  }

  void showVesselSearchBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (BuildContext context) {
        void search() async {
          vesselId = vesselIdController.text.trim();
          imoName = imoNumberController.text.trim();
          vesselName = vesselNameController.text.trim();
          setState(() {
            currentPage = 1;
          });
          getAllVessels(
              vesselId: vesselId,
              imoName: imoName,
              vesselName: vesselName,
              status: selectedFilter);

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
                            bottom: 16, right: 16, top: 16, left: 16),
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
                              onTap: () {
                                vesselIdController.clear();
                                imoNumberController.clear();
                                vesselNameController.clear();
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
                              controller: vesselIdController,
                              labelText: "Vessel ID",
                              isValidationRequired: false,
                            ),
                            SizedBox(
                                height:
                                    ScreenDimension.onePercentOfScreenHight *
                                        1.5),
                            CustomTextField(
                              controller: imoNumberController,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(7)
                              ],
                              labelText: "IMO No.",
                              isValidationRequired: false,
                            ),
                            SizedBox(
                                height:
                                    ScreenDimension.onePercentOfScreenHight *
                                        1.5),
                            CustomTextField(
                              controller: vesselNameController,
                              labelText: "Vessel Name",
                              isValidationRequired: false,
                            ),
                            SizedBox(
                                height:
                                    ScreenDimension.onePercentOfScreenHight *
                                        1.5),
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
                                  vesselIdController.clear();
                                  imoNumberController.clear();
                                  vesselNameController.clear();
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
                              setState(() {
                                selectedFilter = null;
                                isFilterApplied = false;
                              });
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Wrap(
                        spacing: 8.0,
                        children: statusList.map((status) {
                          bool isSelected = (selectedFilter == status["value"]);

                          return FilterChip(
                            label: Text(
                              status["label"]!,
                              style: const TextStyle(color: AppColors.primary),
                            ),
                            selected: isSelected,
                            showCheckmark: false,
                            onSelected: (bool selected) {
                              setState(() {
                                if (selected) {
                                  selectedFilter = status["value"];
                                  selectedFilterTextValue = status["label"];
                                } else {
                                  selectedFilter = null;
                                  selectedFilterTextValue = null;
                                }
                              });
                            },
                            selectedColor: AppColors.primary.withOpacity(0.1),
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: BorderSide(
                                color: isSelected
                                    ? AppColors.primary
                                    : Colors.transparent,
                              ),
                            ),
                          );
                        }).toList(),
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
                                  selectedFilter = null;
                                  selectedFilterTextValue = null;
                                });
                                _refreshData();
                                Navigator.pop(context);
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
                                // if (selectedFilter != null) {
                                getAllVessels(
                                    status: selectedFilter,
                                    imoName: imoName,
                                    vesselId: vesselId,
                                    vesselName: vesselName);
                                // } else {
                                //   _refreshData();
                                // }
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

  Widget buildVesselCard(
      {required VesselListModel vesselDetails, required int index}) {
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: ColorUtils.getStatusColor(vesselDetails.status),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    vesselDetails.status,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textColorPrimary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            buildLabelValue('IMO No.', vesselDetails.imoNo),
            buildLabelValue('Vessel Flag', vesselDetails.nationality),
            buildLabelValue('Call Sign', vesselDetails.callsign),
            buildLabelValue('Shipping Line/Agent', vesselDetails.agentName),
            const SizedBox(height: 4),
            Utils.customDivider(
              space: 0,
              color: Colors.black,
              hasColor: true,
              thickness: 1,
            ),
            const SizedBox(height: 4),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VesselDetails(
                              refNo: vesselDetails.refNo,
                              pvrId: vesselDetails.pvrId,
                              marineBranchId: vesselDetails.marineBranchId,
                              isSubmit: (vesselDetails.status == "Submitted"),
                            )));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Show More Details',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.gradient1,
                      ),
                      child: const Icon(Icons.keyboard_arrow_right_outlined,
                          color: AppColors.primary)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildVesselCardV2(
      {required VesselListModel vesselDetails, required int index}) {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  vesselDetails.vslName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: ColorUtils.getStatusColor(vesselDetails.status),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    vesselDetails.status,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textColorPrimary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            buildLabelValue('Vessel Flag', vesselDetails.nationality),
            buildLabelValue('IMO No.', vesselDetails.imoNo),
            buildLabelValue('Call Sign', vesselDetails.callsign),
            buildLabelValue(
                'Port of Registry', vesselDetails.placeOfRegistyName),
            const SizedBox(height: 4),
            Utils.customDivider(
              space: 0,
              color: Colors.black,
              hasColor: true,
              thickness: 1,
            ),
            const SizedBox(height: 4),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VesselDetails(
                              refNo: vesselDetails.vslName,
                              pvrId: vesselDetails.pvrId,
                              marineBranchId: vesselDetails.marineBranchId,
                              isSubmit: (vesselDetails.status == "Submitted"),
                            )));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Show More Details',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.gradient1,
                      ),
                      child: const Icon(Icons.keyboard_arrow_right_outlined,
                          color: AppColors.primary)),
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
            child: Text(value, style: AppStyle.defaultTitle),
          ),
        ],
      ),
    );
  }
}
