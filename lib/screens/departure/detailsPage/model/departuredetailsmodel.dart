class DepartureDetailsModel {
  int? voyId;
  int? immAppStatus;
  int? cusStatus;
  int? marineStatus;
  int? portHealthStatus;
  String? vesselId;
  String? berthNo;
  String? arrivalDt;
  String? departureDt;
  double? grt;
  String? grtUnit;
  String? nrtUnit;
  int? nextPortId;
  String? nextPortCode;
  String? nextPortName;
  int? lastPortId;
  String? lastPortCode;
  String? lastPortName;
  int? portRegistryId;
  String? portRegistryCode;
  String? portRegistryName;
  int? finalPortId;
  String? finalPortCode;
  String? finalPortName;
  int? drId;
  String? vcn;
  String? imoNo;
  String? vesselName;
  String? voyage;
  String? vesselType;
  String? flagOfVessel;
  String? portRegistry;
  dynamic nextPort;
  int? noofCrew;
  int? passengersOnBoard;
  int? status;
  String? officialNo;
  String? vesselNationalityType;
  String? nrt;
  String? nameofCaption;
  dynamic containerised;
  dynamic nonContainerised;
  dynamic empty20;
  dynamic empty40;
  dynamic loaded20;
  dynamic loaded40;
  int? uomCon;
  int? uomNonCon;
  String? wepoanofboard;
  String? makeModel;
  String? quantity;
  String? nameofAgent;
  String? icNo;
  String? designation;
  String? docSignedStampedImmigrationclearnaceFilename;
  String? docSignedStampedImmigrationclearnaceContenttype;
  String? entryCustomStation;
  String? entryCustomStationDr;
  int? orgBranchId;
  String? noDuesFileName;
  String? noDues;
  String? isMyCountry;
  String? ptsNumber;
  String? portofDepartureId;
  String? departurePortCode;
  String? departurePortPortName;
  String? entityRemarks;
  String? isApprover;
  String? exitCustomStation;
  String? contUnit;
  String? nonConUnit;
  String? vesselTypeName;
  String? docFileFolderCrewList;
  String? docFileFolderPassengerList;
  String? docFileFolderDcAttachment;
  List<LstGood>? lstGoods;
  List<LstDepartureCrew>? lstDepartureCrew;
  List<dynamic>? lstPassengers;
  List<LstUploadDetail>? lstUploadDetails;
  String? remarksbyPortHealth;
  String? portName;

  DepartureDetailsModel({
    this.voyId,
    this.immAppStatus,
    this.cusStatus,
    this.marineStatus,
    this.portHealthStatus,
    this.vesselId,
    this.berthNo,
    this.arrivalDt,
    this.departureDt,
    this.grt,
    this.grtUnit,
    this.nrtUnit,
    this.nextPortId,
    this.nextPortCode,
    this.nextPortName,
    this.lastPortId,
    this.lastPortCode,
    this.lastPortName,
    this.portRegistryId,
    this.portRegistryCode,
    this.portRegistryName,
    this.finalPortId,
    this.finalPortCode,
    this.finalPortName,
    this.drId,
    this.vcn,
    this.imoNo,
    this.vesselName,
    this.voyage,
    this.vesselType,
    this.flagOfVessel,
    this.portRegistry,
    this.nextPort,
    this.noofCrew,
    this.passengersOnBoard,
    this.status,
    this.officialNo,
    this.vesselNationalityType,
    this.nrt,
    this.nameofCaption,
    this.containerised,
    this.nonContainerised,
    this.empty20,
    this.empty40,
    this.loaded20,
    this.loaded40,
    this.uomCon,
    this.uomNonCon,
    this.wepoanofboard,
    this.makeModel,
    this.quantity,
    this.nameofAgent,
    this.icNo,
    this.designation,
    this.docSignedStampedImmigrationclearnaceFilename,
    this.docSignedStampedImmigrationclearnaceContenttype,
    this.entryCustomStation,
    this.entryCustomStationDr,
    this.orgBranchId,
    this.noDuesFileName,
    this.noDues,
    this.isMyCountry,
    this.ptsNumber,
    this.portofDepartureId,
    this.departurePortCode,
    this.departurePortPortName,
    this.entityRemarks,
    this.isApprover,
    this.exitCustomStation,
    this.contUnit,
    this.nonConUnit,
    this.vesselTypeName,
    this.docFileFolderCrewList,
    this.docFileFolderPassengerList,
    this.docFileFolderDcAttachment,
    this.lstGoods,
    this.lstDepartureCrew,
    this.lstPassengers,
    this.lstUploadDetails,
    this.remarksbyPortHealth,
    this.portName,
  });

  factory DepartureDetailsModel.fromJson(Map<String, dynamic> json) => DepartureDetailsModel(
    voyId: json["Voy_ID"],
    immAppStatus: json["ImmAppStatus"],
    cusStatus: json["CusStatus"],
    marineStatus: json["MarineStatus"],
    portHealthStatus: json["PortHealthStatus"],
    vesselId: json["VesselID"],
    berthNo: json["BerthNo"],
    arrivalDt: json["ArrivalDt"],
    departureDt: json["DepartureDt"],
    grt: json["GRT"],
    grtUnit: json["GrtUnit"],
    nrtUnit: json["NRTUnit"],
    nextPortId: json["NextPortId"],
    nextPortCode: json["NextPortCode"],
    nextPortName: json["NextPortName"],
    lastPortId: json["LastPortId"],
    lastPortCode: json["LastPortCode"],
    lastPortName: json["LastPortName"],
    portRegistryId: json["PortRegistryId"],
    portRegistryCode: json["PortRegistryCode"],
    portRegistryName: json["PortRegistryName"],
    finalPortId: json["FinalPortId"],
    finalPortCode: json["FinalPortCode"],
    finalPortName: json["FinalPortName"],
    drId: json["DR_ID"],
    vcn: json["VCN"],
    imoNo: json["IMONo"],
    vesselName: json["VesselName"],
    voyage: json["Voyage"],
    vesselType: json["VesselType"],
    flagOfVessel: json["FlagOfVessel"],
    portRegistry: json["PortRegistry"],
    nextPort: json["NextPort"],
    noofCrew: json["NoofCrew"],
    passengersOnBoard: json["PassengersOnBoard"],
    status: json["status"],
    officialNo: json["OfficialNo"],
    vesselNationalityType: json["VesselNationalityType"],
    nrt: json["NRT"],
    nameofCaption: json["NameofCaption"],
    containerised: json["Containerised"],
    nonContainerised: json["NonContainerised"],
    empty20: json["Empty20"],
    empty40: json["Empty40"],
    loaded20: json["Loaded20"],
    loaded40: json["Loaded40"],
    uomCon: json["UOMCon"],
    uomNonCon: json["UOMNonCon"],
    wepoanofboard: json["wepoanofboard"],
    makeModel: json["MakeModel"],
    quantity: json["Quantity"],
    nameofAgent: json["NameofAgent"],
    icNo: json["ICNo"],
    designation: json["Designation"],
    docSignedStampedImmigrationclearnaceFilename: json["DOC_SIGNED_STAMPED_IMMIGRATIONCLEARNACE_FILENAME"],
    docSignedStampedImmigrationclearnaceContenttype: json["DOC_SIGNED_STAMPED_IMMIGRATIONCLEARNACE_CONTENTTYPE"],
    entryCustomStation: json["EntryCustomStation"],
    entryCustomStationDr: json["EntryCustomStationDR"],
    orgBranchId: json["OrgBranchId"],
    noDuesFileName: json["NoDuesFileName"],
    noDues: json["NoDues"],
    isMyCountry: json["IsMYCountry"],
    ptsNumber: json["PTSNumber"],
    portofDepartureId: json["PortofDepartureId"],
    departurePortCode: json["DeparturePortCode"],
    departurePortPortName: json["DeparturePortPortName"],
    entityRemarks: json["EntityRemarks"],
    isApprover: json["IsApprover"],
    exitCustomStation: json["ExitCustomStation"],
    contUnit: json["contUnit"],
    nonConUnit: json["NonConUnit"],
    vesselTypeName: json["VesselTypeName"],
    docFileFolderCrewList: json["DocFileFolder_CrewList"],
    docFileFolderPassengerList: json["DocFileFolder_PassengerList"],
    docFileFolderDcAttachment: json["DocFileFolder_DCAttachment"],
    lstGoods: json["lstGoods"] == null ? [] : List<LstGood>.from(json["lstGoods"]!.map((x) => LstGood.fromJson(x))),
    lstDepartureCrew: json["lstDepartureCrew"] == null ? [] : List<LstDepartureCrew>.from(json["lstDepartureCrew"]!.map((x) => LstDepartureCrew.fromJson(x))),
    lstPassengers: json["lstPassengers"] == null ? [] : List<dynamic>.from(json["lstPassengers"]!.map((x) => x)),
    lstUploadDetails: json["lstUploadDetails"] == null ? [] : List<LstUploadDetail>.from(json["lstUploadDetails"]!.map((x) => LstUploadDetail.fromJson(x))),
    remarksbyPortHealth: json["RemarksbyPortHealth"],
      portName:json["portNameTextWithComma"]
  );

  Map<String, dynamic> toJson() => {
    "Voy_ID": voyId,
    "ImmAppStatus": immAppStatus,
    "CusStatus": cusStatus,
    "MarineStatus": marineStatus,
    "PortHealthStatus": portHealthStatus,
    "VesselID": vesselId,
    "BerthNo": berthNo,
    "ArrivalDt": arrivalDt,
    "DepartureDt": departureDt,
    "GRT": grt,
    "GrtUnit": grtUnit,
    "NRTUnit": nrtUnit,
    "NextPortId": nextPortId,
    "NextPortCode": nextPortCode,
    "NextPortName": nextPortName,
    "LastPortId": lastPortId,
    "LastPortCode": lastPortCode,
    "LastPortName": lastPortName,
    "PortRegistryId": portRegistryId,
    "PortRegistryCode": portRegistryCode,
    "PortRegistryName": portRegistryName,
    "FinalPortId": finalPortId,
    "FinalPortCode": finalPortCode,
    "FinalPortName": finalPortName,
    "DR_ID": drId,
    "VCN": vcn,
    "IMONo": imoNo,
    "VesselName": vesselName,
    "Voyage": voyage,
    "VesselType": vesselType,
    "FlagOfVessel": flagOfVessel,
    "PortRegistry": portRegistry,
    "NextPort": nextPort,
    "NoofCrew": noofCrew,
    "PassengersOnBoard": passengersOnBoard,
    "status": status,
    "OfficialNo": officialNo,
    "VesselNationalityType": vesselNationalityType,
    "NRT": nrt,
    "NameofCaption": nameofCaption,
    "Containerised": containerised,
    "NonContainerised": nonContainerised,
    "Empty20": empty20,
    "Empty40": empty40,
    "Loaded20": loaded20,
    "Loaded40": loaded40,
    "UOMCon": uomCon,
    "UOMNonCon": uomNonCon,
    "wepoanofboard": wepoanofboard,
    "MakeModel": makeModel,
    "Quantity": quantity,
    "NameofAgent": nameofAgent,
    "ICNo": icNo,
    "Designation": designation,
    "DOC_SIGNED_STAMPED_IMMIGRATIONCLEARNACE_FILENAME": docSignedStampedImmigrationclearnaceFilename,
    "DOC_SIGNED_STAMPED_IMMIGRATIONCLEARNACE_CONTENTTYPE": docSignedStampedImmigrationclearnaceContenttype,
    "EntryCustomStation": entryCustomStation,
    "EntryCustomStationDR": entryCustomStationDr,
    "OrgBranchId": orgBranchId,
    "NoDuesFileName": noDuesFileName,
    "NoDues": noDues,
    "IsMYCountry": isMyCountry,
    "PTSNumber": ptsNumber,
    "PortofDepartureId": portofDepartureId,
    "DeparturePortCode": departurePortCode,
    "DeparturePortPortName": departurePortPortName,
    "EntityRemarks": entityRemarks,
    "IsApprover": isApprover,
    "ExitCustomStation": exitCustomStation,
    "contUnit": contUnit,
    "NonConUnit": nonConUnit,
    "VesselTypeName": vesselTypeName,
    "DocFileFolder_CrewList": docFileFolderCrewList,
    "DocFileFolder_PassengerList": docFileFolderPassengerList,
    "DocFileFolder_DCAttachment": docFileFolderDcAttachment,
    "lstGoods": lstGoods == null ? [] : List<dynamic>.from(lstGoods!.map((x) => x.toJson())),
    "lstDepartureCrew": lstDepartureCrew == null ? [] : List<dynamic>.from(lstDepartureCrew!.map((x) => x.toJson())),
    "lstPassengers": lstPassengers == null ? [] : List<dynamic>.from(lstPassengers!.map((x) => x)),
    "lstUploadDetails": lstUploadDetails == null ? [] : List<dynamic>.from(lstUploadDetails!.map((x) => x.toJson())),
    "RemarksbyPortHealth": remarksbyPortHealth,
  };
}

