import 'dart:developer';
import '../model/fetch_all_service_model.dart';
import '../service/remote/fetch_all_services_remote_service.dart';

class FetchAllServiceRepo {
  final FetchAllServicesRemoteService _fetchAllServicesRemoteService;

  FetchAllServiceRepo(
    this._fetchAllServicesRemoteService,
  );

  Future<List<FetchAllServiceModel>> fetchServicesDetails() async {
    try {
      var response =
          await _fetchAllServicesRemoteService.fetchAllServiceDetails();

      if (response.statusCode == 200) {
        final List<dynamic> responseData =
            response.data['data'] as List<dynamic>;
        final List<FetchAllServiceModel> fetchAllServiceModel = responseData
            .map((service) =>
                FetchAllServiceModel.fromMap(service as Map<String, dynamic>))
            .toList();

        return fetchAllServiceModel;
      } else {
        log('fetch user details failed${response.statusCode}');
        throw Exception();
      }
    } catch (e) {
      log(e.toString());
      throw Exception();
    }
  }
}
