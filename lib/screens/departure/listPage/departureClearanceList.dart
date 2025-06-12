// vessel_list_refactored.dart
import 'package:codex_pcs/screens/departure/listPage/service/cubit/departure_cubit.dart';
import 'package:codex_pcs/screens/departure/listPage/service/cubit/departure_state.dart';
import 'package:codex_pcs/screens/vessel/page/vessel_details.dart';
import 'package:codex_pcs/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/dimensions.dart';
import '../../../core/img_assets.dart';
import '../../../core/media_query.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/role_util.dart';
import '../../../widgets/appdrawer.dart';
import '../../../widgets/buttons.dart';
import '../../../widgets/text_field.dart';
import '../../vessel/model/vessel_list_model.dart';
import '../detailsPage/departureClearanceDetails.dart';
import 'model/departureListModel.dart';

class DepartureListing extends StatefulWidget {
  const DepartureListing({super.key});

  @override
  State<DepartureListing> createState() => _DepartureListingState();
}

class _DepartureListingState extends State<DepartureListing> {
  late ScrollController _scrollController;
  late DepartureCubit _vesselCubit;

  // Controllers for search fields
  late TextEditingController vesselIdController;
  late TextEditingController scnController;
  late TextEditingController imoNumberController;
  late TextEditingController vesselNameController;
  String vesselId = "";
  String imoName = "";
  String vesselName = "";
  String scn = "";
  bool _isLoadingMore = false;
  int? selectedStatusValue;
  late List<Map<String, dynamic>> statusList = [];

  @override
  void initState() {
    if (OrganizationService.isShippingAgent) {
      statusList = [
        {"label": "Submitted", "value": 1},
        {"label": "Approved", "value": 2},
        {"label": "Rejected", "value": 3},
        {"label": "Created", "value": 4},
        {"label": "Checked", "value": 5},
        {"label": "Cancelled", "value": 6},
        {"label": "Void", "value": 7},
        {"label": "Closed", "value": 8},
      ];
    } else {
      statusList = [
        {"label": "Submitted", "value": 1},
        {"label": "Approved", "value": 2},
        {"label": "Rejected", "value": 3},
        {"label": "Checked", "value": 5},
        {"label": "Cancelled", "value": 6},
        {"label": "Void", "value": 7},
        {"label": "Closed", "value": 8},
      ];
    }

    super.initState();
    _scrollController = ScrollController();
    _vesselCubit = context.read<DepartureCubit>();

    vesselIdController = TextEditingController();
    scnController = TextEditingController();
    imoNumberController = TextEditingController();
    vesselNameController = TextEditingController();

    _scrollController.addListener(_scrollListener);
    _vesselCubit.loadVessels();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    vesselIdController.dispose();
    scnController.dispose();
    imoNumberController.dispose();
    vesselNameController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    final currentPosition = _scrollController.position.pixels;
    final maxExtent = _scrollController.position.maxScrollExtent;
    const threshold = 300.0;

    if (currentPosition >= (maxExtent - threshold)) {
      final state = _vesselCubit.state;
      if (state is DepartureLoaded && state.hasMoreData) {
        // Check if we're already loading more data
        if (!_isLoadingMore) {
          // Add this check
          _isLoadingMore = true; // Set loading flag
          _vesselCubit.loadMoreVessels().then((_) {
            _isLoadingMore = false; // Reset loading flag when done
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Departure Clearance',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white, size: 32),
        toolbarHeight: 60,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0057D8), Color(0xFF1c86ff)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ),
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
              children: [
                _buildHeader(),
                _buildBody(),
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

  // PreferredSizeWidget _buildAppBar() {
  //   return AppBar(
  //     title: const Text(
  //       'Departure Clearance',
  //       style: TextStyle(color: Colors.white),
  //     ),
  //     iconTheme: const IconThemeData(color: Colors.white, size: 32),
  //     toolbarHeight: 60,
  //     flexibleSpace: Container(
  //       decoration: const BoxDecoration(
  //         gradient: LinearGradient(
  //           colors: [Color(0xFF0057D8), Color(0xFF1c86ff)],
  //           begin: Alignment.centerLeft,
  //           end: Alignment.centerRight,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: ScreenDimension.onePercentOfScreenWidth,
          vertical: ScreenDimension.onePercentOfScreenHight * 1.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.keyboard_arrow_left_sharp,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 5),
              Text('Departure Clearance Listing',
                  style: AppStyle.defaultHeading),
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
                    height: ScreenDimension.onePercentOfScreenHight *
                        AppDimensions.defaultIconSize,
                  ),
                ),
                onTap: () => _showVesselSearchBottomSheet(context),
              ),
              SizedBox(width: ScreenDimension.onePercentOfScreenWidth * 4),
              InkWell(
                onTap: () => showVesselFilterBottomSheet(context),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: SvgPicture.asset(
                    filter,
                    height: ScreenDimension.onePercentOfScreenHight *
                        AppDimensions.defaultIconSize1,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return BlocConsumer<DepartureCubit, DepartureState>(
      listener: (context, state) {
        if (state is VesselError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        if (state is DepartureLoading) {
          return const Expanded(
            child: Center(
              child: SizedBox(
                height: 100,
                width: 100,
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            ),
          );
        }

        if (state is DepartureLoaded) {
          return Expanded(
            child: RefreshIndicator(
              onRefresh: () => _vesselCubit.refreshData(),
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, left: 0.0, bottom: 80),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.01,
                    child: state.hasNoRecord
                        ? const SizedBox(
                            height: 400,
                            child: Center(child: Text("No Data Found")),
                          )
                        : Column(
                            children: [
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return buildVesselCardV2(
                                      vesselDetails: state.vessels[index],
                                      index: index);
                                },
                                itemCount: state.vessels.length,
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(2),
                              ),
                              if (state is DepartureLoadingMore)
                                const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: CircularProgressIndicator(
                                      color: AppColors.primary),
                                ),
                            ],
                          ),
                  ),
                ),
              ),
            ),
          );
        }

