import 'package:lottie/lottie.dart';
import '../widget/service_card.dart';
import 'package:flutter/material.dart';
import '../../../../core/util/jason_asset.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/color/app_color.dart';
import '../../../../core/widget/padding_widget.dart';
import '../../data/model/fetch_all_service_model.dart';
import '../../../../core/widget/opacity_container.dart';
import '../../data/repository/fetch_all_services_repo.dart';
import '../../../service/view/page/book_service_details.dart';
import 'package:door_care/feature/auth/auth_bloc/auth_bloc.dart';
import 'package:door_care/feature/home/view/widget/search_widget.dart';
import '../../data/service/remote/fetch_all_services_remote_service.dart';
import '../../fetch_all_added_services_bloc/fetch_all_added_services_bloc.dart';


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
          child: Column(
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
              Expanded(
                child: BlocBuilder<FetchAllAddedServicesBloc,
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
                        return SingleChildScrollView(
                          child: Center(
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
                          ),
                        );
                      }
                // Display filtered services
                      return ListView.builder(
                        itemCount: filteredServices.length, // Use filteredServices here
                        itemBuilder: (context, index) {
                          final service = filteredServices[index]; // Use filteredServices
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ServiceDetailsPage(
                                    service: service,
                                  ),
                                ),
                              );
                            },
                            child: ServiceCard(
                              image: service.serviceImg,
                              title: service.serviceName,
                            
                            ),
                          );
                        },
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
              ),
            
            ],
          ),
        ),
      ),
    );
  }
}
