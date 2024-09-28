import 'package:door_care/feature/bookings/bloc/cancel_a_pending_service_bloc/cancel_a_booked_pending_service_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:toastification/toastification.dart';
import '../../../../core/theme/color/app_color.dart';
import '../../../../core/util/jason_asset.dart';
import '../../../../core/widget/toastifiaction_widget.dart';
import '../../../auth/data/service/local/auth_local_service.dart';
import '../../../auth/view/widget/loading_dialog.dart';
import '../../bloc/fetch_all_booked_pending_service_bloc/fetch_all_pending_services_bloc.dart';
import '../../data/repository/cancel_a_booked_pending_service_repo.dart';
import '../../data/repository/fetch_all_booked_pending_service_repo.dart';
import '../../data/service/remote/cancel_a_booked_pending_service.dart';
import '../../data/service/remote/fetch_all_booked_pending_service_details.dart';
import '../widgets/card_widget.dart';

class TabScreenOne extends StatefulWidget {
  const TabScreenOne({super.key});

  @override
  State<TabScreenOne> createState() => _TabScreenOneState();
}

class _TabScreenOneState extends State<TabScreenOne> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchAllPendingServicesBloc(
        FetchAllBookedServiceRepo(
            FetchAllBookedServiceDetails(), AuthLocalService()),
      )..add(FetchAllBookedPendingServicesEvent()),
      child: Scaffold(
        body: BlocBuilder<FetchAllPendingServicesBloc,
            FetchAllPendingServicesState>(
          builder: (context, state) {
            if (state is FetchAllPendingServicesLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FetchAllPendingServicesSuccessState) {
              final services = state.fetchAllBookedServiceModel;
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
                        'No Pending Services Available',
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
                    return BlocProvider(
                      create: (context) => CancelABookedPendingServiceBloc(
                        CancelABookedPendingServiceRepo(
                          CancelABookedPendingService(),
                          AuthLocalService(),
                        ),
                      ),
                      child: BlocListener<CancelABookedPendingServiceBloc,
                          CancelABookedPendingServiceState>(
                        listener: (context, cancelState) {
                          if (cancelState
                              is CancelABookedPendingServiceLoadingState) {
                            LoadingDialog.show(context);
                          } else if (cancelState
                              is CancelABookedPendingServiceSuccessState) {
                            Navigator.pop(context);
                            ToastificationWidget.show(
                              context: context,
                              type: ToastificationType.success,
                              title: 'Success',
                              description:
                                  'Service booking cancelled successfully',
                            );
                            // Trigger a reload of the pending services
                            context
                                .read<FetchAllPendingServicesBloc>()
                                .add(FetchAllBookedPendingServicesEvent());
                          } else if (cancelState
                              is CancelABookedPendingServiceFailState) {
                            Navigator.pop(context);
                            ToastificationWidget.show(
                              context: context,
                              type: ToastificationType.error,
                              title: 'Error',
                              description: 'Failed to cancel service booking',
                            );
                          }
                        },
                        child: CardWidget(service: service),
                      ),
                    );
                  },
                ),
              );
            } else if (state is FetchAllPendingServicesFailState) {
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