        if (state is VesselError) {
          return Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.message}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _vesselCubit.loadVessels(isRefresh: true),
                    child: const Text(
                      'Retry',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return const Expanded(child: SizedBox.shrink());
      },
    );
  }

  void _showVesselSearchBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (BuildContext context) {
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
                      _buildSearchHeader(),
                      _buildSearchForm(),
                      _buildSearchButtons(),
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

  Widget _buildSearchHeader() {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(bottom: 16, right: 16, top: 16, left: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SvgPicture.asset(
                      searchBlack,
                      height: ScreenDimension.onePercentOfScreenHight *
                          AppDimensions.defaultIconSize,
                    ),
                  ),
                  Text('Search Vessel', style: AppStyle.defaultHeading),
                ],
              ),
              InkWell(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SvgPicture.asset(
                        cancel,
                        height: ScreenDimension.onePercentOfScreenHight *
                            AppDimensions.defaultIconSize,
                      ),
                    ),
                  ],
                ),
                onTap: () => Navigator.pop(context),
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
                  fontSize: ScreenDimension.textSize * AppDimensions.titleText3,
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
                        height: ScreenDimension.onePercentOfScreenHight *
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
                  scnController.clear();
                  imoNumberController.clear();
                  vesselNameController.clear();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSearchForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          CustomTextField(
            controller: scnController,
            labelText: "SCN",
            isValidationRequired: false,
          ),
          SizedBox(height: ScreenDimension.onePercentOfScreenHight * 1.5),
          CustomTextField(
            controller: vesselIdController,
            labelText: "Vessel ID",
            isValidationRequired: false,
          ),
          SizedBox(height: ScreenDimension.onePercentOfScreenHight * 1.5),
          CustomTextField(
            controller: imoNumberController,
            labelText: "IMO No.",
            isValidationRequired: false,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(7)
            ],
          ),
          SizedBox(height: ScreenDimension.onePercentOfScreenHight * 1.5),
          CustomTextField(
            controller: vesselNameController,
            labelText: "Vessel Name",
            isValidationRequired: false,
          ),
          SizedBox(height: ScreenDimension.onePercentOfScreenHight * 1.5),
        ],
      ),
    );
  }

  Widget _buildSearchButtons() {
    return Column(
      children: [
        SizedBox(height: ScreenDimension.onePercentOfScreenHight * 20),
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
                    vesselIdController.clear();
                    scnController.clear();
                    imoNumberController.clear();
                    vesselNameController.clear();
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ButtonWidgets.buildRoundedGradientButton(
                  text: 'Search',
                  press: () {
                    vesselId = vesselIdController.text.trim();
                    imoName = imoNumberController.text.trim();
                    vesselName = vesselNameController.text.trim();
                    scn = scnController.text.trim();
                    _vesselCubit.searchVessels(
                      vesselId: vesselId,
                      imoName: imoName,
                      vesselName: vesselName,
                      scn: scn,
                    );
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showVesselFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (BuildContext context) {
        return BlocBuilder<DepartureCubit, DepartureState>(
          builder: (context, state) {
            int? selectedFilter;
            if (state is DepartureLoaded) {
              selectedFilter = state.appliedFilter;
            }

            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return FractionallySizedBox(
                  widthFactor: 1,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFilterHeader(setState, selectedFilter),
                        _buildStatusFilters(setState, selectedFilter),
                        _buildFilterButtons(selectedFilter),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildFilterHeader(StateSetter setState, int? selectedFilter) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Filter/Sort', style: AppStyle.defaultHeading),
              InkWell(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: SvgPicture.asset(
                        clear,
                        height: ScreenDimension.onePercentOfScreenHight *
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
      ],
    );
  }

  Widget _buildStatusFilters(StateSetter setState, int? selectedFilter) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: 16.0, right: 16.0, top: 16.0, bottom: 0),
          child: Text(
            "SORT BY STATUS",
            style: TextStyle(
              fontSize: ScreenDimension.textSize * AppDimensions.bodyTextSmall,
              color: AppColors.textColorSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                    } else {
                      selectedFilter = null;
                    }
                  });
                },
                selectedColor: AppColors.primary.withOpacity(0.1),
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(
                    color: isSelected ? AppColors.primary : Colors.transparent,
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
      ],
    );
  }

  Widget _buildFilterButtons(int? selectedFilter) {
    return Padding(
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
              text: 'Apply',
              press: () {
                _vesselCubit.applyStatusFilter(selectedFilter);
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
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
                                selectedStatusValue = null;
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
                          bool isSelected =
                          (selectedStatusValue == status["value"]);

                          return FilterChip(
                            label: Text(
                              status["label"],
                              style: const TextStyle(color: AppColors.primary),
                            ),
                            selected: isSelected,
                            showCheckmark: false,
                            onSelected: (bool selected) {
                              setState(() {
                                if (selected) {
                                  selectedStatusValue = status["value"] as int;
                                } else {
                                  selectedStatusValue = null;
                                }
                                print(
                                    "Selected status value: $selectedStatusValue");
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
                                  selectedStatusValue = null;
                                });

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
                                if (selectedStatusValue != null) {
                                  _vesselCubit.applyStatusFilter(selectedStatusValue);
                                  // Navigator.pop(context);
                                } else {
                                  // _refreshData();
                                }
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

  Widget buildLabelValue(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
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

  Widget buildVesselCard(
      {required DepartureListModel vesselDetails, required int index}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with vessel name and status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    vesselDetails.referenceNo ?? "",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color:
                        ColorUtils.getStatusColor(vesselDetails.status ?? ""),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    vesselDetails.status ?? "",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textColorPrimary,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Vessel details in two columns
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Utils.buildCompactLabelValue('IMO No.', vesselDetails.imoNo),

                      Utils.buildCompactLabelValue(
                          'Vessel Name', vesselDetails.vesselName ?? ""),

                      Utils.buildCompactLabelValue(
                          'SCN', vesselDetails.vcn ?? ''),
                      // Assuming callsign maps to SCN// You may need to add this field to your model
                    ],
                  ),
                ),

                const SizedBox(width: 16),

                // Right column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Utils.buildCompactLabelValue(
                          'ETA',
                          Utils.formatStringUTCDate(vesselDetails.eta,
                              showTime: true)),
                      // You may need to add this field
                      Utils.buildCompactLabelValue(
                          'ETD',
                          Utils.formatStringUTCDate(vesselDetails.etd,
                              showTime: true)),
                      // Utils.buildCompactLabelValue(
                      //     'Vessel Id', vesselDetails.vesselId??""),
                      // You may need to add this field
                    ],
                  ),
                ),
              ],
            ),

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
                        builder: (context) => DepartureClearanceDetails(
                              refNo: vesselDetails.referenceNo!,
                              drId: vesselDetails.drId!,
                              marineBranchId: 0,
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
      {required DepartureListModel vesselDetails, required int index}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with vessel name and status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    vesselDetails.vesselName ?? "",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color:
                    ColorUtils.getStatusColor(vesselDetails.status ?? ""),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    vesselDetails.status ?? "",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textColorPrimary,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
            buildLabelValue('Vessel Flag', ""),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildLabelValue('SCN', "        ${vesselDetails.vcn}"),
                      buildLabelValue(
                          'IMO No.', " "),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildLabelValue(
                          'ETA',
                          Utils.formatStringUTCDate(vesselDetails.eta,
                              showTime: true)),
                      buildLabelValue(
                          'ETD',
                          Utils.formatStringUTCDate(vesselDetails.etd,
                              showTime: true)),
                    ],
                  ),
                ),
              ],
            ),
            buildLabelValue('Port of Registry',""),

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
                        builder: (context) => DepartureClearanceDetails(
                          refNo: vesselDetails.vesselName!,
                          drId: vesselDetails.drId!,
                          marineBranchId: 0,
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
}
