
class VesselDetailsModel {
  int? orgId;
  dynamic refNo;
  String? vesselId;
  String? vslType;
  String? vslTypeValue;
  String? placeOfRegistyCode;
  String? placeOfRegistyName;
  String? placeOfRegistartionCode;
  String? placeOfRegistartionName;
  String? serviceName;
  String? shippingAgent;
  String? shippingAgentCode;
  int? shippingAgentId;
  String? ownerCountry;
  String? ownerState;
  String? ownerCity;
  String? chartererCountry;
  String? chartererState;
  String? chartererCity;
  String? agentCountry;
  String? agentState;
  String? agentCity;
  int? pvrId;
  String? shpPrefix;
  String? vslName;
  String? callsign;
  String? exVslName;
  String? exCallsign;
  String? modeTransport;
  String? imoNo;
  String? vslBldgPlace;
  String? permShpRegDt;
  String? shpRegValDt;
  String? shpRegCertNo;
  String? isSafetyManagCert;
  dynamic safetyManagCertValDt;
  String? safetyManagCertNo;
  String? isps;
  String? isCapiiCert;
  String? agency;
  String? agencyCode;
  double?  vslHeight;
  double? beam;
  double? loa;
  double? lbp;
  double? maxDraft;
  double? parallelBody;
  double? bowMainfold;
  double? grt;
  double? nrt;
  double? dwt;
  double? isSbt;
  double? reducedGrt;
  double? summerDeadWeight;
  double? teuCapacity;
  String? freeBoard;
  String? classSociety;
  String? hullInsurCompany;
  dynamic hullInsurValDt;
  String? vslStatus;
  String? ownerName;
  String? ownerEmailAddress;
  String? nationality;
  int? orgBranchId;
  dynamic isAmend;
  String? ownerCode;
  String? ownerAddress;
  String? ownerMob;
  String? agentCode;
  String? agentName;
  String? agentAddress;
  String? agentEmail;
  String? agentMobNo;
  String? chartererCode;
  String? chartererName;
  String? chartererAddress;
  String? chartererEmail;
  String? chartererMob;
  String? nationalityType;
  String? officialNo;
  int? vesselClass;
  dynamic vesselClassValue;
  int? vesselTerm;
  dynamic vesselTermValue;
  int? placeOfRegisty;
  int? builtYear;
  String? psaCode;
  String? psaName;
  double? depth;
  String? positionofBridge;
  String? areaOperation;
  dynamic areaOperationValue;
  int? standardDraught;
  double? vesselCapacity;
  double? displacement;
  int? cargotype;
  dynamic cargotypeValue;
  String? vslHeightUnit;
  String? beamUnit;
  String? loaUnit;
  String? bowToMainFoldUnit;
  String? grtUnit;
  String? nrtUnit;
  String? dwtUnit;
  String? lbpUnit;
  String? maxDraftUnit;
  String? parallelBodyUnit;
  String? reduceGrtUnit;
  String? depthUnit;
  String? draughtUnit;
  String? freeBoardUnit;
  String? sumDeadWeightUnit;
  String? displacementUnit;
  String? teuUnit;
  String? vesselCapUnit;
  int? otherVslTypeId;
  dynamic otherVslTypeValue;
  int? hullTypeId;
  String? hullTypeValue;
  int? vslWithGearId;
  int? ownerCountryId;
  int? ownerStateId;
  int? ownerCityId;
  String? ownerPincode;
  int? chartererCountryId;
  int? chartererStateId;
  int? chartererCityId;
  String? chartererPincode;
  int? agentCountryId;
  int? agentStateId;
  int? agentCityId;
  String? agentPincode;
  String? suspendBy;
  dynamic marineBranchId;
  dynamic isVesselSharing;
  String? vesselIdOman;
  int? imoCount;
  String? docFileFolder;
  List<DocumentList>? documentList;
  List<VesselRegistrationPiDetails>? pAndIList;
  String? marineBranchValue;