class LstDepartureCrew {
  int? crewId;
  int? crewDetailId;
  String? crewListFamilyName;
  String? crewListGivenName;
  String? crewListRankRating;
  String? crewListNationality;
  String? crewListDob;
  String? crewListPlaceOfBirth;
  String? crewListGender;
  String? crewListNatureOfDoc;
  String? issueCountryText;
  String? crewListNoofIdentityDoc;
  String? crewListIssueStateDoc;
  dynamic crewListExpiryDateOfDoc;
  dynamic crewListCountryIssueDate;
  String? crewType;
  dynamic crewListIssueNationality;
  dynamic crewListLastPortOfCall;
  dynamic crewListNextPortOfCall;
  dynamic crewListXml;
  dynamic crewListStatus;
  String? crewListDateEmbark;
  String? crewListDateDisEmbark;
  String? crewListDateIdentityDate;
  String? fileName;
  String? saveFileName;
  String? docTitle;
  dynamic docExpiry;
  dynamic multiUploadXml;
  dynamic departureId;
  dynamic pageIndex;
  dynamic pageSize;
  dynamic recordCount;
  String? rowNumber;
  dynamic immigrationRemarks;
  dynamic fromDt;
  dynamic toDt;

  LstDepartureCrew({
    this.crewId,
    this.crewDetailId,
    this.crewListFamilyName,
    this.crewListGivenName,
    this.crewListRankRating,
    this.crewListNationality,
    this.crewListDob,
    this.crewListPlaceOfBirth,
    this.crewListGender,
    this.crewListNatureOfDoc,
    this.issueCountryText,
    this.crewListNoofIdentityDoc,
    this.crewListIssueStateDoc,
    this.crewListExpiryDateOfDoc,
    this.crewListCountryIssueDate,
    this.crewType,
    this.crewListIssueNationality,
    this.crewListLastPortOfCall,
    this.crewListNextPortOfCall,
    this.crewListXml,
    this.crewListStatus,
    this.crewListDateEmbark,
    this.crewListDateDisEmbark,
    this.crewListDateIdentityDate,
    this.fileName,
    this.saveFileName,
    this.docTitle,
    this.docExpiry,
    this.multiUploadXml,
    this.departureId,
    this.pageIndex,
    this.pageSize,
    this.recordCount,
    this.rowNumber,
    this.immigrationRemarks,
    this.fromDt,
    this.toDt,
  });

