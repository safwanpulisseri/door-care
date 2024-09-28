import 'package:door_care/feature/home/view/widget/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:door_care/feature/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:door_care/feature/home/bloc/bloc/fetch_all_added_services_bloc.dart';
import 'package:door_care/feature/home/data/repository/fetch_all_services_repo.dart';
import 'package:door_care/feature/home/data/service/remote/fetch_all_services_remote_service.dart';
import 'package:door_care/feature/service/view/page/book_service_details.dart';
import '../../../../core/theme/color/app_color.dart';
import '../../../../core/util/jason_asset.dart';
import '../../../../core/widget/opacity_container.dart';
import '../../../../core/widget/padding_widget.dart';
import 'package:lottie/lottie.dart';
import '../../data/model/fetch_all_service_model.dart';
import '../widget/join_our_team.dart';
import '../widget/service_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Controller to handle search input
  TextEditingController searchController = TextEditingController();
  List<FetchAllServiceModel> allServices = []; // List of all services
  List<FetchAllServiceModel> filteredServices =
      []; // Filtered list of services based on search

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchAllAddedServicesBloc(
          FetchAllServiceRepo(FetchAllServicesRemoteService()))
        ..add(FetchAllServicesEvent()),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
          title: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthSuccessState) {
                final userName = state.userModel.name;
                return Text(
                  'HELLO ${userName.toUpperCase()} 👋',
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                );
              } else {
                return const Text('HELLO USER 👋');
              }
            },
          ),
          backgroundColor: AppColor.background,
        ),
        body: PaddingWidget(
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'What you are looking for today',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: AppColor.secondary,
                          fontSize: 35,
                        ),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 16),

                  // Updated SearchWidget with controller and callback
                  SearchWidget(
                    controller: searchController,
                    onChanged: (query) {
                      setState(
                        () {
                          filteredServices = allServices
                              .where((service) => service.serviceName
                                  .toLowerCase()
                                  .contains(query.toLowerCase()))
                              .toList();
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  // Conditionally change the text based on search query
                  Row(
                    children: [
                      const OpacityContainer(),
                      const SizedBox(width: 10),
                      Text(
                        searchController.text.isEmpty
                            ? 'All Services'
                            : 'Search Results',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(color: AppColor.secondary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Bloc to handle fetching services
                  BlocBuilder<FetchAllAddedServicesBloc,
                      FetchAllAddedServicesState>(
                    builder: (context, state) {
                      if (state is FetchAllAddedServicesLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is FetchAllAddedServicesSuccessState) {
                        allServices = state.fetchAllServiceModel;

                        // If no search query, show all services
                        if (filteredServices.isEmpty &&
                            searchController.text.isEmpty) {
                          filteredServices = allServices;
                        }

                        // Show message if no services match the search query
                        if (filteredServices.isEmpty &&
                            searchController.text.isNotEmpty) {
                          return Center(
                            child: Column(
                              children: [
                                Lottie.asset(AppJasonPath.failedToFetch,
                                    height: 150, width: 150),
                                const Text(
                                  'No results found',
                                  style: TextStyle(color: AppColor.toneSeven),
                                ),
                              ],
                            ),
                          );
                        }

                        return SizedBox(
                          height: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: filteredServices.length,
                            itemBuilder: (context, index) {
                              final service = filteredServices[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ServiceDetailsPage(service: service),
                                    ),
                                  );
                                },
                                child: ServiceCard(
                                  image: service.serviceImg,
                                  title: service.serviceName,
                                ),
                              );
                            },
                          ),
                        );
                      } else if (state is FetchAllAddedServicesFailState) {
                        return Center(
                          child: Column(
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
                  Row(
                    children: [
                      const OpacityContainer(),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Join Our Team',
                        style:
                            Theme.of(context).textTheme.headlineLarge?.copyWith(
                                  color: AppColor.secondary,
                                ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const JoinOurTeamCard(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
