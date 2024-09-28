import 'package:door_care/feature/bookings/view/widgets/card_widget_two.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/theme/color/app_color.dart';
import '../../../../core/util/jason_asset.dart';
import '../../../auth/data/service/local/auth_local_service.dart';
import '../../bloc/fetch_all_commited_service_bloc/fetch_all_commited_service_bloc.dart';
import '../../data/repository/fetch_all_committed_service_repo.dart';
import '../../data/service/remote/fetch_all_committed_service_remote.dart';

class TabScreenTwo extends StatelessWidget {
  const TabScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchAllCommitedServiceBloc(
        FetchAllCommitedServiceRepo(
            FetchAllCommitedServiceRemote(), AuthLocalService()),
      )..add(FetchCommitedServicesEvent()),
      child: Scaffold(
        body: BlocBuilder<FetchAllCommitedServiceBloc,
            FetchAllCommitedServiceState>(
          builder: (context, state) {
            if (state is FetchAllCommitedServiceLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FetchAllCommitedServiceSuccessState) {
              final services = state.fetchAllCommitedServiceModel;
              if (services.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.ban,
                        color: AppColor.toneThree,
                        size: 40,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'No Committed Services Available',
                        style: TextStyle(
                            color: AppColor.secondary.withOpacity(0.8)),
                      ),
                    ],
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    final service = services[index];
                    return CardWidgetTwo(service: service);
                  },
                ),
              );
            } else if (state is FetchAllCommitedServiceFailState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(AppJasonPath.failedToFetch,
                        height: 150, width: 150),
                    const Text(
                      'Failed to Fetch Services',
                      style: TextStyle(color: AppColor.toneSeven),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(AppJasonPath.failedToFetch,
                        height: 150, width: 150),
                    const Text(
                      'No Services Available',
                      style: TextStyle(color: AppColor.toneSeven),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
