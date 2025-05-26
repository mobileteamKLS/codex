class ScnDetailsModel {
  int? voyId;
  String? voyageNo;
  dynamic portOfSubmsn;
  String? imoNo;
  String? shppingAgentCode;
  String? lineMloCode;
  int? callingPort;
  String? callingPortCode;
  String? mode;
  String? callingPortName;
  String? visitPurpose;
  String? eta;
  String? etahh;
  String? etamm;
  String? etd;
  String? etdhh;
  String? etdmm;
  String? serviceName;
  String? orgPodCode;
  String? orgPodName;
  int? lastPortCall;
  String? lastPortCallCode;
  String? lastPortCallName;
  dynamic expDraft;
  dynamic imp20Cont;
  dynamic imp40ContAbove;
  dynamic exp20Cont;
  dynamic exp40ContAbove;
  dynamic containerTonnage;
  dynamic cargoTonnage;
  String? operationType;
  dynamic deckCargo;
  String? trade;
  String? ballastCargo;
  String? charterName;
  String? berthing;
  int? isOilCessPaid;
  dynamic oilCessPaidDt;
  dynamic oilCessPaidValDt;
  dynamic portOilCessPaid;
  String? portOilCessPaidCode;
  String? portOilCessPaidName;
  String? vslType;
  String? deckCode;
  String? cargoDesc;
  dynamic isDoubleBanking;
  dynamic isDeleted;
  int? orgId;
  int? createdBy;
  String? createdOn;
  int? updatedBy;
  dynamic updatedOn;
  dynamic portId;
  String? refNo;
  String? vcnNo;
  dynamic dateOfSubmsn;
  String? doshh;
  String? dosmm;
  String? status;
  dynamic terminalId;
  String? terminalName;
  String? shippingAgent;
  String? operatorName;
  String? shippingAgentCode;
  dynamic rotationDate;
  dynamic gateCloseDateTime;
  dynamic gateOpenDateTime;
  double? grossTonnage;
  double? netTonnage;
  dynamic totalNoofCont;
  String? hazCargo;
  dynamic hazCargoTonnage;
  dynamic imp20HazCont;
  dynamic imp40AboveHazCont;
  dynamic exp20HazCont;
  dynamic exp40AboveHazCont;
  String? cargoTonnageUnit;
  String? hazCargoTonnageUnit;
  String? cargoType;
  String? netTonnageUnit;
  String? grossTonnageUnit;
  String? portName;
  int? scnDetailsModelPortId;
  String? isClosed;
  String? isTugAlloted;
  String? tugscn;
  String? tugid;
  String? stsServiceProvider;
  String? stsVesselType;
  dynamic stsAgentId;
  String? isPostSts;
  String? importManifestLink;
  String? importManifestName;
  String? vesselId;
  String? vesselNationalityType;
  String? officialNo;
  String? vesselFlag;
  String? vesselTerm;
  String? vesselClass;
  String? callSign;
  String? customStation;
  int? exitCustomStation;
  String? outboundHandling;
  String? psaName;
  String? psaCode;
  String? entryPoint;
  String? finalPort;
  String? inboundServiceLane;
  String? outboundServiceLane;
  String? carNo;
  String? hazContainerTonnage;
  String? hazContainerTonnageUnit;
  String? hazContainer;
  String? isOutboundAgent;
  dynamic outboundToLocation;
  dynamic outboundOrganization;
  dynamic outboundBranchId;
  dynamic ata;
  dynamic atd;
  dynamic atb;
  dynamic pob;
  String? vBerthNo;
  dynamic ataUpdatedBy;
  dynamic ataUpdateDateTime;
  dynamic atdUpdatedBy;
  dynamic atdUpdateDateTime;
  String? voyageOut;
  String? poToPjLinked;
  String? oPeratorCode;
  String? canUpdateEta;
  String? canUpdateEtd;
  String? outBoundAgentName;
  String? callIdOman;
  String? vesselIdOman;
  String? canUpdateOutBound;
  int? operationType1;
  String? vslTypeText;
  String? vesselTermText;
  String? vesselClassText;

  ScnDetailsModel({
    this.voyId,
    this.voyageNo,
    this.portOfSubmsn,
    this.imoNo,
    this.shppingAgentCode,
    this.lineMloCode,
    this.callingPort,
    this.callingPortCode,
    this.mode,
    this.callingPortName,
    this.visitPurpose,
    this.eta,
    this.etahh,
    this.etamm,
    this.etd,
    this.etdhh,
    this.etdmm,
    this.serviceName,
    this.orgPodCode,
    this.orgPodName,
    this.lastPortCall,
    this.lastPortCallCode,
    this.lastPortCallName,
    this.expDraft,
    this.imp20Cont,
    this.imp40ContAbove,
    this.exp20Cont,
    this.exp40ContAbove,
    this.containerTonnage,
    this.cargoTonnage,
    this.operationType,
    this.deckCargo,
    this.trade,
    this.ballastCargo,
    this.charterName,
    this.berthing,
    this.isOilCessPaid,
    this.oilCessPaidDt,
    this.oilCessPaidValDt,
    this.portOilCessPaid,
    this.portOilCessPaidCode,
    this.portOilCessPaidName,
    this.vslType,
    this.deckCode,
    this.cargoDesc,
    this.isDoubleBanking,
    this.isDeleted,
    this.orgId,
    this.createdBy,
    this.createdOn,
    this.updatedBy,
    this.updatedOn,
    this.portId,
    this.refNo,
    this.vcnNo,
    this.dateOfSubmsn,
    this.doshh,
    this.dosmm,
    this.status,
    this.terminalId,
    this.terminalName,
    this.shippingAgent,
    this.operatorName,
    this.shippingAgentCode,
    this.rotationDate,
    this.gateCloseDateTime,
    this.gateOpenDateTime,
    this.grossTonnage,
    this.netTonnage,
    this.totalNoofCont,
    this.hazCargo,
    this.hazCargoTonnage,
    this.imp20HazCont,
    this.imp40AboveHazCont,
    this.exp20HazCont,
    this.exp40AboveHazCont,
    this.cargoTonnageUnit,
    this.hazCargoTonnageUnit,
    this.cargoType,
    this.netTonnageUnit,
    this.grossTonnageUnit,
    this.portName,
    this.scnDetailsModelPortId,
    this.isClosed,
    this.isTugAlloted,
    this.tugscn,
    this.tugid,
    this.stsServiceProvider,
    this.stsVesselType,
    this.stsAgentId,
    this.isPostSts,
    this.importManifestLink,
    this.importManifestName,
    this.vesselId,
    this.vesselNationalityType,
    this.officialNo,
    this.vesselFlag,
    this.vesselTerm,
    this.vesselClass,
    this.callSign,
    this.customStation,
    this.exitCustomStation,
    this.outboundHandling,
    this.psaName,
    this.psaCode,
    this.entryPoint,
    this.finalPort,
    this.inboundServiceLane,
    this.outboundServiceLane,
    this.carNo,
    this.hazContainerTonnage,
    this.hazContainerTonnageUnit,
    this.hazContainer,
    this.isOutboundAgent,
    this.outboundToLocation,
    this.outboundOrganization,
    this.outboundBranchId,
    this.ata,
    this.atd,
    this.atb,
    this.pob,
    this.vBerthNo,
    this.ataUpdatedBy,
    this.ataUpdateDateTime,
    this.atdUpdatedBy,
    this.atdUpdateDateTime,
    this.voyageOut,
    this.poToPjLinked,
    this.oPeratorCode,
    this.canUpdateEta,
    this.canUpdateEtd,
    this.outBoundAgentName,
    this.callIdOman,
    this.vesselIdOman,
    this.canUpdateOutBound,
    this.operationType1,
    this.vslTypeText,
    this.vesselTermText,
    this.vesselClassText,
  });

  factory ScnDetailsModel.fromJson(Map<String, dynamic> json) => ScnDetailsModel(
    voyId: json["VOY_ID"],
    voyageNo: json["VOYAGE_NO"],
    portOfSubmsn: json["PORT_OF_SUBMSN"],
    imoNo: json["IMO_NO"],
    shppingAgentCode: json["SHPPING_AGENT_CODE"],
    lineMloCode: json["LINE_MLO_CODE"],
    callingPort: json["CALLING_PORT"],
    callingPortCode: json["CALLING_PORT_CODE"],
    mode: json["Mode"],
    callingPortName: json["CALLING_PORT_NAME"],
    visitPurpose: json["VISIT_PURPOSE"],
    eta: json["ETA"],
    etahh: json["ETAHH"],
    etamm: json["ETAMM"],
    etd: json["ETD"],
    etdhh: json["ETDHH"],
    etdmm: json["ETDMM"],
    serviceName: json["ServiceName"],
    orgPodCode: json["ORG_POD_CODE"],
    orgPodName: json["ORG_POD_NAME"],
    lastPortCall: json["LAST_PORT_CALL"],
    lastPortCallCode: json["LAST_PORT_CALL_CODE"],
    lastPortCallName: json["LAST_PORT_CALL_NAME"],
    expDraft: json["EXP_DRAFT"],
    imp20Cont: json["IMP_20_CONT"],
    imp40ContAbove: json["IMP_40_CONT_Above"],
    exp20Cont: json["EXP_20_CONT"],
    exp40ContAbove: json["EXP_40_CONT_Above"],
    containerTonnage: json["Container_Tonnage"],
    cargoTonnage: json["Cargo_Tonnage"],
    operationType: json["OperationType"],
    deckCargo: json["DeckCargo"],
    trade: json["Trade"],
    ballastCargo: json["BALLAST_CARGO"],
    charterName: json["CHARTER_NAME"],
    berthing: json["BERTHING"],
    isOilCessPaid: json["IS_OIL_CESS_PAID"],
    oilCessPaidDt: json["OIL_CESS_PAID_DT"],
    oilCessPaidValDt: json["OIL_CESS_PAID_VAL_DT"],
    portOilCessPaid: json["PORT_OIL_CESS_PAID"],
    portOilCessPaidCode: json["PORT_OIL_CESS_PAID_CODE"],
    portOilCessPaidName: json["PORT_OIL_CESS_PAID_NAME"],
    vslType: json["VSL_TYPE"],
    deckCode: json["DECK_CODE"],
    cargoDesc: json["CARGO_DESC"],
    isDoubleBanking: json["IS_DOUBLE_BANKING"],
    isDeleted: json["IS_DELETED"],
    orgId: json["ORG_ID"],
    createdBy: json["CREATED_BY"],
    createdOn: json["CREATED_ON"],
    updatedBy: json["UPDATED_BY"],
    updatedOn: json["UPDATED_ON"],
    portId: json["PORT_ID"],
    refNo: json["REF_NO"],
    vcnNo: json["VCN_No"],
    dateOfSubmsn: json["DATE_OF_SUBMSN"],
    doshh: json["DOSHH"],
    dosmm: json["DOSMM"],
    status: json["Status"],
    terminalId: json["terminalID"],
    terminalName: json["terminalName"],
    shippingAgent: json["ShippingAgent"],
    operatorName: json["OperatorName"],
    shippingAgentCode: json["ShippingAgentCode"],
    rotationDate: json["RotationDate"],
    gateCloseDateTime: json["GateCloseDateTime"],
    gateOpenDateTime: json["GateOpenDateTime"],
    grossTonnage: json["GrossTonnage"],
    netTonnage: json["NetTonnage"],
    totalNoofCont: json["TotalNoofCont"],
    hazCargo: json["HAZCargo"],
    hazCargoTonnage: json["HAZCargoTonnage"],
    imp20HazCont: json["Imp_20_HazCont"],
    imp40AboveHazCont: json["Imp_40_AboveHazCont"],
    exp20HazCont: json["Exp_20_HazCont"],
    exp40AboveHazCont: json["Exp_40_AboveHazCont"],
    cargoTonnageUnit: json["CargoTonnageUnit"],
    hazCargoTonnageUnit: json["HAZCargoTonnageUnit"],
    cargoType: json["CargoType"],
    netTonnageUnit: json["NetTonnageUnit"],
    grossTonnageUnit: json["GrossTonnageUnit"],
    portName: json["PortName"],
    scnDetailsModelPortId: json["PortId"],
    isClosed: json["IsClosed"],
    isTugAlloted: json["IsTugAlloted"],
    tugscn: json["TUGSCN"],
    tugid: json["TUGID"],
    stsServiceProvider: json["STSServiceProvider"],
    stsVesselType: json["STSVesselType"],
    stsAgentId: json["STSAgentID"],
    isPostSts: json["ISPostSTS"],
    importManifestLink: json["ImportManifestLink"],
    importManifestName: json["ImportManifestName"],
    vesselId: json["VesselID"],
    vesselNationalityType: json["VesselNationalityType"],
    officialNo: json["OfficialNo"],
    vesselFlag: json["VesselFlag"],
    vesselTerm: json["VesselTerm"],
    vesselClass: json["VesselClass"],
    callSign: json["CallSign"],
    customStation: json["CustomStation"],
    exitCustomStation: json["ExitCustomStation"],
    outboundHandling: json["OutboundHandling"],
    psaName: json["PSAName"],
    psaCode: json["PSACode"],
    entryPoint: json["EntryPoint"],
    finalPort: json["FinalPort"],
    inboundServiceLane: json["InboundServiceLane"],
    outboundServiceLane: json["OutboundServiceLane"],
    carNo: json["CARNo"],
    hazContainerTonnage: json["HAZContainerTonnage"],
    hazContainerTonnageUnit: json["HAZContainerTonnageUnit"],
    hazContainer: json["HAZContainer"],
    isOutboundAgent: json["ISOutboundAgent"],
    outboundToLocation: json["OutboundToLocation"],
    outboundOrganization: json["OutboundOrganization"],
    outboundBranchId: json["OutboundBranchId"],
    ata: json["ATA"],
    atd: json["ATD"],
    atb: json["ATB"],
    pob: json["POB"],
    vBerthNo: json["VBerthNo"],
    ataUpdatedBy: json["ATAUpdatedBy"],
    ataUpdateDateTime: json["ATAUpdateDateTime"],
    atdUpdatedBy: json["ATDUpdatedBy"],
    atdUpdateDateTime: json["ATDUpdateDateTime"],
    voyageOut: json["VOYAGE_OUT"],
    poToPjLinked: json["PO_TO_PJLinked"],
    oPeratorCode: json["OPeratorCode"],
    canUpdateEta: json["CANUpdateETA"],
    canUpdateEtd: json["CANUpdateETD"],
    outBoundAgentName: json["outBoundAgentName"],
    callIdOman: json["CallIDOman"],
    vesselIdOman: json["VesselIDOman"],
    canUpdateOutBound: json["CANUpdateOutBound"],
    operationType1: json["OperationType1"],
    vslTypeText: json["VSL_TYPE_Text"],
    vesselTermText: json["VesselTerm_Text"],
    vesselClassText: json["VesselClass_Text"],
  );

  Map<String, dynamic> toJson() => {
    "VOY_ID": voyId,
    "VOYAGE_NO": voyageNo,
    "PORT_OF_SUBMSN": portOfSubmsn,
    "IMO_NO": imoNo,
    "SHPPING_AGENT_CODE": shppingAgentCode,
    "LINE_MLO_CODE": lineMloCode,
    "CALLING_PORT": callingPort,
    "CALLING_PORT_CODE": callingPortCode,
    "Mode": mode,
    "CALLING_PORT_NAME": callingPortName,
    "VISIT_PURPOSE": visitPurpose,
    "ETA": eta,
    "ETAHH": etahh,
    "ETAMM": etamm,
    "ETD": etd,
    "ETDHH": etdhh,
    "ETDMM": etdmm,
    "ServiceName": serviceName,
    "ORG_POD_CODE": orgPodCode,
    "ORG_POD_NAME": orgPodName,
    "LAST_PORT_CALL": lastPortCall,
    "LAST_PORT_CALL_CODE": lastPortCallCode,
    "LAST_PORT_CALL_NAME": lastPortCallName,
    "EXP_DRAFT": expDraft,
    "IMP_20_CONT": imp20Cont,
    "IMP_40_CONT_Above": imp40ContAbove,
    "EXP_20_CONT": exp20Cont,
    "EXP_40_CONT_Above": exp40ContAbove,
    "Container_Tonnage": containerTonnage,
    "Cargo_Tonnage": cargoTonnage,
    "OperationType": operationType,
    "DeckCargo": deckCargo,
    "Trade": trade,
    "BALLAST_CARGO": ballastCargo,
    "CHARTER_NAME": charterName,
    "BERTHING": berthing,
    "IS_OIL_CESS_PAID": isOilCessPaid,
    "OIL_CESS_PAID_DT": oilCessPaidDt,
    "OIL_CESS_PAID_VAL_DT": oilCessPaidValDt,
    "PORT_OIL_CESS_PAID": portOilCessPaid,
    "PORT_OIL_CESS_PAID_CODE": portOilCessPaidCode,
    "PORT_OIL_CESS_PAID_NAME": portOilCessPaidName,
    "VSL_TYPE": vslType,
    "DECK_CODE": deckCode,
    "CARGO_DESC": cargoDesc,
    "IS_DOUBLE_BANKING": isDoubleBanking,
    "IS_DELETED": isDeleted,
    "ORG_ID": orgId,
    "CREATED_BY": createdBy,
    "CREATED_ON": createdOn,
    "UPDATED_BY": updatedBy,
    "UPDATED_ON": updatedOn,
    "PORT_ID": portId,
    "REF_NO": refNo,
    "VCN_No": vcnNo,
    "DATE_OF_SUBMSN": dateOfSubmsn,
    "DOSHH": doshh,
    "DOSMM": dosmm,
    "Status": status,
    "terminalID": terminalId,
    "terminalName": terminalName,
    "ShippingAgent": shippingAgent,
    "OperatorName": operatorName,
    "ShippingAgentCode": shippingAgentCode,
    "RotationDate": rotationDate,
    "GateCloseDateTime": gateCloseDateTime,
    "GateOpenDateTime": gateOpenDateTime,
    "GrossTonnage": grossTonnage,
    "NetTonnage": netTonnage,
    "TotalNoofCont": totalNoofCont,
    "HAZCargo": hazCargo,
    "HAZCargoTonnage": hazCargoTonnage,
    "Imp_20_HazCont": imp20HazCont,
    "Imp_40_AboveHazCont": imp40AboveHazCont,
    "Exp_20_HazCont": exp20HazCont,
    "Exp_40_AboveHazCont": exp40AboveHazCont,
    "CargoTonnageUnit": cargoTonnageUnit,
    "HAZCargoTonnageUnit": hazCargoTonnageUnit,
    "CargoType": cargoType,
    "NetTonnageUnit": netTonnageUnit,
    "GrossTonnageUnit": grossTonnageUnit,
    "PortName": portName,
    "PortId": scnDetailsModelPortId,
    "IsClosed": isClosed,
    "IsTugAlloted": isTugAlloted,
    "TUGSCN": tugscn,
    "TUGID": tugid,
    "STSServiceProvider": stsServiceProvider,
    "STSVesselType": stsVesselType,
    "STSAgentID": stsAgentId,
    "ISPostSTS": isPostSts,
    "ImportManifestLink": importManifestLink,
    "ImportManifestName": importManifestName,
    "VesselID": vesselId,
    "VesselNationalityType": vesselNationalityType,
    "OfficialNo": officialNo,
    "VesselFlag": vesselFlag,
    "VesselTerm": vesselTerm,
    "VesselClass": vesselClass,
    "CallSign": callSign,
    "CustomStation": customStation,
    "ExitCustomStation": exitCustomStation,
    "OutboundHandling": outboundHandling,
    "PSAName": psaName,
    "PSACode": psaCode,
    "EntryPoint": entryPoint,
    "FinalPort": finalPort,
    "InboundServiceLane": inboundServiceLane,
    "OutboundServiceLane": outboundServiceLane,
    "CARNo": carNo,
    "HAZContainerTonnage": hazContainerTonnage,
    "HAZContainerTonnageUnit": hazContainerTonnageUnit,
    "HAZContainer": hazContainer,
    "ISOutboundAgent": isOutboundAgent,
    "OutboundToLocation": outboundToLocation,
    "OutboundOrganization": outboundOrganization,
    "OutboundBranchId": outboundBranchId,
    "ATA": ata,
    "ATD": atd,
    "ATB": atb,
    "POB": pob,
    "VBerthNo": vBerthNo,
    "ATAUpdatedBy": ataUpdatedBy,
    "ATAUpdateDateTime": ataUpdateDateTime,
    "ATDUpdatedBy": atdUpdatedBy,
    "ATDUpdateDateTime": atdUpdateDateTime,
    "VOYAGE_OUT": voyageOut,
    "PO_TO_PJLinked": poToPjLinked,
    "OPeratorCode": oPeratorCode,
    "CANUpdateETA": canUpdateEta,
    "CANUpdateETD": canUpdateEtd,
    "outBoundAgentName": outBoundAgentName,
    "CallIDOman": callIdOman,
    "VesselIDOman": vesselIdOman,
    "CANUpdateOutBound": canUpdateOutBound,
    "OperationType1": operationType1,
    "VSL_TYPE_Text": vslTypeText,
    "VesselTerm_Text": vesselTermText,
    "VesselClass_Text": vesselClassText,
  };
}