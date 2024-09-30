import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/theme/color/app_color.dart';
import '../../../../core/widget/opacity_container.dart';
import '../../../home/data/model/fetch_all_service_model.dart';
import '../widget/bottom_app_bar_widget.dart';
import 'find_location_book_service.dart';

class ServiceDetailsPage extends StatelessWidget {
  final FetchAllServiceModel service;

  const ServiceDetailsPage({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
      
          icon: const Center(
            child: FaIcon(
              FontAwesomeIcons.chevronLeft,
              size: 30,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Book a Service',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: AppColor.secondary,
                fontSize: 30,
              ),
        ),
        backgroundColor: AppColor.background,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: 250,
                child: Image.network(
                  service.serviceImg,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        AppColor.secondary.withOpacity(0.6),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              service.serviceName,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.copyWith(
                                    color: AppColor.background,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          
          Column(
            children: [
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: OpacityContainer(),
                  ),
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: AppColor.secondary,
                        ),
                  ),
                ],
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Text(service.description,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontWeight: FontWeight.w400)),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'First Hour Chrage',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: AppColor.primary,
                              borderRadius: BorderRadius.circular(10)),
                          height: 40,
                          width: 120,
                          child: Center(
                            child: Text(
                              '₹ ${service.firstHourCharge.toString()}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.background),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 400,
                    child: Divider(
                        // thickness: 0.8,
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Second Hour Chrage',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: AppColor.primary,
                              borderRadius: BorderRadius.circular(10)),
                          height: 40,
                          width: 120,
                          child: Center(
                            child: Text(
                              '₹ ${service.laterHourCharge.toString()}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.background),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
     bottomNavigationBar: BottomAppBarWidget(
          leftButtonText: 'Back',
          rightButtonText: 'Book Now',
          onLeftButtonPressed: () {
            Navigator.of(context).pop();
          },
          onRightButtonPressed: () {
            Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          FindLocationBookService(service: service)),
                );
          },
        ),
    );
  }
}