  VesselDetailsModel({
     this.orgId,
     this.refNo,
     this.vesselId,
     this.vslType,
     this.vslTypeValue,
     this.placeOfRegistyCode,
     this.placeOfRegistyName,
     this.placeOfRegistartionCode,
     this.placeOfRegistartionName,
     this.serviceName,
     this.shippingAgent,
     this.shippingAgentCode,
     this.shippingAgentId,
     this.ownerCountry,
     this.ownerState,
     this.ownerCity,
     this.chartererCountry,
     this.chartererState,
     this.chartererCity,
     this.agentCountry,
     this.agentState,
     this.agentCity,
     this.pvrId,
     this.shpPrefix,
     this.vslName,
     this.callsign,
     this.exVslName,
     this.exCallsign,
     this.modeTransport,
     this.imoNo,
     this.vslBldgPlace,
     this.permShpRegDt,
     this.shpRegValDt,
     this.shpRegCertNo,
     this.isSafetyManagCert,
     this.safetyManagCertValDt,
     this.safetyManagCertNo,
     this.isps,
     this.isCapiiCert,
     this.agency,
     this.agencyCode,
     this.vslHeight,
     this.beam,
     this.loa,
     this.lbp,
     this.maxDraft,
     this.parallelBody,
     this.bowMainfold,
     this.grt,
     this.nrt,
     this.dwt,
     this.isSbt,
     this.reducedGrt,
     this.summerDeadWeight,
     this.teuCapacity,
     this.freeBoard,
     this.classSociety,
     this.hullInsurCompany,
     this.hullInsurValDt,
     this.vslStatus,
     this.ownerName,
     this.ownerEmailAddress,
     this.nationality,
     this.orgBranchId,
     this.isAmend,
     this.ownerCode,
     this.ownerAddress,
     this.ownerMob,
     this.agentCode,
     this.agentName,
     this.agentAddress,
     this.agentEmail,
     this.agentMobNo,
     this.chartererCode,
     this.chartererName,
     this.chartererAddress,
     this.chartererEmail,
     this.chartererMob,
     this.nationalityType,
     this.officialNo,
     this.vesselClass,
     this.vesselClassValue,
     this.vesselTerm,
     this.vesselTermValue,
     this.placeOfRegisty,
     this.builtYear,
     this.psaCode,
     this.psaName,
     this.depth,
     this.positionofBridge,
     this.areaOperation,
     this.areaOperationValue,
     this.standardDraught,
     this.vesselCapacity,
     this.displacement,
     this.cargotype,
     this.cargotypeValue,
     this.vslHeightUnit,
     this.beamUnit,
     this.loaUnit,
     this.bowToMainFoldUnit,
     this.grtUnit,
     this.nrtUnit,
     this.dwtUnit,
     this.lbpUnit,
     this.maxDraftUnit,
     this.parallelBodyUnit,
     this.reduceGrtUnit,
     this.depthUnit,
     this.draughtUnit,
     this.freeBoardUnit,
     this.sumDeadWeightUnit,
     this.displacementUnit,
     this.teuUnit,
     this.vesselCapUnit,
     this.otherVslTypeId,
     this.otherVslTypeValue,
     this.hullTypeId,
     this.hullTypeValue,
     this.vslWithGearId,
     this.ownerCountryId,
     this.ownerStateId,
     this.ownerCityId,
     this.ownerPincode,
     this.chartererCountryId,
     this.chartererStateId,
     this.chartererCityId,
     this.chartererPincode,
     this.agentCountryId,
     this.agentStateId,
     this.agentCityId,
     this.agentPincode,
     this.suspendBy,
     this.marineBranchId,
     this.isVesselSharing,
     this.vesselIdOman,
     this.imoCount,
     this.docFileFolder,
     this.documentList,
     this.pAndIList,
    this.marineBranchValue
  });