  factory LstDepartureCrew.fromJson(Map<String, dynamic> json) => LstDepartureCrew(
    crewId: json["CrewId"],
    crewDetailId: json["CrewDetailId"],
    crewListFamilyName: json["CrewListFamilyName"],
    crewListGivenName: json["CrewListGivenName"],
    crewListRankRating: json["CrewListRankRating"],
    crewListNationality: json["NationalityText"],
    issueCountryText: json["IssueCountryText"],
    crewListDob: json["CrewListDOB"],
    crewListPlaceOfBirth: json["CrewListPlaceOfBirth"],
    crewListGender: json["Gender"],
    crewListNatureOfDoc: json["CrewListNatureOfDoc"],
    crewListNoofIdentityDoc: json["CrewListNoofIdentityDoc"],
    crewListIssueStateDoc: json["CrewListIssueStateDoc"],
    crewListExpiryDateOfDoc: json["CrewListExpiryDateOfDoc"],
    crewListCountryIssueDate: json["CrewListCountryIssueDate"],
    crewType: json["CrewType"],
    crewListIssueNationality: json["CrewListIssueNationality"],
    crewListLastPortOfCall: json["CrewListLastPortOfCall"],
    crewListNextPortOfCall: json["CrewListNextPortOfCall"],
    crewListXml: json["CrewListXml"],
    crewListStatus: json["CrewListStatus"],
    crewListDateEmbark: json["DateEmbark"],
    crewListDateDisEmbark: json["DateDisEmbark"],
    crewListDateIdentityDate: json["CrewListDateIdentityDate"],
    fileName: json["FileName"],
    saveFileName: json["SaveFileName"],
    docTitle: json["DocTitle"],
    docExpiry: json["DocExpiry"],
    multiUploadXml: json["MultiUploadXml"],
    departureId: json["DepartureId"],
    pageIndex: json["PageIndex"],
    pageSize: json["PageSize"],
    recordCount: json["RecordCount"],
    rowNumber: json["RowNumber"],
    immigrationRemarks: json["ImmigrationRemarks"],
    fromDt: json["FromDt"],
    toDt: json["ToDt"],
  );

