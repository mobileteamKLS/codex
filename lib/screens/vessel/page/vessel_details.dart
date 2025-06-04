import 'dart:io';

import 'package:codex_pcs/screens/vessel/page/vessel_list.dart';
import 'package:codex_pcs/widgets/snackbar.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
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
import '../model/vessel_details_model.dart';

class VesselDetails extends StatefulWidget {
  final String refNo;
  final int pvrId;
  final int marineBranchId;
  final bool isSubmit;

  const VesselDetails(
      {super.key,
      required this.refNo,
      required this.pvrId,
      required this.marineBranchId,
      required this.isSubmit});

  @override
  State<VesselDetails> createState() => _VesselDetailsState();
}

class _VesselDetailsState extends State<VesselDetails> {
  List<bool> _expanded = List.filled(5, false);
  bool isLoading = false;
  VesselDetailsModel vesselDetailsModel = VesselDetailsModel();
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
        endpoint: "/api_pcs1/Vessel/GetVesselByID",
        method: "POST",
        body: {
          "PVRId": widget.pvrId,
          "OrgId": loginDetailsMaster.organizationId,
          "OperationType": 3,
          "CountryID": 130
        },
      );

      if (response is Map<String, dynamic> && response["StatusCode"] == 200) {
        vesselDetailsModel = VesselDetailsModel.fromJson(response["data"]);
        Utils.prints("IMO", vesselDetailsModel.positionofBridge ?? "");
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

  void approveReject(String comment, int opType) async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await ApiService().request(
        endpoint: "/api_pcs1/Vessel/SetApproval",
        method: "POST",
        body: {
          "Client": 1,
          "OrgId": loginDetailsMaster.organizationId,
          "OperationType": opType,
          "OrgType": "Marine Department",
          "OrgTypeName": loginDetailsMaster.orgTypeName,
          "CreatedBy": "150",
          "BranchId": loginDetailsMaster.organizationBranchId,
          "PVR_ID": widget.pvrId,
          "IPAddress": "",
          "Comments": comment
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
          MaterialPageRoute(builder: (_) => const VesselListing()),
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
                          Text(
                            "Approving Authority",
                            style: AppStyle.sideDescText,
                          ),
                          Text(
                            vesselDetailsModel.marineBranchValue ?? "",
                            style: AppStyle.defaultTitle,
                          ),
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
                              0, "Vessel Details", vesselDetailsContent()),
                          buildSection(
                              1, "Owner/Agent Details", ownerAgentContent()),
                          buildSection(2, "Vessel Dimension",
                              shipperDimensionContent()),
                          buildSection(3, "P&I Details", pAndIDetailsContent()),
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
          condition: (OrganizationService.isMarineDepartment &&
              widget.isSubmit &&
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
                                approveReject(comment, 2);
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
                              approveReject("", 1);
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
          String title, String expiry, String fileName, String savedName) =>
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
                  _downloadDocument(
                      fileName, savedName, vesselDetailsModel.docFileFolder!);
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

  Widget vesselDetailsContent() {
    return Wrap(
      spacing: 16,
      runSpacing: 12,
      children: [
        infoBlock("Vessel ID", vesselDetailsModel.vesselId ?? ""),
        infoBlock("IMO No.", vesselDetailsModel.imoNo ?? ""),
        infoBlock("Vessel Nationality Type",
            vesselDetailsModel.nationalityType ?? ""),
        infoBlock("Vessel Name", vesselDetailsModel.vslName ?? ""),
        infoBlock("Official No", vesselDetailsModel.officialNo ?? ""),
        infoBlock("Vessel Flag", vesselDetailsModel.nationality ?? ""),
        infoBlock("Vessel Type", vesselDetailsModel.vslTypeValue ?? ""),
        infoBlock("Vessel Class", vesselDetailsModel.vesselClassValue ?? ""),
        infoBlock("Vessel Term", vesselDetailsModel.vesselTermValue ?? ""),
        infoBlock("Cargo Type", vesselDetailsModel.cargotypeValue ?? ""),
        infoBlock("MT /MV", vesselDetailsModel.shpPrefix ?? ""),
        infoBlock("Call Sign", vesselDetailsModel.callsign ?? ""),
        infoBlock("Type Of Agent", vesselDetailsModel.agency ?? ""),
        infoBlock("Agent Code", vesselDetailsModel.agentCode ?? ""),
        infoBlock(
          "Port Of Registry",
          "${vesselDetailsModel.placeOfRegistyCode ?? ""} - ${vesselDetailsModel.placeOfRegistyName ?? ""}",
        ),
        infoBlock("ISPS Compliance", vesselDetailsModel.isps ?? ""),
        infoBlock("CAP II Certificate", vesselDetailsModel.isCapiiCert ?? ""),
        infoBlock("Safety Mgmt Certificate",
            vesselDetailsModel.isSafetyManagCert ?? ""),
        infoBlock(
            "Year Of Build", vesselDetailsModel.builtYear.toString() ?? ""),
        infoBlock(
            "Other Vessel Type", vesselDetailsModel.otherVslTypeValue ?? ""),
        infoBlock("Shipping Line Name / Operator",
            "${vesselDetailsModel.shippingAgentCode ?? ""} - ${vesselDetailsModel.shippingAgent ?? ""}"),
      ],
    );
  }

  Widget ownerAgentContent() => Wrap(spacing: 16, runSpacing: 12, children: [
        infoBlock("Owner Name", vesselDetailsModel.ownerName ?? ""),
        infoBlock("Owner Address", vesselDetailsModel.ownerAddress ?? ""),
        infoBlock("Owner Country", vesselDetailsModel.ownerCountry ?? ""),
        infoBlock("Agent Code", vesselDetailsModel.agencyCode ?? ""),
        infoBlock("Ship Agent Name", vesselDetailsModel.agentName ?? ""),
        infoBlock("Ship Agent Address", vesselDetailsModel.agentAddress ?? ""),
        infoBlock("Ship Agent Country", vesselDetailsModel.agentCountry ?? ""),
        infoBlock("Ship Agent State", vesselDetailsModel.agentState ?? ""),
        infoBlock("Ship Agent District", vesselDetailsModel.agentCity ?? ""),
        infoBlock("Ship Agent Postcode", vesselDetailsModel.agentPincode ?? ""),
        infoBlock("Ship Agent E-Mail", vesselDetailsModel.agentEmail ?? ""),
        infoBlock("Ship Agent Mobile No", vesselDetailsModel.agentMobNo ?? ""),
      ]);

  Widget shipperDimensionContent() =>
      Wrap(spacing: 16, runSpacing: 12, children: [
        infoBlock(
            "Beam",
            vesselDetailsModel.beam != null
                ? "${vesselDetailsModel.beam!.toStringAsFixed(3)} ${vesselDetailsModel.beamUnit}"
                : ""),
        infoBlock(
            "LOA",
            vesselDetailsModel.loa != null
                ? "${vesselDetailsModel.loa!.toStringAsFixed(3)} ${vesselDetailsModel.loaUnit}"
                : ""),
        infoBlock(
            "LBP",
            vesselDetailsModel.lbp != null
                ? "${vesselDetailsModel.lbp!.toStringAsFixed(3)} ${vesselDetailsModel.lbpUnit}"
                : ""),
        infoBlock(
            "Position Of Bridge", vesselDetailsModel.positionofBridge ?? ""),
        infoBlock(
            "Area Of Operation", vesselDetailsModel.areaOperationValue ?? ""),
        infoBlock(
            "Gross Tonnage",
            vesselDetailsModel.grt != null
                ? "${vesselDetailsModel.grt!.toStringAsFixed(3)} ${vesselDetailsModel.grtUnit}"
                : ""),
        infoBlock(
            "Net Tonnage",
            vesselDetailsModel.nrt != null
                ? "${vesselDetailsModel.nrt!.toStringAsFixed(3)} ${vesselDetailsModel.nrtUnit}"
                : ""),
        infoBlock(
            "Tropical DWT",
            vesselDetailsModel.dwt != null
                ? "${vesselDetailsModel.dwt!.toStringAsFixed(3)} ${vesselDetailsModel.dwtUnit}"
                : ""),
        infoBlock(
            "Standard Draught",
            vesselDetailsModel.standardDraught != null
                ? "${vesselDetailsModel.standardDraught!.toStringAsFixed(3)} ${vesselDetailsModel.draughtUnit}"
                : ""),
        infoBlock(
            "Displacement",
            vesselDetailsModel.displacement != null
                ? "${vesselDetailsModel.displacement!.toStringAsFixed(3)} ${vesselDetailsModel.displacementUnit}"
                : ""),
        infoBlock(
            "Vessel Capacity",
            vesselDetailsModel.vesselCapacity != null
                ? "${vesselDetailsModel.vesselCapacity!.toStringAsFixed(3)} ${vesselDetailsModel.vesselCapUnit}"
                : ""),
        infoBlock("Vessel With Gear",
            (vesselDetailsModel.vslWithGearId ?? 0) == 1 ? "Yes" : "No"),
        infoBlock("Type of Hull", vesselDetailsModel.hullTypeValue ?? ""),
      ]);

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

  Widget pAndIDetailsContent() {
    return Column(
      children: vesselDetailsModel.pAndIList != null
          ? vesselDetailsModel.pAndIList!.map((pi) {
              return pIRow(pi.piName ?? "", pi.piValidityUpto ?? "");
            }).toList()
          : [infoRow("No P & I Details available", "")],
    );
  }

  Widget attachedDocumentsContent() {
    return Column(
      children: vesselDetailsModel.documentList != null
          ? vesselDetailsModel.documentList!.map((document) {
              return documentRow(
                  document.docTitle ?? "Untitled Document",
                  document.docExpiry ?? "No expiry date",
                  document.fileName ?? "",
                  document.saveFileName ?? "");
            }).toList()
          : [documentRow("No documents available", "", "", "")],
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
}