  factory VesselDetailsModel.fromJson(Map<String?, dynamic> json) => VesselDetailsModel(
    orgId: json["ORG_ID"],
    refNo: json["REF_NO"],
    vesselId: json["VesselID"],
    vslType: json["VSL_TYPE"],
    vslTypeValue: json["VSL_TYPE_VALUE"]??"",
    placeOfRegistyCode: json["PlaceOfRegistyCode"],
    placeOfRegistyName: json["PlaceOfRegistyName"],
    placeOfRegistartionCode: json["PlaceOfRegistartionCode"],
    placeOfRegistartionName: json["PlaceOfRegistartionName"],
    serviceName: json["Service_Name"],
    shippingAgent: json["ShippingAgent"],
    shippingAgentCode: json["ShippingAgentCode"],
    shippingAgentId: json["ShippingAgentID"],
    ownerCountry: json["OwnerCountry"],
    ownerState: json["OwnerState"],
    ownerCity: json["OwnerCity"],
    chartererCountry: json["ChartererCountry"],
    chartererState: json["ChartererState"],
    chartererCity: json["ChartererCity"],
    agentCountry: json["AgentCountry"],
    agentState: json["AgentState"],
    agentCity: json["AgentCity"],
    pvrId: json["PVR_ID"],
    shpPrefix: json["SHP_PREFIX"],
    vslName: json["VSL_NAME"],
    callsign: json["CALLSIGN"],
    exVslName: json["EX_VSL_NAME"],
    exCallsign: json["EX_CALLSIGN"],
    modeTransport: json["MODE_TRANSPORT"],
    imoNo: json["IMO_NO"],
    vslBldgPlace: json["VSL_BLDG_PLACE"],
    permShpRegDt: json["PERM_SHP_REG_DT"],
    shpRegValDt:json["SHP_REG_VAL_DT"],
    shpRegCertNo: json["SHP_REG_CERT_NO"],
    isSafetyManagCert: json["IS_SAFETY_MANAG_CERT"],
    safetyManagCertValDt: json["SAFETY_MANAG_CERT_VAL_DT"],
    safetyManagCertNo: json["SAFETY_MANAG_CERT_NO"],
    isps: json["ISPS"],
    isCapiiCert: json["IS_CAPII_CERT"],
    agency: json["AGENCY"],
    agencyCode: json["AGENCY_CODE"],
    vslHeight: json["VSL_HEIGHT"],
    beam: json["Beam"],
    loa: json["LOA"],
    lbp: json["LBP"],
    maxDraft: json["Max_DRAFT"],
    parallelBody: json["ParallelBody"],
    bowMainfold: json["BOW_MAINFOLD"],
    grt: json["GRT"],
    nrt: json["NRT"],
    dwt: json["DWT"],
    isSbt: json["IS_SBT"],
    reducedGrt: json["REDUCED_GRT"],
    summerDeadWeight: json["SUMMER_DEAD_WEIGHT"],
    teuCapacity: json["TEU_CAPACITY"],
    freeBoard: json["FREE_BOARD"],
    classSociety: json["CLASS_SOCIETY"],
    hullInsurCompany: json["HULL_INSUR_COMPANY"],
    hullInsurValDt: json["HULL_INSUR_VAL_DT"],
    vslStatus: json["VSL_STATUS"],
    ownerName: json["OWNER_NAME"],
    ownerEmailAddress: json["OWNER_EMAIL_ADDRESS"],
    nationality: json["NATIONALITY"],
    orgBranchId: json["OrgBranchId"],
    isAmend: json["IsAmend"],
    ownerCode: json["OwnerCode"],
    ownerAddress: json["OwnerAddress"],
    ownerMob: json["OwnerMob"],
    agentCode: json["AgentCode"],
    agentName: json["AgentName"],
    agentAddress: json["AgentAddress"],
    agentEmail: json["AgentEmail"],
    agentMobNo: json["AgentMobNo"],
    chartererCode: json["ChartererCode"],
    chartererName: json["ChartererName"],
    chartererAddress: json["ChartererAddress"],
    chartererEmail: json["ChartererEmail"],
    chartererMob: json["ChartererMob"],
    nationalityType: json["NationalityType"],
    officialNo: json["OfficialNo"],
    vesselClass: json["VesselClass"],
    vesselClassValue: json["VesselClass_Value"],
    vesselTerm: json["VesselTerm"],
    vesselTermValue: json["VesselTerm_Value"],
    placeOfRegisty: json["PlaceOfRegisty"],
    builtYear: json["BuiltYear"],
    psaCode: json["PSACode"],
    psaName: json["PSAName"],
    depth: json["Depth"],
    positionofBridge: json["PositionofBridge_Value"],
    areaOperation: json["AreaOperation"],
    areaOperationValue: json["AreaOperation_Value"],
    standardDraught: json["StandardDraught"],
    vesselCapacity: json["VesselCapacity"],
    displacement: json["Displacement"],
    cargotype: json["Cargotype"],
    cargotypeValue: json["Cargotype_Value"],
    vslHeightUnit: json["VslHeightUnit"],
    beamUnit: json["BeamUnit"],
    loaUnit: json["LOAUnit"],
    bowToMainFoldUnit: json["BowToMainFoldUnit"],
    grtUnit: json["GrtUnit"],
    nrtUnit: json["NRTUnit"],
    dwtUnit: json["DWTUnit"],
    lbpUnit: json["LBPUnit"],
    maxDraftUnit: json["MaxDraftUnit"],
    parallelBodyUnit: json["ParallelBodyUnit"],
    reduceGrtUnit: json["ReduceGRTUnit"],
    depthUnit: json["DepthUnit"],
    draughtUnit: json["DraughtUnit"],
    freeBoardUnit: json["FreeBoardUnit"],
    sumDeadWeightUnit: json["SumDeadWeightUnit"],
    displacementUnit: json["DisplacementUnit"],
    teuUnit: json["TEUUnit"],
    vesselCapUnit: json["VesselCapUnit_Value"],
    otherVslTypeId: json["OtherVSLTypeID"],
    otherVslTypeValue: json["OtherVSLType_Value"],
    hullTypeId: json["HullTypeID"],
    hullTypeValue: json["HullType_Value"],
    vslWithGearId: json["VSLWithGearID"],
    ownerCountryId: json["OwnerCountryID"],
    ownerStateId: json["OwnerStateID"],
    ownerCityId: json["OwnerCityID"],
    ownerPincode: json["OwnerPincode"],
    chartererCountryId: json["ChartererCountryID"],
    chartererStateId: json["ChartererStateID"],
    chartererCityId: json["ChartererCityID"],
    chartererPincode: json["ChartererPincode"],
    agentCountryId: json["AgentCountryID"],
    agentStateId: json["AgentStateID"],
    agentCityId: json["AgentCityID"],
    agentPincode: json["AgentPincode"],
    suspendBy: json["SuspendBy"],
    marineBranchId: json["MarineBranchID"],
    isVesselSharing: json["IsVesselSharing"],
    vesselIdOman: json["VesselIDOman"],
    imoCount: json["ImoCount"],
    docFileFolder: json["DocFileFolder"],
    marineBranchValue:json["MarineBranch_Value"],
    documentList: List<DocumentList>.from(json["DocumentList"].map((x) => DocumentList.fromJson(x))),
    pAndIList: List<VesselRegistrationPiDetails>.from(json["vesselRegistrationPI_DETAILs"].map((x) => VesselRegistrationPiDetails.fromJson(x))),
  );