  Map<String, dynamic> toJson() => {
    "CrewId": crewId,
    "CrewDetailId": crewDetailId,
    "CrewListFamilyName": crewListFamilyName,
    "CrewListGivenName": crewListGivenName,
    "CrewListRankRating": crewListRankRating,
    "CrewListNationality": crewListNationality,
    "CrewListDOB": crewListDob,
    "CrewListPlaceOfBirth": crewListPlaceOfBirth,
    "CrewListGender": crewListGender,
    "CrewListNatureOfDoc": crewListNatureOfDoc,
    "CrewListNoofIdentityDoc": crewListNoofIdentityDoc,
    "CrewListIssueStateDoc": crewListIssueStateDoc,
    "CrewListExpiryDateOfDoc": crewListExpiryDateOfDoc,
    "CrewListCountryIssueDate": crewListCountryIssueDate,
    "CrewType": crewType,
    "CrewListIssueNationality": crewListIssueNationality,
    "CrewListLastPortOfCall": crewListLastPortOfCall,
    "CrewListNextPortOfCall": crewListNextPortOfCall,
    "CrewListXml": crewListXml,
    "CrewListStatus": crewListStatus,
    "CrewListDateEmbark": crewListDateEmbark,
    "CrewListDateDisEmbark": crewListDateDisEmbark,
    "CrewListDateIdentityDate": crewListDateIdentityDate,
    "FileName": fileName,
    "SaveFileName": saveFileName,
    "DocTitle": docTitle,
    "DocExpiry": docExpiry,
    "MultiUploadXml": multiUploadXml,
    "DepartureId": departureId,
    "PageIndex": pageIndex,
    "PageSize": pageSize,
    "RecordCount": recordCount,
    "RowNumber": rowNumber,
    "ImmigrationRemarks": immigrationRemarks,
    "FromDt": fromDt,
    "ToDt": toDt,
  };
}

