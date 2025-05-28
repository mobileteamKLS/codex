class ListofLastTenPortofCall {
  ListofLastTenPortofCall({
      this.sno, 
      this.id, 
      this.epanId, 
      this.portId, 
      this.arrival, 
      this.departure, 
      this.secutityLevel, 
      this.isDelete, 
      this.createBy, 
      this.createDate, 
      this.updateBy, 
      this.updateDate, 
      this.portcode, 
      this.portName,});

  ListofLastTenPortofCall.fromJson(dynamic json) {
    sno = json['Sno'];
    id = json['Id'];
    epanId = json['Epan_Id'];
    portId = json['PortId'];
    arrival = json['Arrival'];
    departure = json['Departure'];
    secutityLevel = json['SecutityLevel'];
    isDelete = json['IsDelete'];
    createBy = json['CreateBy'];
    createDate = json['CreateDate'];
    updateBy = json['UpdateBy'];
    updateDate = json['UpdateDate'];
    portcode = json['portcode'];
    portName = json['portName'];
  }
  int? sno;
  int? id;
  int? epanId;
  int? portId;
  String? arrival;
  String? departure;
  String? secutityLevel;
  bool? isDelete;
  int? createBy;
  String? createDate;
  dynamic updateBy;
  dynamic updateDate;
  String? portcode;
  String? portName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Sno'] = sno;
    map['Id'] = id;
    map['Epan_Id'] = epanId;
    map['PortId'] = portId;
    map['Arrival'] = arrival;
    map['Departure'] = departure;
    map['SecutityLevel'] = secutityLevel;
    map['IsDelete'] = isDelete;
    map['CreateBy'] = createBy;
    map['CreateDate'] = createDate;
    map['UpdateBy'] = updateBy;
    map['UpdateDate'] = updateDate;
    map['portcode'] = portcode;
    map['portName'] = portName;
    return map;
  }

}