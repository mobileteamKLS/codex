import 'dart:io';
import 'package:codex_pcs/screens/departure/listPage/departureClearanceList.dart';
import 'package:codex_pcs/screens/vessel/page/vessel_list.dart';
import 'package:codex_pcs/widgets/snackbar.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
import '../../vessel/model/vessel_details_model.dart';
import 'departureClearanceCrewDetails.dart';
import 'model/departuredetailsmodel.dart';
import 'package:excel/excel.dart' as ex;

class DepartureClearanceDetails extends StatefulWidget {
  final String refNo;
  final int drId;
  final int marineBranchId;
  final bool isSubmit;

  const DepartureClearanceDetails(
      {super.key,
      required this.refNo,
      required this.drId,
      required this.marineBranchId,
      required this.isSubmit});

  @override
  State<DepartureClearanceDetails> createState() =>
      _DepartureClearanceDetailsState();
}

class _DepartureClearanceDetailsState extends State<DepartureClearanceDetails> {
  List<bool> _expanded = List.filled(5, false);
  bool isLoading = false;
  DepartureDetailsModel vesselDetailsModel = DepartureDetailsModel();
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
        endpoint: "/api_pcs1/DepartureClearance/GetDcViewByID",
        method: "POST",
        body: {
          "OperationType": 1,
          "OrgId": loginDetailsMaster.organizationId,
          "Client": int.parse(configMaster.clientID),
          "OrgBranchId": loginDetailsMaster.organizationBranchId,
          "DR_ID": widget.drId,
          "CountryID": configMaster.countryId
        },
      );

      if (response is Map<String, dynamic> && response["StatusCode"] == 200) {
        vesselDetailsModel = DepartureDetailsModel.fromJson(response["data"]);
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

  void approveReject(String remark, int opType) async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await ApiService().request(
        endpoint: "/api_pcs1/DepartureClearance/SetApprovReject",
        method: "POST",
        body: {
          "IsMY": int.parse(configMaster.clientID),
          "CountryID": configMaster.countryId,
          "Status": opType,
          "OrgBranchId": loginDetailsMaster.organizationBranchId,
          "ORG_ID": loginDetailsMaster.organizationId,
          "CREATED_BY": loginDetailsMaster.userId,
          "UserName": "Valerian Donggot",
          "OrgTypeName": loginDetailsMaster.branchName,
          "DR_ID": widget.drId,
          "UpdateRemarks": "",
          "RejectRemark": remark,
          "EnityRemarks": ""
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
          MaterialPageRoute(builder: (_) => const DepartureListing()),
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
            'Departure Clearance',
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
              margin: (OrganizationService.isMarineDepartment &&
                      widget.isSubmit &&
                      (widget.marineBranchId ==
                          loginDetailsMaster.organizationBranchId))
                  ? const EdgeInsets.only(bottom: 100)
                  : const EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.only(
                left: ScreenDimension.onePercentOfScreenWidth *
                    AppDimensions.defaultPageHorizontalPadding,
                right: ScreenDimension.onePercentOfScreenWidth *
                    AppDimensions.defaultPageHorizontalPadding,
                bottom: (OrganizationService.isMarineDepartment &&
                        widget.isSubmit &&
                        (widget.marineBranchId ==
                            loginDetailsMaster.organizationBranchId))
                    ? 0
                    : 8,
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
                        children: [
                          buildSection(
                              0, "Vessel Details", vesselDetailsContent()),
                          buildSection(1, "Cargo Details", buildCargoDetails()),
                          buildSection(2, "Operational Details",
                              operationalDetailsContent()),
                          buildSection(3, "Crew and Passenger Details",
                              crewAndPassenger()),
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
        bottomSheet: RoleConditionWidget(
          condition:
              (OrganizationService.isMarineDepartment && widget.isSubmit) ||
                  (OrganizationService.isCustoms && widget.isSubmit),
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
                                approveReject(comment, 3);
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
                              approveReject("", 2);
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
                      color: AppColors.gradient1,
                    ),
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
          const SizedBox(height: 2),
          Text(value, style: AppStyle.defaultTitle),
        ],
      ),
    );
  }

  Widget documentRow(
    String title,
    String expiry,
    String fileName,
    String savedName,
    String folderPath, {
    bool isExpiry = false,
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
                    const SizedBox(height: 2),
                    if (!isExpiry)
                      Text(
                        "Expires on $expiry",
                        style: AppStyle.sideDescText,
                      ),
                  ]),
            ),
            if (fileName != "")
              GestureDetector(
                child: SvgPicture.asset(
                  download,
                  colorFilter: const ColorFilter.mode(
                      AppColors.primary, BlendMode.srcIn),
                  height: ScreenDimension.onePercentOfScreenHight *
                      AppDimensions.defaultIconSize,
                ),
                onTap: () {
                  _downloadDocument(fileName, savedName, folderPath);
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
                Text(Utils.formatStringUTCDate(expiry),
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
          "${configMaster.applicationUIURL}$folderLocation/${savedName}";
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

  Widget vesselDetailsContent() {
    return Wrap(
      spacing: 16,
      runSpacing: 12,
      children: [
        infoBlock("SCN", vesselDetailsModel.vcn ?? ""),
        infoBlock("Vessel ID", vesselDetailsModel.vesselId ?? ""),
        infoBlock("IMO No.", vesselDetailsModel.imoNo ?? ""),
        infoBlock("Vessel Nationality Type",
            vesselDetailsModel.vesselNationalityType ?? ""),
        infoBlock("Vessel Name", vesselDetailsModel.vesselName ?? ""),
        infoBlock("Voyage No", vesselDetailsModel.voyage ?? ""),
        infoBlock("Port Name", vesselDetailsModel.portName ?? ""),
        infoBlock("Vessel Type", vesselDetailsModel.vesselTypeName ?? ""),
        infoBlock(
            "Estimated Date and Time of Arrival",
            vesselDetailsModel.arrivalDt != null
                ? Utils.formatStringUTCDate(vesselDetailsModel.arrivalDt,
                    showTime: true)
                : ""),
        infoBlock(
            "Estimated Date and Time of Departure",
            vesselDetailsModel.departureDt != null
                ? Utils.formatStringUTCDate(vesselDetailsModel.departureDt,
                    showTime: true)
                : ""),
        infoBlock("Vessel Flag", vesselDetailsModel.flagOfVessel ?? ""),
        infoBlock("Berth No.", vesselDetailsModel.berthNo ?? ""),
        infoBlock(
            "Gross Tonnage",
            vesselDetailsModel.grt != null
                ? "${vesselDetailsModel.grt!.toStringAsFixed(3)} ${vesselDetailsModel.grtUnit}"
                : ""),
        infoBlock(
            "Net Tonnage",
            vesselDetailsModel.nrt != null
                ? "${vesselDetailsModel.nrt!} ${vesselDetailsModel.nrtUnit}"
                : ""),
        // infoBlock("Name of Master", vesselDetailsModel.name ?? ""),
        infoBlock(
          "Last Port of Call",
          "${vesselDetailsModel.lastPortCode ?? ""} - ${vesselDetailsModel.lastPortName ?? ""}",
        ),
        infoBlock(
          "Next Port of Call",
          "${vesselDetailsModel.nextPortCode ?? ""} - ${vesselDetailsModel.nextPortName ?? ""}",
        ),
        infoBlock(
            "Number of Crew(s)",
            vesselDetailsModel.noofCrew != null
                ? "${vesselDetailsModel.noofCrew!}"
                : ""),
        infoBlock(
            "Number of Passengers(s)",
            vesselDetailsModel.passengersOnBoard != null
                ? "${vesselDetailsModel.passengersOnBoard!}"
                : ""),
        infoBlock("Name of Captain", vesselDetailsModel.nameofCaption ?? ""),
        infoBlock(
          "Port of Registry",
          "${vesselDetailsModel.portRegistryCode ?? ""} - ${vesselDetailsModel.portRegistryName ?? ""}",
        ),
        infoBlock("Port of Departure",
            "${vesselDetailsModel.departurePortCode ?? ""} - ${vesselDetailsModel.departurePortPortName ?? ""}"),
      ],
    );
  }

  Widget operationalDetailsContent() {
    return Wrap(
      spacing: 16,
      runSpacing: 12,
      children: [
        infoBlock(
            "Weapon on Board",
            (vesselDetailsModel.wepoanofboard == null)
                ? ""
                : (vesselDetailsModel.wepoanofboard == "1" ? "Yes" : "No")),
        infoBlock("Make and Model", vesselDetailsModel.makeModel ?? ""),
        infoBlock("Quantity", vesselDetailsModel.quantity ?? ""),
        infoBlock("Name of Agent", vesselDetailsModel.nameofAgent ?? ""),
        infoBlock("IC No. / Passport No.", vesselDetailsModel.icNo ?? ""),
        infoBlock("Designation", vesselDetailsModel.designation ?? ""),
        SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Light Dues Invoice",
                style: AppStyle.sideDescText,
              ),
              const SizedBox(height: 2),
              if (vesselDetailsModel.noDues != "")
                Container(
                  color: AppColors.cardBg,
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          vesselDetailsModel.noDuesFileName ?? "",
                          style: AppStyle.defaultTitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(
                        width: 14,
                      ),
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
                              vesselDetailsModel.noDuesFileName!,
                              vesselDetailsModel.noDues!,
                              vesselDetailsModel.docFileFolderDcAttachment!);
                        },
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildCargoDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (vesselDetailsModel.containerised == null)
          Text(
            vesselDetailsModel.containerised == null ? "AS PER MANIFEST" : "",
            style: AppStyle.defaultTitle,
          ),
        Container(
          color: AppColors.cardBg,
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              portCallItem(
                  "Tonnage of Cargo",
                  "Containerised",
                  "Net Wight",
                  vesselDetailsModel.containerised == null
                      ? "AS PER MANIFEST"
                      : vesselDetailsModel.containerised.toString(),
                  "UOM",
                  vesselDetailsModel.contUnit ?? ""),
              const SizedBox(height: 12),
              Divider(
                color: Colors.grey[300],
                thickness: 0.5,
                height: 1,
              ),
              const SizedBox(height: 12),
              portCallItem(
                  "Tonnage of Cargo",
                  "Non-Containerised",
                  "Net Wight",
                  vesselDetailsModel.nonContainerised == null
                      ? "AS PER MANIFEST"
                      : vesselDetailsModel.nonContainerised.toString(),
                  "UOM",
                  vesselDetailsModel.nonConUnit ?? ""),
              const SizedBox(height: 12),
              Divider(
                color: Colors.grey[300],
                thickness: 0.5,
                height: 1,
              ),
              const SizedBox(height: 12),
              portCallItem(
                  "Total Container",
                  "Empty",
                  "20",
                  vesselDetailsModel.containerised == null
                      ? "AS PER MANIFEST"
                      : vesselDetailsModel.empty20.toString(),
                  "40",
                  vesselDetailsModel.containerised == null
                      ? "AS PER MANIFEST"
                      : vesselDetailsModel.empty40.toString()),
              const SizedBox(height: 12),
              Divider(
                color: Colors.grey[300],
                thickness: 0.5,
                height: 1,
              ),
              const SizedBox(height: 12),
              portCallItem(
                  "Total Container",
                  "Loaded",
                  "20",
                  vesselDetailsModel.containerised == null
                      ? "AS PER MANIFEST"
                      : vesselDetailsModel.loaded20.toString(),
                  "40",
                  vesselDetailsModel.containerised == null
                      ? "AS PER MANIFEST"
                      : vesselDetailsModel.loaded40.toString()),
              const SizedBox(height: 12),
              Divider(
                color: Colors.grey[300],
                thickness: 0.5,
                height: 1,
              ),
              const SizedBox(height: 12),
              cargoList()
              //portCallItem("Description of Goods","AS PER MANIFEST","Gross Wight", "AS PER MANIFEST","Remarks","AS PER MANIFEST"),
            ],
          ),
        ),
      ],
    );
  }

  Widget crewList() {
    return Column(
      children:
          vesselDetailsModel.lstDepartureCrew?.asMap().entries.map((entry) {
                int index = entry.key;
                var crew = entry.value;
                bool isLast =
                    index == vesselDetailsModel.lstDepartureCrew!.length - 1;
                return Column(
                  children: [
                    buildPassportCardAlternative(crewData: crew),
                    if (!isLast) ...[
                      const SizedBox(height: 8),
                    ],
                  ],
                );
              }).toList() ??
              [],
    );
  }

  Widget cargoList() {
    return Column(
      children: vesselDetailsModel.lstGoods?.asMap().entries.map((entry) {
            int index = entry.key;
            var goods = entry.value;
            bool isLast = index == vesselDetailsModel.lstGoods!.length - 1;
            return Column(
              children: [
                portCallItem(
                    "Description of Goods",
                    goods.descName ?? "",
                    "Gross Weight",
                    "${goods.grossWeight ?? ""} ${goods.grtUnit ?? ""}",
                    "Remarks",
                    goods.remarks ?? ""),
                if (!isLast) ...[
                  const SizedBox(height: 8),
                ],
              ],
            );
          }).toList() ??
          [],
    );
  }

  Widget crewAndPassenger() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "Crew List",
                  style: AppStyle.subHeading,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                width: 14,
              ),
              GestureDetector(
                child: SvgPicture.asset(
                  download,
                  colorFilter: const ColorFilter.mode(
                      AppColors.primary, BlendMode.srcIn),
                  height: ScreenDimension.onePercentOfScreenHight *
                      AppDimensions.defaultIconSize,
                ),
                onTap: () {
                  // _downloadDocument(
                  //     vesselDetailsModel.noDuesFileName!,
                  //     vesselDetailsModel.noDues!,
                  //     vesselDetailsModel.docFileFolderDcAttachment!);
                  generateExcelDocument(true);
                },
              ),
            ],
          ),
        ),
        SizedBox(child: crewList()),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "Passenger List",
                  style: AppStyle.subHeading,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                width: 14,
              ),
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
                      vesselDetailsModel.noDuesFileName!,
                      vesselDetailsModel.noDues!,
                      vesselDetailsModel.docFileFolderDcAttachment!);
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget portCallItem(String rowTitle1, String rowValue1, String colTitle1,
      String colValue1, String colTitle2, String colValue2) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Port label and name
          Text(
            rowTitle1,
            style: AppStyle.sideDescText,
          ),
          SizedBox(height: 2),
          Text(rowValue1, style: AppStyle.defaultTitle),
          SizedBox(height: 8),

          // Three column layout for dates and security level
          Row(
            children: [
              // Arrival column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      colTitle1,
                      style: AppStyle.sideDescText,
                    ),
                    SizedBox(height: 2),
                    Text(
                      colValue1,
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
                      colTitle2,
                      style: AppStyle.sideDescText,
                    ),
                    SizedBox(height: 2),
                    Text(
                      colValue2,
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

  Widget buildPassportCard({
    required String name,
    required String passportNumber,
    required String expiryDate,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Left side content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name with flag icon
                  Row(
                    children: [
                      Container(
                        width: 20,
                        height: 14,
                        decoration: BoxDecoration(
                          color: Colors.amber[600],
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Center(
                          child: Text(
                            '🇲🇾',
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  // Passport details row
                  Row(
                    children: [
                      // Passport number column
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Passport',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              passportNumber,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Expiry date column
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Expiry Date',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              expiryDate,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Right arrow
            Icon(
              Icons.chevron_right,
              color: Colors.grey[400],
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPassportCardAlternative({
    required LstDepartureCrew crewData,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => DepartureCrewDetails(
                      crew: crewData,
                      folderPath:
                          vesselDetailsModel.docFileFolderDcAttachment ?? "",
                    )));
      },
      child: Container(
        color: AppColors.cardBg,
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${crewData.crewListFamilyName ?? ""} ${crewData.crewListGivenName ?? ""}",
                    style: AppStyle.defaultTitle,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: infoBlock(crewData.crewListNatureOfDoc ?? "",
                            crewData.crewListNoofIdentityDoc ?? ""),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: infoBlock(
                          'Expiry Date',
                          crewData.crewListDateIdentityDate != null
                              ? Utils.formatStringUTCDate(
                                  crewData.crewListDateIdentityDate,
                                )
                              : "",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColors.white,
              ),
              child: const Icon(Icons.keyboard_arrow_right_outlined,
                  color: AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  // Widget ownerAgentContent() => Wrap(spacing: 16, runSpacing: 12, children: [
  //   infoBlock("Owner Name", vesselDetailsModel.ownerName ?? ""),
  //   infoBlock("Owner Address", vesselDetailsModel.ownerAddress ?? ""),
  //   infoBlock("Owner Country", vesselDetailsModel.ownerCountry ?? ""),
  //   infoBlock("Agent Code", vesselDetailsModel.agencyCode ?? ""),
  //   infoBlock("Ship Agent Name", vesselDetailsModel.agentName ?? ""),
  //   infoBlock("Ship Agent Address", vesselDetailsModel.agentAddress ?? ""),
  //   infoBlock("Ship Agent Country", vesselDetailsModel.agentCountry ?? ""),
  //   infoBlock("Ship Agent State", vesselDetailsModel.agentState ?? ""),
  //   infoBlock("Ship Agent District", vesselDetailsModel.agentCity ?? ""),
  //   infoBlock("Ship Agent Postcode", vesselDetailsModel.agentPincode ?? ""),
  //   infoBlock("Ship Agent E-Mail", vesselDetailsModel.agentEmail ?? ""),
  //   infoBlock("Ship Agent Mobile No", vesselDetailsModel.agentMobNo ?? ""),
  // ]);
  //
  // Widget shipperDimensionContent() =>
  //     Wrap(spacing: 16, runSpacing: 12, children: [
  //       infoBlock(
  //           "Beam",
  //           vesselDetailsModel.beam != null
  //               ? "${vesselDetailsModel.beam!.toStringAsFixed(3)} ${vesselDetailsModel.beamUnit}"
  //               : ""),
  //       infoBlock(
  //           "LOA",
  //           vesselDetailsModel.loa != null
  //               ? "${vesselDetailsModel.loa!.toStringAsFixed(3)} ${vesselDetailsModel.loaUnit}"
  //               : ""),
  //       infoBlock(
  //           "LBP",
  //           vesselDetailsModel.lbp != null
  //               ? "${vesselDetailsModel.lbp!.toStringAsFixed(3)} ${vesselDetailsModel.lbpUnit}"
  //               : ""),
  //       infoBlock(
  //           "Position Of Bridge", vesselDetailsModel.positionofBridge ?? ""),
  //       infoBlock(
  //           "Area Of Operation", vesselDetailsModel.areaOperationValue ?? ""),
  //       infoBlock(
  //           "Gross Tonnage",
  //           vesselDetailsModel.grt != null
  //               ? "${vesselDetailsModel.grt!.toStringAsFixed(3)} ${vesselDetailsModel.grtUnit}"
  //               : ""),
  //       infoBlock(
  //           "Net Tonnage",
  //           vesselDetailsModel.nrt != null
  //               ? "${vesselDetailsModel.nrt!.toStringAsFixed(3)} ${vesselDetailsModel.nrtUnit}"
  //               : ""),
  //       infoBlock(
  //           "Tropical DWT",
  //           vesselDetailsModel.dwt != null
  //               ? "${vesselDetailsModel.dwt!.toStringAsFixed(3)} ${vesselDetailsModel.dwtUnit}"
  //               : ""),
  //       infoBlock(
  //           "Standard Draught",
  //           vesselDetailsModel.standardDraught != null
  //               ? "${vesselDetailsModel.standardDraught!.toStringAsFixed(3)} ${vesselDetailsModel.draughtUnit}"
  //               : ""),
  //       infoBlock(
  //           "Displacement",
  //           vesselDetailsModel.displacement != null
  //               ? "${vesselDetailsModel.displacement!.toStringAsFixed(3)} ${vesselDetailsModel.displacementUnit}"
  //               : ""),
  //       infoBlock(
  //           "Vessel Capacity",
  //           vesselDetailsModel.vesselCapacity != null
  //               ? "${vesselDetailsModel.vesselCapacity!.toStringAsFixed(3)} ${vesselDetailsModel.vesselCapUnit}"
  //               : ""),
  //       infoBlock("Vessel With Gear",
  //           (vesselDetailsModel.vslWithGearId ?? 0) == 1 ? "Yes" : "No"),
  //       infoBlock("Type of Hull", vesselDetailsModel.hullTypeValue ?? ""),
  //     ]);
  //
  // Widget pAndIDetailsContent() =>
  //     Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
  //       infoRow("Name of P & I Club", "WEST OF ENGLAND INSURANCE SERVICES"),
  //       infoRow("P & I Validity Upto", "22/10/2025"),
  //     ]);
  //
  // Widget attachedDocumentsContent() => Column(children: [
  //       documentRow("Ship Registry Certificate", "31/10/2026"),
  //       documentRow("Tonnage Certificate", "31/10/2026"),
  //       documentRow("Load Line Certificate", "31/10/2026"),
  //       documentRow("Class Certificate", "31/10/2026"),
  //     ]);
  //
  // Widget pAndIDetailsContent() {
  //   return Column(
  //     children: vesselDetailsModel.pAndIList != null
  //         ? vesselDetailsModel.pAndIList!.map((pi) {
  //       return pIRow(pi.piName ?? "", pi.piValidityUpto ?? "");
  //     }).toList()
  //         : [infoRow("No P & I Details available", "")],
  //   );
  // }
  //
  Widget attachedDocumentsContent() {
    return Column(
      children: vesselDetailsModel.lstUploadDetails != null
          ? vesselDetailsModel.lstUploadDetails!.map((document) {
              return documentRow(
                  document.docTitle ?? "Untitled Document",
                  document.docExpiry ?? "-",
                  document.fileName ?? "",
                  document.saveFileName ?? "",
                  "${vesselDetailsModel.docFileFolderDcAttachment ?? ""}/");
            }).toList()
          : [documentRow("No documents available", "", "", "", "")],
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
          builder: (context, setState) {
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

  Future<void> generateExcelDocument(bool isCrewList) async {
    String fileName =
        'employee_data_${DateTime.now().millisecondsSinceEpoch}.xlsx';
    await _createAndSaveExcel(fileName, isCrewList);
  }

  Future<void> _createAndSaveExcel(String fileName, bool isCrewList) async {
    try {
      // Show loading dialog
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
                Text('Generating Excel document...'),
              ],
            ),
          );
        },
      );

      // Request permissions for Android
      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        if (androidInfo.version.sdkInt >= 33) {
          await Permission.photos.request();
          await Permission.manageExternalStorage.request();
        } else {
          await Permission.storage.request();
        }
      }

      // Determine save path based on platform and Android version
      String? savePath;
      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        if (androidInfo.version.sdkInt >= 30) {
          savePath = await _saveFileWithSAF(fileName);
        } else {
          final directory = await getExternalStorageDirectory();
          savePath = '${directory?.path}/$fileName';
        }
      } else if (Platform.isIOS) {
        final directory = await getApplicationDocumentsDirectory();
        savePath = '${directory.path}/$fileName';
      }

      if (savePath == null) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not determine save location')),
        );
        return;
      }

      // Generate Excel file
      await _performExcelGeneration(savePath, isCrewList);

      Navigator.pop(context); // Close loading dialog

      // Attempt to open the file
      final result = await OpenFile.open(savePath);
      if (result.type != ResultType.done) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to open file: ${result.message}')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Excel file generated and opened successfully!')),
        );
      }
    } catch (e) {
      Navigator.pop(context); // Close loading dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Excel generation failed: ${e.toString()}')),
      );
    }
  }

  Future<void> _performExcelGeneration(
      String destinationPath, bool isCrewList) async {
    try {
      debugPrint('Generating Excel file at: $destinationPath');
      var excel = ex.Excel.createExcel();

      ex.Sheet sheetObject = excel['Sheet1'];

      if (isCrewList) {
        sheetObject.appendRow([
          ex.TextCellValue("Family Name"),
          ex.TextCellValue("Given Name"),
          ex.TextCellValue("Rank/Rating"),
          ex.TextCellValue("Nationality"),
          ex.TextCellValue("Date of Birth"),
          ex.TextCellValue("Place of Birth"),
          ex.TextCellValue("Gender"),
          ex.TextCellValue("Date of Embarkation"),
          ex.TextCellValue("Date of Disembarkation"),
          ex.TextCellValue("Nature of Identity Document"),
          ex.TextCellValue("Issuing State of Identity Document"),
          ex.TextCellValue("No. of Identity Document"),
          ex.TextCellValue("Expiry Date"),
          ex.TextCellValue("Seamen Book No"),
          ex.TextCellValue("Expiry Date1"),
          ex.TextCellValue("FileName"),
        ]);
        for (LstDepartureCrew crew
            in vesselDetailsModel.lstDepartureCrew ?? []) {
          sheetObject.appendRow([
            ex.TextCellValue("${crew.crewListFamilyName ?? ""}"),
            ex.TextCellValue("${crew.crewListGivenName ?? ""}"),
            ex.TextCellValue("${crew.crewListRankRating ?? ""}"),
            ex.TextCellValue("${crew.crewListNationality ?? ""}"),
            ex.TextCellValue(crew.crewListDob != null
                ? Utils.formatStringUTCDate(
                    crew.crewListDob,
                  )
                : ""),
            ex.TextCellValue(
              crew.crewListPlaceOfBirth != null
                  ? Utils.formatStringUTCDate(
                      crew.crewListPlaceOfBirth,
                    )
                  : "",
            ),
            ex.TextCellValue("${crew.crewListGender ?? ""}"),
            ex.TextCellValue(crew.crewListDateEmbark != null
                ? Utils.formatStringUTCDate(
                    crew.crewListDateEmbark,
                  )
                : ""),
            ex.TextCellValue(crew.crewListDateDisEmbark != null
                ? Utils.formatStringUTCDate(
                    crew.crewListDateDisEmbark,
                  )
                : ""),
            ex.TextCellValue(crew.crewListNatureOfDoc ?? ""),
            ex.TextCellValue("${crew.issueCountryText ?? ""}"),
            ex.TextCellValue("${crew.crewListNoofIdentityDoc ?? ""}"),
            ex.TextCellValue("${crew.crewListDateIdentityDate ?? ""}"),
            ex.TextCellValue("${crew.crewListIssueStateDoc ?? ""}"),
            ex.TextCellValue("${crew.crewListExpiryDateOfDoc ?? ""}"),
            ex.TextCellValue("${crew.fileName ?? ""}"),
          ]);
        }
      } else {
        sheetObject.appendRow([
          ex.TextCellValue("Family Name"),
          ex.TextCellValue("Given Name"),
          ex.TextCellValue("Nationality"),
          ex.TextCellValue("Date of Birth"),
          ex.TextCellValue("Gender"),
          ex.TextCellValue("Type of Travel Document"),
          ex.TextCellValue("Sr. No of Travel Document"),
          ex.TextCellValue("Issuing Country of Travel Document"),
          ex.TextCellValue("Issuing Date of Travel Document"),
          ex.TextCellValue("Expiry Date of Travel Document"),
          ex.TextCellValue("Port of Embarkation"),
          ex.TextCellValue("Port of Disembarkation"),
          ex.TextCellValue("Transit Passenger or not"),
          ex.TextCellValue("File Name"),
        ]);
        for (LstDeparturePassenger passenger
            in vesselDetailsModel.lstPassengers ?? []) {
          sheetObject.appendRow([
            ex.TextCellValue(passenger.passFamilyName ?? ""),
            ex.TextCellValue(passenger.passGivenName ?? ""),
            ex.TextCellValue(passenger.nationality ?? ""),
            ex.TextCellValue(passenger.passDob != null
                ? Utils.formatStringUTCDate(
                    passenger.passDob,
                  )
                : ""),
            ex.TextCellValue(passenger.gender ?? ""),
            ex.TextCellValue(passenger.passTravelDoc ?? ""),
            ex.TextCellValue(passenger.passNooftravelDoc ?? ""),
            ex.TextCellValue(passenger.passIssueStateDoc ?? ""),
            ex.TextCellValue(passenger.passIssueDateofTraDoc != null
                ? Utils.formatStringUTCDate(
                    passenger.passDob,
                  )
                : ""),
            ex.TextCellValue(passenger.passExpiryDateofDoc != null
                ? Utils.formatStringUTCDate(
                    passenger.passExpiryDateofDoc,
                  )
                : ""),
            ex.TextCellValue(passenger.embarName ?? ""),
            ex.TextCellValue(passenger.disEmbarName ?? ""),
            ex.TextCellValue("${passenger.transitpass ?? ""}"),
            ex.TextCellValue(passenger.fileName ?? ""),
          ]);
        }
      }

      // Save the Excel file
      List<int>? fileBytes = excel.save();
      if (fileBytes != null) {
        File file = File(destinationPath);
        await file.writeAsBytes(fileBytes);
        debugPrint('Excel file saved successfully');
      } else {
        throw Exception('Failed to generate Excel file bytes');
      }
    } catch (e) {
      debugPrint('Excel generation error: $e');
      rethrow;
    }
  }

  Future<String?> _saveFileWithSAFExcel(String fileName) async {
    try {
      final directory = await getDownloadsDirectory();
      if (directory != null) {
        final savePath = '${directory.path}/$fileName';
        return savePath;
      }

      final result = await FilePicker.platform.saveFile(
        dialogTitle: 'Save Excel Document',
        fileName: fileName,
        type: FileType.custom,
        allowedExtensions: ['xlsx'],
      );
      return result;
    } catch (e) {
      debugPrint('Error saving file with SAF: $e');
      return null;
    }
  }
}
