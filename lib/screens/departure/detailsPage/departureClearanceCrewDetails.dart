import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/dimensions.dart';
import '../../../core/media_query.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/role_util.dart';
import '../../../widgets/appdrawer.dart';
import 'model/departuredetailsmodel.dart';

class DepartureCrewDetails extends StatefulWidget {
  final LstDepartureCrew crew;

  const DepartureCrewDetails(
      {super.key,
        required this.crew,
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

  Widget vesselDetailsContent() {
    return Wrap(
      spacing: 16,
      runSpacing: 12,
      children: [
        infoBlock("Name", "${widget.crew.crewListGivenName ?? ""} ${widget.crew.crewListFamilyName ?? ""}"),
        infoBlock("Rank", widget.crew.crewListRankRating ?? ""),
        infoBlock("Nationality", widget.crew.crewListNationality ?? ""),
        infoBlock("Date of Birth",
          widget.crew.crewListDob != null ? Utils.formatStringDate( widget.crew.crewListDob,) : "",),
        infoBlock("Place of Birth", widget.crew.crewListPlaceOfBirth != null ? Utils.formatStringDate( widget.crew.crewListPlaceOfBirth,) : "",),
        infoBlock("Gender", widget.crew.crewListGender ?? ""),
        infoBlock("Date of Embarkation",widget.crew.crewListDateEmbark != null ? Utils.formatStringDate( widget.crew.crewListDateEmbark,) : "",),
        infoBlock("Date of Disembarkation", widget.crew.crewListDateDisEmbark != null ? Utils.formatStringDate( widget.crew.crewListDateDisEmbark,) : "",),
        infoBlock("Nature of Identity Document", widget.crew.crewListNatureOfDoc ?? ""),
        infoBlock("Issuing State of Identity Document",   widget.crew.crewListIssueStateDoc ?? ""),
        infoBlock("No. of Identity Document",  widget.crew.crewListNoofIdentityDoc ?? ""),
        infoBlock("Expiry Date",  widget.crew.crewListDateIdentityDate != null ? Utils.formatStringDate( widget.crew.crewListDateIdentityDate,) : "",),
            ],
    );
  }






}