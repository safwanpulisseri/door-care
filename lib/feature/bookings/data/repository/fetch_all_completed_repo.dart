import 'dart:developer';
import '../../../auth/data/model/user_model.dart';
import '../../../auth/data/service/local/auth_local_service.dart';
import '../model/fetch_all_booked_service_model.dart';
import '../service/remote/fetch_all_completed_remote.dart';

class FetchAllCompletedRepo {
  final FetchAllCompletedRemote _fetchAllCompletedRemote;
  final AuthLocalService _authLocalService;

  FetchAllCompletedRepo(
    this._fetchAllCompletedRemote,
    this._authLocalService,
  );

  Future<List<FetchAllBookedServiceModel>>
      fetchAllCompletedRemoteServiceDetails() async {
    try {
      String? token = await _authLocalService.getToken();
      if (token == null) {
        throw Exception('No token Found');
      }
      UserModel? userModel = await _authLocalService.getUser();
      if (userModel == null) {
        throw Exception('No UserModel Found');
      }
      String userId = userModel.id;

      var response =
          await _fetchAllCompletedRemote.fetchAllCompletedRemoteService(
        token: token,
        userId: userId,
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData =
            response.data['data'] as List<dynamic>;
        final List<FetchAllBookedServiceModel> fetchAllServiceModel =
            responseData
                .map((service) => FetchAllBookedServiceModel.fromMap(
                    service as Map<String, dynamic>))
                .toList();

        return fetchAllServiceModel;
      } else {
        log('fetchAllCompletedRemoteService failed${response.statusCode}');
        throw Exception();
      }
    } catch (e) {
      log(e.toString());
      throw Exception();
    }
  }
}
