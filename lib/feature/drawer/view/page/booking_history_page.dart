import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/theme/color/app_color.dart';
import '../../../../core/util/jason_asset.dart';
import '../../../../core/widget/appbar_widget.dart';
import '../../../../core/widget/opacity_container.dart';
import '../../../auth/data/service/local/auth_local_service.dart';
import '../../../bookings/bloc/fetch_all_completed_service_bloc/fetch_all_completed_service_bloc.dart';
import '../../../bookings/data/repository/fetch_all_completed_repo.dart';
import '../../../bookings/data/service/remote/fetch_all_completed_remote.dart';
import '../../../bookings/view/widgets/card_widget_three.dart';
import '../../../bookings/view/widgets/card_widget_two.dart';

class BookingHistoryPage extends StatelessWidget {
  const BookingHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchAllCompletedServiceBloc(
        FetchAllCompletedRepo(FetchAllCompletedRemote(), AuthLocalService()),
      )..add(FetchAllPaymentEnteredServiceEvent()),
      child: Scaffold(
        appBar: const AppBarSingle(),
        body: BlocBuilder<FetchAllCompletedServiceBloc,
            FetchAllCompletedServiceState>(
          builder: (context, state) {
            if (state is FetchAllCompletedServiceLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FetchAllCompletedServiceSuccessState) {
              final services = state.fetchAllCompletedServiceModel;

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
                        'No Completed Services Available',
                        style: TextStyle(
                            color: AppColor.secondary.withOpacity(0.8)),
                      ),
                    ],
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 16,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const OpacityContainer(),
                        const SizedBox(width: 10),
                        Text(
                          'History',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(
                                color: AppColor.secondary,
                                fontSize: 30,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: services.length,
                        itemBuilder: (context, index) {
                          final service = services[index];
                          return CardWidgetThree(service: service);
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is FetchAllCompletedServiceFailState) {
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
