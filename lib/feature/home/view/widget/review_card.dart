// import 'package:door_care/core/theme/color/app_color.dart';
// import 'package:flutter/material.dart';

// class ReviewCard extends StatelessWidget {
//   const ReviewCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 16.0),
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: AppColor.toneOne.withOpacity(0.5),
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Rosna CT',
//               style: Theme.of(context)
//                   .textTheme
//                   .headlineLarge
//                   ?.copyWith(color: AppColor.secondary, fontSize: 18),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'I am extremely pleased with the service\nprovided by FixIt. The technicians were\nhighly skilled and knowledgeable.',
//               style: Theme.of(context).textTheme.titleSmall?.copyWith(
//                   color: AppColor.secondary, fontWeight: FontWeight.w400),
//             ),
//             const SizedBox(height: 8),
//             Row(
//               children: [
//                 Container(
//                   height: 30,
//                   width: 120,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     color: Colors.white,
//                   ),
//                   child: Row(
//                     children: List.generate(5, (index) {
//                       return Icon(
//                         index < 4 ? Icons.star : Icons.star_border_rounded,
//                         color: index < 4 ? AppColor.starColour : null,
//                       );
//                     }),
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 50,
//                 ),
//                 Text(
//                   'Reviewed on 30/03/2024',
//                   style: Theme.of(context)
//                       .textTheme
//                       .headlineMedium
//                       ?.copyWith(color: AppColor.secondary, fontSize: 13),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
