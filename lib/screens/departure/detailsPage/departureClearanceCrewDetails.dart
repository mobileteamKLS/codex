import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/dimensions.dart';
import '../../../core/global.dart';
import '../../../core/img_assets.dart';
import '../../../core/media_query.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/role_util.dart';
import '../../../widgets/appdrawer.dart';
import 'model/departuredetailsmodel.dart';

class DepartureCrewDetails extends StatefulWidget {
  final LstDepartureCrew crew;
  final String folderPath;

  const DepartureCrewDetails(
      {super.key,
        required this.crew, required this.folderPath,
});

  @override
  State<DepartureCrewDetails> createState() => _DepartureCrewDetailsState();
}

class _DepartureCrewDetailsState extends State<DepartureCrewDetails> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        appBar: AppBar(
          title: const Text(
            'Crew Details',
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
                            Text("${widget.crew.crewListGivenName ?? ""} ${widget.crew.crewListFamilyName ?? ""}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: AppColors.textColorPrimary,
                                )),
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
        ]);
  }

  Widget buildSection(int index, String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        infoBlock("Name", "${widget.crew.crewListGivenName ?? ""} ${widget.crew.crewListFamilyName ?? ""}"),
        infoBlock("Rank", widget.crew.crewListRankRating ?? ""),
        infoBlock("Nationality", widget.crew.crewListNationality ?? ""),
        infoBlock("Date of Birth",
          widget.crew.crewListDob != null ? Utils.formatStringUTCDate( widget.crew.crewListDob,) : "",),
        infoBlock("Place of Birth", widget.crew.crewListPlaceOfBirth != null ? Utils.formatStringUTCDate( widget.crew.crewListPlaceOfBirth,) : "",),
        infoBlock("Gender", widget.crew.crewListGender ?? ""),
        infoBlock("Date of Embarkation",widget.crew.crewListDateEmbark != null ? Utils.formatStringUTCDate( widget.crew.crewListDateEmbark,) : "",),
        infoBlock("Date of Disembarkation", widget.crew.crewListDateDisEmbark != null ? Utils.formatStringUTCDate( widget.crew.crewListDateDisEmbark,) : "",),
        infoBlock("Nature of Identity Document", widget.crew.crewListNatureOfDoc ?? ""),
        infoBlock("Issuing State of Identity Document",   widget.crew.crewListIssueStateDoc ?? ""),
        infoBlock("No. of Identity Document",  widget.crew.crewListNoofIdentityDoc ?? ""),
        infoBlock("Expiry Date",  widget.crew.crewListDateIdentityDate != null ? Utils.formatStringUTCDate( widget.crew.crewListDateIdentityDate,) : "",),
        SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Identity Document",
                style: AppStyle.sideDescText,
              ),
              const SizedBox(height: 2),
               (widget.crew.fileName != "")?
                Container(
                  color: AppColors.cardBg,
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.crew.fileName??"",
                          style: AppStyle.defaultTitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 14,),
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
                              widget.crew.fileName!,
                              widget.crew.saveFileName!,
                              widget.folderPath);
                        },
                      ),
                    ],
                  ),
                ):
                Container(
                  color: AppColors.cardBg,
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                        "No Document Attached.",
                          style: AppStyle.defaultTitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                    ],
                  ),
                ),

              const SizedBox(height: 8),
            ],
          ),
        ),
            ],
    );
  }






}