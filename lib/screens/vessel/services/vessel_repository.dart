import '../../../api/app_service.dart';
import '../../../core/global.dart';
import '../model/vessel_list_model.dart';

abstract class VesselRepository {
  Future<VesselListResponse> getAllVessels({
    String? vesselId,
    String? imoName,
    String? vesselName,
    String? status,
    int pageIndex = 1,
    int pageSize = 10,
  });
}

class VesselRepositoryImpl implements VesselRepository {
  @override
  Future<VesselListResponse> getAllVessels({
    String? vesselId,
    String? imoName,
    String? vesselName,
    String? status,
    int pageIndex = 1,
    int pageSize = 10,
  }) async {
    try {
      final response = await ApiService().request(
        endpoint: "/api_pcs1/Vessel/GetAllVesselRegistration",
        method: "POST",
        body: {
          "Client": loginDetailsMaster.userAccountTypeId,
          "OrgId": loginDetailsMaster.organizationId,
          "OperationType": 2,
          "OrgType": loginDetailsMaster.orgTypeName,
          "ServiceName": null,
          "VesselId": vesselId,
          "ImoNo": imoName,
          "VesselName": vesselName,
          "AgentName": null,
          "VesselType": null,
          "VesselStatus": status,
          "Nationality": null,
          "CurrentPortEntity": -1,
          "PlaceOfRegistry": 0,
          "PageIndex": pageIndex,
          "PageSize": pageSize
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

        List<VesselListModel> vessels = jsonData
            .map((json) => VesselListModel.fromJson(json))
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
  final List<VesselListModel> vessels;
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