  Map<String?, dynamic> toJson() => {
    "ORG_ID": orgId,
    "REF_NO": refNo,
    "VesselID": vesselId,
    "VSL_TYPE": vslType,
    "VSL_TYPE_VALUE": vslTypeValue,
    "PlaceOfRegistyCode": placeOfRegistyCode,
    "PlaceOfRegistyName": placeOfRegistyName,
    "PlaceOfRegistartionCode": placeOfRegistartionCode,
    "PlaceOfRegistartionName": placeOfRegistartionName,
    "Service_Name": serviceName,
    "ShippingAgent": shippingAgent,
    "ShippingAgentCode": shippingAgentCode,
    "ShippingAgentID": shippingAgentId,
    "OwnerCountry": ownerCountry,
    "OwnerState": ownerState,
    "OwnerCity": ownerCity,
    "ChartererCountry": chartererCountry,
    "ChartererState": chartererState,
    "ChartererCity": chartererCity,
    "AgentCountry": agentCountry,
    "AgentState": agentState,
    "AgentCity": agentCity,
    "PVR_ID": pvrId,
    "SHP_PREFIX": shpPrefix,
    "VSL_NAME": vslName,
    "CALLSIGN": callsign,
    "EX_VSL_NAME": exVslName,
    "EX_CALLSIGN": exCallsign,
    "MODE_TRANSPORT": modeTransport,
    "IMO_NO": imoNo,
    "VSL_BLDG_PLACE": vslBldgPlace,
    "PERM_SHP_REG_DT": permShpRegDt,
    "SHP_REG_VAL_DT": shpRegValDt,
    "SHP_REG_CERT_NO": shpRegCertNo,
    "IS_SAFETY_MANAG_CERT": isSafetyManagCert,
    "SAFETY_MANAG_CERT_VAL_DT": safetyManagCertValDt,
    "SAFETY_MANAG_CERT_NO": safetyManagCertNo,
    "ISPS": isps,
    "IS_CAPII_CERT": isCapiiCert,
    "AGENCY": agency,
    "AGENCY_CODE": agencyCode,
    "VSL_HEIGHT": vslHeight,
    "Beam": beam,
    "LOA": loa,
    "LBP": lbp,
    "Max_DRAFT": maxDraft,
    "ParallelBody": parallelBody,
    "BOW_MAINFOLD": bowMainfold,
    "GRT": grt,
    "NRT": nrt,
    "DWT": dwt,
    "IS_SBT": isSbt,
    "REDUCED_GRT": reducedGrt,
    "SUMMER_DEAD_WEIGHT": summerDeadWeight,
    "TEU_CAPACITY": teuCapacity,
    "FREE_BOARD": freeBoard,
    "CLASS_SOCIETY": classSociety,
    "HULL_INSUR_COMPANY": hullInsurCompany,
    "HULL_INSUR_VAL_DT": hullInsurValDt,
    "VSL_STATUS": vslStatus,
    "OWNER_NAME": ownerName,
    "OWNER_EMAIL_ADDRESS": ownerEmailAddress,
    "NATIONALITY": nationality,
    "OrgBranchId": orgBranchId,
    "IsAmend": isAmend,
    "OwnerCode": ownerCode,
    "OwnerAddress": ownerAddress,
    "OwnerMob": ownerMob,
    "AgentCode": agentCode,
    "AgentName": agentName,
    "AgentAddress": agentAddress,
    "AgentEmail": agentEmail,
    "AgentMobNo": agentMobNo,
    "ChartererCode": chartererCode,
    "ChartererName": chartererName,
    "ChartererAddress": chartererAddress,
    "ChartererEmail": chartererEmail,
    "ChartererMob": chartererMob,
    "NationalityType": nationalityType,
    "OfficialNo": officialNo,
    "VesselClass": vesselClass,
    "VesselClass_Value": vesselClassValue,
    "VesselTerm": vesselTerm,
    "VesselTerm_Value": vesselTermValue,
    "PlaceOfRegisty": placeOfRegisty,
    "BuiltYear": builtYear,
    "PSACode": psaCode,
    "PSAName": psaName,
    "Depth": depth,
    "PositionofBridge": positionofBridge,
    "AreaOperation": areaOperation,
    "AreaOperation_Value": areaOperationValue,
    "StandardDraught": standardDraught,
    "VesselCapacity": vesselCapacity,
    "Displacement": displacement,
    "Cargotype": cargotype,
    "Cargotype_Value": cargotypeValue,
    "VslHeightUnit": vslHeightUnit,
    "BeamUnit": beamUnit,
    "LOAUnit": loaUnit,
    "BowToMainFoldUnit": bowToMainFoldUnit,
    "GrtUnit": grtUnit,
    "NRTUnit": nrtUnit,
    "DWTUnit": dwtUnit,
    "LBPUnit": lbpUnit,
    "MaxDraftUnit": maxDraftUnit,
    "ParallelBodyUnit": parallelBodyUnit,
    "ReduceGRTUnit": reduceGrtUnit,
    "DepthUnit": depthUnit,
    "DraughtUnit": draughtUnit,
    "FreeBoardUnit": freeBoardUnit,
    "SumDeadWeightUnit": sumDeadWeightUnit,
    "DisplacementUnit": displacementUnit,
    "TEUUnit": teuUnit,
    "VesselCapUnit": vesselCapUnit,
    "OtherVSLTypeID": otherVslTypeId,
    "OtherVSLType_Value": otherVslTypeValue,
    "HullTypeID": hullTypeId,
    "HullType_Value": hullTypeValue,
    "VSLWithGearID": vslWithGearId,
    "OwnerCountryID": ownerCountryId,
    "OwnerStateID": ownerStateId,
    "OwnerCityID": ownerCityId,
    "OwnerPincode": ownerPincode,
    "ChartererCountryID": chartererCountryId,
    "ChartererStateID": chartererStateId,
    "ChartererCityID": chartererCityId,
    "ChartererPincode": chartererPincode,
    "AgentCountryID": agentCountryId,
    "AgentStateID": agentStateId,
    "AgentCityID": agentCityId,
    "AgentPincode": agentPincode,
    "SuspendBy": suspendBy,
    "MarineBranchID": marineBranchId,
    "IsVesselSharing": isVesselSharing,
    "VesselIDOman": vesselIdOman,
    "ImoCount": imoCount,
    "DocFileFolder": docFileFolder,
    "DocumentList": null,
    "vesselRegistrationPI_DETAILs": null,
  };
}