class LstGood {
  int? departureId;
  int? desId;
  String? descName;
  String? grossWeight;
  dynamic grtUnit;
  String? remarks;
  dynamic isDeleted;
  dynamic orgId;
  dynamic createdBy;
  dynamic createdOn;
  dynamic updatedBy;
  dynamic updatedOn;
  dynamic orgBranchId;
  dynamic ipAddress;
  dynamic descGoodsxml;

  LstGood({
    this.departureId,
    this.desId,
    this.descName,
    this.grossWeight,
    this.grtUnit,
    this.remarks,
    this.isDeleted,
    this.orgId,
    this.createdBy,
    this.createdOn,
    this.updatedBy,
    this.updatedOn,
    this.orgBranchId,
    this.ipAddress,
    this.descGoodsxml,
  });

  factory LstGood.fromJson(Map<String, dynamic> json) => LstGood(
    departureId: json["DepartureId"],
    desId: json["DesId"],
    descName: json["Desc_Name"],
    grossWeight: json["Gross_Weight"],
    grtUnit: json["GRTUnit"],
    remarks: json["Remarks"],
    isDeleted: json["IS_DELETED"],
    orgId: json["ORG_ID"],
    createdBy: json["CREATED_BY"],
    createdOn: json["CREATED_ON"],
    updatedBy: json["UPDATED_BY"],
    updatedOn: json["UPDATED_ON"],
    orgBranchId: json["OrgBranchID"],
    ipAddress: json["IPAddress"],
    descGoodsxml: json["DESC_GOODSXML"],
  );

