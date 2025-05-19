

class LoginDetails {
  int userId;
  int userAccountTypeId;
  String firstName;
  String middleName;
  String lastName;
  int organizationId;
  int organizationBranchId;
  String branchName;
  bool isExternalUser;
  String password;
  String salt;
  bool isUserActive;
  bool isOrganizationActive;
  bool isOrganizationBranchActive;
  String orgTypeName;
  String orgName;
  String address;
  String token;
  String wwwRootPath;

  LoginDetails({
    required this.userId,
    required this.userAccountTypeId,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.organizationId,
    required this.organizationBranchId,
    required this.branchName,
    required this.isExternalUser,
    required this.password,
    required this.salt,
    required this.isUserActive,
    required this.isOrganizationActive,
    required this.isOrganizationBranchActive,
    required this.orgTypeName,
    required this.orgName,
    required this.address,
    required this.token,
    required this.wwwRootPath,
  });

  factory LoginDetails.fromJson(Map<String, dynamic> json) => LoginDetails(
    userId: json["UserId"],
    userAccountTypeId: json["UserAccountTypeId"],
    firstName: json["FirstName"],
    middleName: json["MiddleName"],
    lastName: json["LastName"],
    organizationId: json["OrganizationId"],
    organizationBranchId: json["OrganizationBranchId"],
    branchName: json["BranchName"],
    isExternalUser: json["IsExternalUser"],
    password: json["Password"],
    salt: json["Salt"],
    isUserActive: json["IsUserActive"],
    isOrganizationActive: json["IsOrganizationActive"],
    isOrganizationBranchActive: json["IsOrganizationBranchActive"],
    orgTypeName: json["OrgTypeName"],
    orgName: json["OrgName"],
    address: json["Address"],
    token: json["Token"],
    wwwRootPath: json["WWWRootPath"],
  );

  Map<String, dynamic> toJson() => {
    "UserId": userId,
    "UserAccountTypeId": userAccountTypeId,
    "FirstName": firstName,
    "MiddleName": middleName,
    "LastName": lastName,
    "OrganizationId": organizationId,
    "OrganizationBranchId": organizationBranchId,
    "BranchName": branchName,
    "IsExternalUser": isExternalUser,
    "Password": password,
    "Salt": salt,
    "IsUserActive": isUserActive,
    "IsOrganizationActive": isOrganizationActive,
    "IsOrganizationBranchActive": isOrganizationBranchActive,
    "OrgTypeName": orgTypeName,
    "OrgName": orgName,
    "Address": address,
    "Token": token,
    "WWWRootPath": wwwRootPath,
  };
}