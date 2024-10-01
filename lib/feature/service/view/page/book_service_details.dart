import 'package:flutter/material.dart';
import '../../../../core/theme/color/app_color.dart';
import '../../../../core/widget/appbar_widget.dart';
import '../../../../core/widget/opacity_container.dart';
import '../../../home/data/model/fetch_all_service_model.dart';
import '../widget/bottom_app_bar_widget.dart';
import 'find_location_book_service.dart';

class ServiceDetailsPage extends StatelessWidget {
  final FetchAllServiceModel service;

  const ServiceDetailsPage({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
     double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
    appBar: const AppBarSingle(),
      body: SingleChildScrollView(
        child: Column(
          children: [
             Padding(
               padding: const EdgeInsets.only(left: 10),
               child: Row(
                        children: [
                          const OpacityContainer(),
                          const SizedBox(width: 10),
                          Text(
                            'Service Details',
                            style:
                                Theme.of(context).textTheme.headlineLarge?.copyWith(
                                      color: AppColor.secondary,
                                      fontSize: 25,
                                    ),
                          ),
                        ],
                      ),
             ),
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 220,
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
            const SizedBox(height: 10),
            
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
                 SizedBox(
                width: screenWidth * 0.9,
                  child:Text(service.description,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontWeight: FontWeight.w400)), 
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
                     SizedBox(
                      width: screenWidth * 0.92,
                      child:const Divider(
                           thickness: 0.6,
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
