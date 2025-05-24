class ScnDetailsModel {
  int? voyId;
  int? orgId;
  int? operationType1;
  String? vesselId;
  String? imoNo;
  String? vesselNationalityType;
  String? vslName;
  String? officialNo;
  String? vesselFlag;
  String? vslType;
  String? vesselTerm;
  String? vesselClass;
  String? callSign;
  String? shippingAgentCode;
  String? shippingAgent;
  String? serviceName;
  String? voyageNo;
  String? voyageOut;
  String? visitPurpose;
  String? callingPortCode;
  String? callingPortName;
  dynamic entryCustomStation;
  int? exitCustomStation;
  String? eta;
  String? etahh;
  String? etamm;
  String? etd;
  String? etdhh;
  String? etdmm;
  String? isOutboundAgent;
  String? psaName;
  String? psaCode;
  String? entryPoint;
  String? finalPort;
  String? inboundServiceLane;
  String? outboundServiceLane;
  String? carNo;
  dynamic gateOpenDateTime;
  dynamic gateCloseDateTime;
  double? grossTonnage;
  String? grossTonnageUnit;
  double? netTonnage;
  String? netTonnageUnit;
  int? isOilCessPaid;
  dynamic oilCessPaidDt;
  dynamic oilCessPaidValDt;
  dynamic ata;
  dynamic atd;
  dynamic pob;
  dynamic atb;
  String? vBerthNo;

  ScnDetailsModel({
    this.voyId,
    this.orgId,
    this.operationType1,
    this.vesselId,
    this.imoNo,
    this.vesselNationalityType,
    this.vslName,
    this.officialNo,
    this.vesselFlag,
    this.vslType,
    this.vesselTerm,
    this.vesselClass,
    this.callSign,
    this.shippingAgentCode,
    this.shippingAgent,
    this.serviceName,
    this.voyageNo,
    this.voyageOut,
    this.visitPurpose,
    this.callingPortCode,
    this.callingPortName,
    this.entryCustomStation,
    this.exitCustomStation,
    this.eta,
    this.etahh,
    this.etamm,
    this.etd,
    this.etdhh,
    this.etdmm,
    this.isOutboundAgent,
    this.psaName,
    this.psaCode,
    this.entryPoint,
    this.finalPort,
    this.inboundServiceLane,
    this.outboundServiceLane,
    this.carNo,
    this.gateOpenDateTime,
    this.gateCloseDateTime,
    this.grossTonnage,
    this.grossTonnageUnit,
    this.netTonnage,
    this.netTonnageUnit,
    this.isOilCessPaid,
    this.oilCessPaidDt,
    this.oilCessPaidValDt,
    this.ata,
    this.atd,
    this.pob,
    this.atb,
    this.vBerthNo,
  });

  factory ScnDetailsModel.fromJson(Map<String, dynamic> json) => ScnDetailsModel(
    voyId: json["VOY_ID"],
    orgId: json["ORG_ID"],
    operationType1: json["OperationType1"],
    vesselId: json["VesselID"],
    imoNo: json["IMO_NO"],
    vesselNationalityType: json["VesselNationalityType"],
    vslName: json["VSL_NAME"],
    officialNo: json["OfficialNo"],
    vesselFlag: json["VesselFlag"],
    vslType: json["VSL_TYPE"],
    vesselTerm: json["VesselTerm"],
    vesselClass: json["VesselClass"],
    callSign: json["CallSign"],
    shippingAgentCode: json["ShippingAgentCode"],
    shippingAgent: json["ShippingAgent"],
    serviceName: json["ServiceName"],
    voyageNo: json["VOYAGE_NO"],
    voyageOut: json["VOYAGE_OUT"],
    visitPurpose: json["VISIT_PURPOSE"],
    callingPortCode: json["CALLING_PORT_CODE"],
    callingPortName: json["CALLING_PORT_NAME"],
    entryCustomStation: json["EntryCustomStation"],
    exitCustomStation: json["ExitCustomStation"],
    eta: json["ETA"],
    etahh: json["ETAHH"],
    etamm: json["ETAMM"],
    etd: json["ETD"],
    etdhh: json["ETDHH"],
    etdmm: json["ETDMM"],
    isOutboundAgent: json["ISOutboundAgent"],
    psaName: json["PSAName"],
    psaCode: json["PSACode"],
    entryPoint: json["EntryPoint"],
    finalPort: json["FinalPort"],
    inboundServiceLane: json["InboundServiceLane"],
    outboundServiceLane: json["OutboundServiceLane"],
    carNo: json["CARNo"],
    gateOpenDateTime: json["GateOpenDateTime"],
    gateCloseDateTime: json["GateCloseDateTime"],
    grossTonnage: json["GrossTonnage"],
    grossTonnageUnit: json["GrossTonnageUnit"],
    netTonnage: json["NetTonnage"],
    netTonnageUnit: json["NetTonnageUnit"],
    isOilCessPaid: json["IS_OIL_CESS_PAID"],
    oilCessPaidDt: json["OIL_CESS_PAID_DT"],
    oilCessPaidValDt: json["OIL_CESS_PAID_VAL_DT"],
    ata: json["ATA"],
    atd: json["ATD"],
    pob: json["POB"],
    atb: json["ATB"],
    vBerthNo: json["VBerthNo"],
  );

  Map<String, dynamic> toJson() => {
    "VOY_ID": voyId,
    "ORG_ID": orgId,
    "OperationType1": operationType1,
    "VesselID": vesselId,
    "IMO_NO": imoNo,
    "VesselNationalityType": vesselNationalityType,
    "VSL_NAME": vslName,
    "OfficialNo": officialNo,
    "VesselFlag": vesselFlag,
    "VSL_TYPE": vslType,
    "VesselTerm": vesselTerm,
    "VesselClass": vesselClass,
    "CallSign": callSign,
    "ShippingAgentCode": shippingAgentCode,
    "ShippingAgent": shippingAgent,
    "ServiceName": serviceName,
    "VOYAGE_NO": voyageNo,
    "VOYAGE_OUT": voyageOut,
    "VISIT_PURPOSE": visitPurpose,
    "CALLING_PORT_CODE": callingPortCode,
    "CALLING_PORT_NAME": callingPortName,
    "EntryCustomStation": entryCustomStation,
    "ExitCustomStation": exitCustomStation,
    "ETA": eta,
    "ETAHH": etahh,
    "ETAMM": etamm,
    "ETD": etd,
    "ETDHH": etdhh,
    "ETDMM": etdmm,
    "ISOutboundAgent": isOutboundAgent,
    "PSAName": psaName,
    "PSACode": psaCode,
    "EntryPoint": entryPoint,
    "FinalPort": finalPort,
    "InboundServiceLane": inboundServiceLane,
    "OutboundServiceLane": outboundServiceLane,
    "CARNo": carNo,
    "GateOpenDateTime": gateOpenDateTime,
    "GateCloseDateTime": gateCloseDateTime,
    "GrossTonnage": grossTonnage,
    "GrossTonnageUnit": grossTonnageUnit,
    "NetTonnage": netTonnage,
    "NetTonnageUnit": netTonnageUnit,
    "IS_OIL_CESS_PAID": isOilCessPaid,
    "OIL_CESS_PAID_DT": oilCessPaidDt,
    "OIL_CESS_PAID_VAL_DT": oilCessPaidValDt,
    "ATA": ata,
    "ATD": atd,
    "POB": pob,
    "ATB": atb,
    "VBerthNo": vBerthNo,
  };
}
