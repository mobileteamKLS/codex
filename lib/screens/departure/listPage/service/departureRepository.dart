import '../../../../api/app_service.dart';
import '../../../../core/global.dart';
import '../model/departureListModel.dart';

abstract class DepartureRepository {
  Future<VesselListResponse> getAllVessels({
    String? vesselId,
    String? imoName,
    String? vesselName,
    String? status,
    int pageIndex = 1,
    int pageSize = 200,
  });
}

class VesselRepositoryImpl implements DepartureRepository {
  @override
  Future<VesselListResponse> getAllVessels({
    String? vesselId,
    String? imoName,
    String? vesselName,
    String? status,
    int pageIndex = 1,
    int pageSize = 200,
  }) async {
    try {
      final response = await ApiService().request(
        endpoint: "/api_pcs1/DepartureClearance/GetAll",
        method: "POST",
        body: {
          "OperationType": 2,
          "CurrentPortEntity": null,
          "OrgId": loginDetailsMaster.organizationId,
          "Client": loginDetailsMaster.userAccountTypeId,
          "NameofAgent": loginDetailsMaster.orgTypeName,
          "VesselName": vesselName,
          "VCN":null,
          "IMONo": null,
          "FlagOfVessel": null,
          "status": null,
          "ClearanceType": null,
          "NameOfMaster": null,
          "VesselType": null,
          "CreatedBy": configMaster.createdBy,
          "OrgBranchId": loginDetailsMaster.organizationBranchId,
          "validfromdt": null,
          "validtodt": null,
          "VESSELCountryFLAG": null,
          "Client": int.parse(configMaster.clientID),
          "PageIndex": pageIndex,
          "PageSize": pageSize,
          "CountryID": configMaster.countryId,
          "IsExportToExcel": null,
          "DR_ID": null,
          "VesselID": null
        },
      );

      if (response is Map<String, dynamic> && response["StatusCode"] == 200) {
        if (response["data"] == null) {
          return VesselListResponse(
            vessels: [],
            hasMoreData: false,
            hasNoRecord: true,
            statusMessage: response["StatusMessage"] ?? "No data found",
          );
        }

        List<dynamic> jsonData = response["data"];
        bool hasNoRecord = response["Status"] == "05";

        List<DepartureListModel> vessels = jsonData
            .map((json) => DepartureListModel.fromJson(json))
            .toList();

        return VesselListResponse(
          vessels: vessels,
          hasMoreData: jsonData.length == pageSize,
          hasNoRecord: hasNoRecord,
          statusMessage: response["StatusMessage"] ?? "Success",
        );
      } else {
        throw Exception(response["StatusMessage"] ?? "API failed");
      }
    } catch (e) {
      throw Exception("API Call Failed: $e");
    }
  }
}

class VesselListResponse {
  final List<DepartureListModel> vessels;
  final bool hasMoreData;
  final bool hasNoRecord;
  final String statusMessage;

  VesselListResponse({
    required this.vessels,
    required this.hasMoreData,
    required this.hasNoRecord,
    required this.statusMessage,
  });
}