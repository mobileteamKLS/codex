class EpanListModel {
  int naId;
  String isPass;
  String parentType;
  String marineBranchId;
  String portauthotityorgid;
  String vesselType;
  String remarksCount;
  String referenceNo;
  String slName;
  String submittedon;
  String scnId;
  String vesselid;
  String imoNo;
  String vesselName;
  String vesselTypeName;
  String eta;
  String etd;
  String outBoundAgentStatus;
  String portName;
  String status;
  String paymentStatusName;
  String revenueConfigStatus;
  String vslStatus;
  double grosstonnage;
  double nettonnage;
  double loa;
  double sumDeadWt;
  double maxCapacity;
  double summerDraft;

  EpanListModel({
    required this.naId,
    required this.isPass,
    required this.parentType,
    required this.marineBranchId,
    required this.portauthotityorgid,
    required this.vesselType,
    required this.remarksCount,
    required this.referenceNo,
    required this.slName,
    required this.submittedon,
    required this.scnId,
    required this.vesselid,
    required this.imoNo,
    required this.vesselName,
    required this.vesselTypeName,
    required this.eta,
    required this.etd,
    required this.outBoundAgentStatus,
    required this.portName,
    required this.status,
    required this.paymentStatusName,
    required this.revenueConfigStatus,
    required this.vslStatus,
    required this.grosstonnage,
    required this.nettonnage,
    required this.loa,
    required this.sumDeadWt,
    required this.maxCapacity,
    required this.summerDraft,
  });

  factory EpanListModel.fromJson(Map<String, dynamic> json) => EpanListModel(
    naId: json["NA_ID"],
    isPass: json["IsPass"],
    parentType: json["ParentType"],
    marineBranchId: json["MarineBranchID"]??"0",
    portauthotityorgid: json["PORTAUTHOTITYORGID"]??"",
    vesselType: json["VesselType"],
    remarksCount: json["RemarksCount"],
    referenceNo: json["ReferenceNo"],
    slName: json["SLName"],
    submittedon: json["Submittedon"]??"",
    scnId: json["SCN_ID"],
    vesselid: json["Vesselid"],
    imoNo: json["IMONo"],
    vesselName: json["VesselName"],
    vesselTypeName: json["VesselTypeName"],
    eta: json["ETA"],
    etd: json["ETD"],
    outBoundAgentStatus: json["outBoundAgentStatus"],
    portName: json["PortName"],
    status: json["Status"],
    paymentStatusName: json["Payment_Status_Name"],
    revenueConfigStatus: json["Revenue_Config_Status"]??"",
    vslStatus: json["vsl_Status"],
    grosstonnage: json["grosstonnage"],
    nettonnage: json["nettonnage"],
    loa: json["loa"],
    sumDeadWt: json["SumDeadWt"],
    maxCapacity: json["MaxCapacity"],
    summerDraft: json["SummerDraft"],
  );

  Map<String, dynamic> toJson() => {
    "NA_ID": naId,
    "IsPass": isPass,
    "ParentType": parentType,
    "MarineBranchID": marineBranchId,
    "PORTAUTHOTITYORGID": portauthotityorgid,
    "VesselType": vesselType,
    "RemarksCount": remarksCount,
    "ReferenceNo": referenceNo,
    "SLName": slName,
    "Submittedon": submittedon,
    "SCN_ID": scnId,
    "Vesselid": vesselid,
    "IMONo": imoNo,
    "VesselName": vesselName,
    "VesselTypeName": vesselTypeName,
    "ETA": eta,
    "ETD": etd,
    "outBoundAgentStatus": outBoundAgentStatus,
    "PortName": portName,
    "Status": status,
    "Payment_Status_Name": paymentStatusName,
    "Revenue_Config_Status": revenueConfigStatus,
    "vsl_Status": vslStatus,
    "grosstonnage": grosstonnage,
    "nettonnage": nettonnage,
    "loa": loa,
    "SumDeadWt": sumDeadWt,
    "MaxCapacity": maxCapacity,
    "SummerDraft": summerDraft,
  };
}
