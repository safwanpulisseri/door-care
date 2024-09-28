// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:door_care/feature/bookings/data/model/fetch_all_booked_service_model.dart';
// import 'card_widget_three.dart'; // Import the CardWidgetThree widget
// import '../../../../core/theme/color/app_color.dart';
// import '../../../../core/util/jason_asset.dart';

// class UnpaidServicesList extends StatelessWidget {
//   const UnpaidServicesList({
//     super.key,
//     required this.services,
//   });
//   final List<FetchAllBookedServiceModel> services;
//   @override
//   Widget build(BuildContext context) {
//     // Filter the list to get only unpaid services
//     final unpaidServices =
//         services.where((service) => !service.payment).toList();

//     return unpaidServices.isEmpty
//         ? Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Lottie.asset(AppJasonPath.failedToFetch,
//                     height: 150, width: 150),
//                 const Text(
//                   'No Unpaid Services Available',
//                   style: TextStyle(color: AppColor.toneSeven),
//                 ),
//               ],
//             ),
//           )
//         : ListView.builder(
//             itemCount: unpaidServices.length,
//             itemBuilder: (context, index) {
//               final service = unpaidServices[index];
//               return CardWidgetThree(service: service);
//             },
//           );
//   }
// }