class DocumentList {
  int? id;
  int? vslId;
  String? fileName;
  String? saveFileName;
  String? docTitle;
  String? docExpiry;
  dynamic issuingAuthority;

  DocumentList({
    required this.id,
    required this.vslId,
    required this.fileName,
    required this.saveFileName,
    required this.docTitle,
    required this.docExpiry,
    required this.issuingAuthority,
  });

  factory DocumentList.fromJson(Map<String?, dynamic> json) => DocumentList(
    id: json["ID"],
    vslId: json["Vsl_id"],
    fileName: json["FileName"],
    saveFileName: json["SaveFileName"],
    docTitle: json["DocTitle"],
    docExpiry: json["DocExpiry"],
    issuingAuthority: json["IssuingAuthority"],
  );

  Map<String?, dynamic> toJson() => {
    "ID": id,
    "Vsl_id": vslId,
    "FileName": fileName,
    "SaveFileName": saveFileName,
    "DocTitle": docTitle,
    "DocExpiry": docExpiry,
    "IssuingAuthority": issuingAuthority,
  };
}

class VesselRegistrationPiDetails {
  int operationType;
  int piId;
  int pvrId;
  String piName;
  String piValidityUpto;
  String localCorrespondent;
  dynamic isDeleted;
  int orgId;
  int createdBy;
  String createdOn;
  dynamic updatedBy;
  dynamic updatedOn;

