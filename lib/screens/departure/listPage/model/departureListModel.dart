class DepartureListModel {
  int? recordNumber;
  int? drId;
  String? referenceNo;
  String? shippingAgent;
  int? statusid;
  dynamic rejectdate;
  String? updatedon;
  dynamic submittedon;
  String? createdOn;
  dynamic submittedDate;
  String? vcn;
  String? vesselId;
  String? vesselName;
  int? voyStatus;
  String? eta;
  String? etd;
  String? portName;
  String? status;
  int? approvedBy;
  int? remarksCount;
  int? mainRemarksCount;
  String? outBoundAgentStatus;
  String? cancelRemark;
  String? reasonForDelay;
  dynamic atd;

  DepartureListModel({
    this.recordNumber,
    this.drId,
    this.referenceNo,
    this.shippingAgent,
    this.statusid,
    this.rejectdate,
    this.updatedon,
    this.submittedon,
    this.createdOn,
    this.submittedDate,
    this.vcn,
    this.vesselId,
    this.vesselName,
    this.voyStatus,
    this.eta,
    this.etd,
    this.portName,
    this.status,
    this.approvedBy,
    this.remarksCount,
    this.mainRemarksCount,
    this.outBoundAgentStatus,
    this.cancelRemark,
    this.reasonForDelay,
    this.atd,
  });

  factory DepartureListModel.fromJson(Map<String, dynamic> json) => DepartureListModel(
    recordNumber: json["RecordNumber"],
    drId: json["dr_id"],
    referenceNo: json["ReferenceNo"],
    shippingAgent: json["ShippingAgent"],
    statusid: json["Statusid"],
    rejectdate: json["rejectdate"],
    updatedon: json["updatedon"],
    submittedon: json["submittedon"],
    createdOn: json["CreatedOn"],
    submittedDate: json["SubmittedDate"],
    vcn: json["VCN"],
    vesselId: json["VesselID"],
    vesselName: json["VesselName"],
    voyStatus: json["VOY_Status"],
    eta: json["ETA"],
    etd: json["ETD"],
    portName: json["PortName"],
    status: json["Status"],
    approvedBy: json["ApprovedBy"],
    remarksCount: json["RemarksCount"],
    mainRemarksCount: json["MainRemarksCount"],
    outBoundAgentStatus: json["outBoundAgentStatus"],
    cancelRemark: json["CancelRemark"],
    reasonForDelay: json["ReasonForDelay"],
    atd: json["ATD"],
  );

  Map<String, dynamic> toJson() => {
    "RecordNumber": recordNumber,
    "dr_id": drId,
    "ReferenceNo": referenceNo,
    "ShippingAgent": shippingAgent,
    "Statusid": statusid,
    "rejectdate": rejectdate,
    "updatedon": updatedon,
    "submittedon": submittedon,
    "CreatedOn": createdOn,
    "SubmittedDate": submittedDate,
    "VCN": vcn,
    "VesselID": vesselId,
    "VesselName": vesselName,
    "VOY_Status": voyStatus,
    "ETA": eta,
    "ETD": etd,
    "PortName": portName,
    "Status": status,
    "ApprovedBy": approvedBy,
    "RemarksCount": remarksCount,
    "MainRemarksCount": mainRemarksCount,
    "outBoundAgentStatus": outBoundAgentStatus,
    "CancelRemark": cancelRemark,
    "ReasonForDelay": reasonForDelay,
    "ATD": atd,
  };
}