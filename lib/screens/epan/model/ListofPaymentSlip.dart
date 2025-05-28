class ListofPaymentSlip {
  ListofPaymentSlip({
      this.id, 
      this.vOYId, 
      this.fileName, 
      this.saveFileName, 
      this.docTitle, 
      this.docExpiry, 
      this.isDelete, 
      this.createdDate, 
      this.updatedDate, 
      this.vsldocid, 
      this.issuingAuthority, 
      this.issuedDate, 
      this.expiryDateRequired, 
      this.isFALCorrection, 
      this.isFALInsertion, 
      this.faldocid,});

  ListofPaymentSlip.fromJson(dynamic json) {
    id = json['ID'];
    vOYId = json['VOY_Id'];
    fileName = json['FileName'];
    saveFileName = json['SaveFileName'];
    docTitle = json['DocTitle'];
    docExpiry = json['DocExpiry'];
    isDelete = json['IsDelete'];
    createdDate = json['CreatedDate'];
    updatedDate = json['UpdatedDate'];
    vsldocid = json['VSLDOCID'];
    issuingAuthority = json['IssuingAuthority'];
    issuedDate = json['IssuedDate'];
    expiryDateRequired = json['ExpiryDateRequired'];
    isFALCorrection = json['isFALCorrection'];
    isFALInsertion = json['isFALInsertion'];
    faldocid = json['FALDOCID'];
  }
  int? id;
  int? vOYId;
  String? fileName;
  String? saveFileName;
  String? docTitle;
  String? docExpiry;
  int? isDelete;
  String? createdDate;
  dynamic updatedDate;
  int? vsldocid;
  String? issuingAuthority;
  String? issuedDate;
  String? expiryDateRequired;
  dynamic isFALCorrection;
  dynamic isFALInsertion;
  dynamic faldocid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = id;
    map['VOY_Id'] = vOYId;
    map['FileName'] = fileName;
    map['SaveFileName'] = saveFileName;
    map['DocTitle'] = docTitle;
    map['DocExpiry'] = docExpiry;
    map['IsDelete'] = isDelete;
    map['CreatedDate'] = createdDate;
    map['UpdatedDate'] = updatedDate;
    map['VSLDOCID'] = vsldocid;
    map['IssuingAuthority'] = issuingAuthority;
    map['IssuedDate'] = issuedDate;
    map['ExpiryDateRequired'] = expiryDateRequired;
    map['isFALCorrection'] = isFALCorrection;
    map['isFALInsertion'] = isFALInsertion;
    map['FALDOCID'] = faldocid;
    return map;
  }

}