  VesselRegistrationPiDetails({
    required this.operationType,
    required this.piId,
    required this.pvrId,
    required this.piName,
    required this.piValidityUpto,
    required this.localCorrespondent,
    required this.isDeleted,
    required this.orgId,
    required this.createdBy,
    required this.createdOn,
    required this.updatedBy,
    required this.updatedOn,
  });

  factory VesselRegistrationPiDetails.fromJson(Map<String, dynamic> json) => VesselRegistrationPiDetails(
    operationType: json["OperationType"],
    piId: json["PI_ID"],
    pvrId: json["PVR_ID"],
    piName: json["PI_NAME"],
    piValidityUpto: json["PI_VALIDITY_UPTO"],
    localCorrespondent: json["LOCAL_CORRESPONDENT"],
    isDeleted: json["IS_DELETED"],
    orgId: json["ORG_ID"],
    createdBy: json["CREATED_BY"],
    createdOn: json["CREATED_ON"],
    updatedBy: json["UPDATED_BY"],
    updatedOn: json["UPDATED_ON"],
  );

  Map<String, dynamic> toJson() => {
    "OperationType": operationType,
    "PI_ID": piId,
    "PVR_ID": pvrId,
    "PI_NAME": piName,
    "PI_VALIDITY_UPTO": piValidityUpto,
    "LOCAL_CORRESPONDENT": localCorrespondent,
    "IS_DELETED": isDeleted,
    "ORG_ID": orgId,
    "CREATED_BY": createdBy,
    "CREATED_ON": createdOn,
    "UPDATED_BY": updatedBy,
    "UPDATED_ON": updatedOn,
  };
}