  Map<String, dynamic> toJson() => {
    "DepartureId": departureId,
    "DesId": desId,
    "Desc_Name": descName,
    "Gross_Weight": grossWeight,
    "GRTUnit": grtUnit,
    "Remarks": remarks,
    "IS_DELETED": isDeleted,
    "ORG_ID": orgId,
    "CREATED_BY": createdBy,
    "CREATED_ON": createdOn,
    "UPDATED_BY": updatedBy,
    "UPDATED_ON": updatedOn,
    "OrgBranchID": orgBranchId,
    "IPAddress": ipAddress,
    "DESC_GOODSXML": descGoodsxml,
  };
}

class LstUploadDetail {
  int? id;
  int? drId;
  String? fileName;
  String? saveFileName;
  String? docTitle;
  dynamic multiUploadXml;
  dynamic orgId;
  dynamic branchId;
  dynamic createdBy;
  dynamic uploadedBy;
  dynamic ipaddress;
  dynamic docExpiry;

  LstUploadDetail({
    this.id,
    this.drId,
    this.fileName,
    this.saveFileName,
    this.docTitle,
    this.multiUploadXml,
    this.orgId,
    this.branchId,
    this.createdBy,
    this.uploadedBy,
    this.ipaddress,
    this.docExpiry,
  });

  factory LstUploadDetail.fromJson(Map<String, dynamic> json) => LstUploadDetail(
    id: json["ID"],
    drId: json["DR_ID"],
    fileName: json["FileName"],
    saveFileName: json["SaveFileName"],
    docTitle: json["DocTitle"],
    multiUploadXml: json["MultiUploadXml"],
    orgId: json["OrgID"],
    branchId: json["BranchId"],
    createdBy: json["CreatedBy"],
    uploadedBy: json["UploadedBy"],
    ipaddress: json["Ipaddress"],
    docExpiry: json["DocExpiry"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "DR_ID": drId,
    "FileName": fileName,
    "SaveFileName": saveFileName,
    "DocTitle": docTitle,
    "MultiUploadXml": multiUploadXml,
    "OrgID": orgId,
    "BranchId": branchId,
    "CreatedBy": createdBy,
    "UploadedBy": uploadedBy,
    "Ipaddress": ipaddress,
    "DocExpiry": docExpiry,
  };
}