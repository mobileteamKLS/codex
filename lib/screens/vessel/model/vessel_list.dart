class VesselListDetails {
  String refNo;
  String vesselId;
  String submittedon;
  String imoNo;
  String callsign;
  String vslName;
  String vslType;
  String nationalityType;
  int vFlag;
  String placeOfRegistyName;
  String nationality;
  String status;
  int pvrId;

  VesselListDetails({
    required this.refNo,
    required this.vesselId,
    required this.submittedon,
    required this.imoNo,
    required this.callsign,
    required this.vslName,
    required this.vslType,
    required this.nationalityType,
    required this.vFlag,
    required this.placeOfRegistyName,
    required this.nationality,
    required this.status,
    required this.pvrId,
  });

  factory VesselListDetails.fromJson(Map<String, dynamic> json) =>
      VesselListDetails(
        refNo: json["REF_NO"]??"",
        vesselId: json["VesselID"]??"",
        submittedon: json["Submittedon"]??"",
        imoNo: json["IMO_NO"]??"",
        callsign: json["CALLSIGN"]??"",
        vslName: json["VSL_Name"]??"",
        vslType: json["VSLType"]??"",
        nationalityType: json["NATIONALITYType"]??"",
        vFlag: json["VFlag"]??0,
        placeOfRegistyName: json["PlaceOfRegistyName"]??"",
        nationality: json["NATIONALITY"]??"",
        status: json["status"]??"",
        pvrId: json["PVR_ID"]??0,
      );

  Map<String, dynamic> toJson() => {
        "REF_NO": refNo,
        "VesselID": vesselId,
        "Submittedon": submittedon,
        "IMO_NO": imoNo,
        "CALLSIGN": callsign,
        "VSL_Name": vslName,
        "VSLType": vslType,
        "NATIONALITYType": nationalityType,
        "VFlag": vFlag,
        "PlaceOfRegistyName": placeOfRegistyName,
        "NATIONALITY": nationality,
        "status": status,
        "PVR_ID": pvrId,
      };
}
