// import 'package:door_care/feature/navigation_menu/page/home_navigation_menu.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:toastification/toastification.dart';
// import '../../../../core/theme/color/app_color.dart';
// import '../../../../core/widget/toastifiaction_widget.dart';
// import '../../../home/data/model/fetch_all_service_model.dart';
// import '../../bloc/stepper_navigation_bloc/navigation_bloc.dart';
// import '../widget/bottom_app_bar_widget.dart';
// import 'comepleted_book_service.dart';
// import 'enter_details_book_service.dart';
// import 'find_location_book_service.dart';

// class HomeStepperWidget extends StatefulWidget {
//   final FetchAllServiceModel service;

//   const HomeStepperWidget({super.key, required this.service});

//   @override
//   State<HomeStepperWidget> createState() => _HomeStepperWidgetState();
// }

// class _HomeStepperWidgetState extends State<HomeStepperWidget> {
//   final List<Widget> _pages = [];
//   final GlobalKey<FormState> formKeyEnterDetails = GlobalKey<FormState>();
//   @override
//   void initState() {
//     super.initState();
//     _pages.addAll(
//       [
//         FindLocationBookService(),
//         EnterDetailsBookService(
//             service: widget.service, formKey: formKeyEnterDetails),
//         CompletedBookService(),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Ensure the StepperNavigationBloc state is initialized to the first page
//     //  context.read<StepperNavigationBloc>().add(const PageChangedEvent(0));
//     return BlocBuilder<StepperNavigationBloc, StepperNavigationState>(
//       builder: (context, state) {
//         int selectedIndex = 0;
//         if (state is StepperNavigationPageState) {
//           selectedIndex = state.pageIndex;
//         }
//         String leftButtonText;
//         String rightButtonText;
//         if (selectedIndex == 0) {
//           leftButtonText = 'Cancel';
//           rightButtonText = 'Next';
//         } else if (selectedIndex == 1) {
//           leftButtonText = 'Back';
//           rightButtonText = 'Finish';
//         } else {
//           leftButtonText = 'Cancel';
//           rightButtonText = 'Continue';
//         }
//         return Scaffold(
//           body: SafeArea(
//             child: Column(
//               children: [
//                 Container(
//                   color: AppColor.background,
//                   height: 80,
//                   width: double.infinity,
//                   child: Padding(
//                     padding: const EdgeInsets.only(top: 15),
//                     child: StepperWidget(currentStep: selectedIndex + 1),
//                   ),
//                 ),
//                 Flexible(child: _pages[selectedIndex]),
//               ],
//             ),
//           ),
//           bottomNavigationBar: BottomAppBarWidget(
//             leftButtonText: leftButtonText,
//             rightButtonText: rightButtonText,
//             onNavigate: (int step) {
//               int newIndex = selectedIndex + step;

//               // Check if the current page is valid
//               if (selectedIndex == 1 &&
//                   !formKeyEnterDetails.currentState!.validate()) {
//                 // Show error or prompt user to correct the errors
//                 ToastificationWidget.show(
//                   context: context,
//                   type: ToastificationType.error,
//                   title: 'Validation error',
//                   description: 'Please fill all required fields!',
//                 );
//                 return;
//               }

//               // Navigate to HomePage when back is pressed on the first step
//               if (newIndex < 0) {
//                 Navigator.of(context).pushReplacement(
//                   MaterialPageRoute(builder: (contex) => HomeNavigationMenu()),
//                 );
//               } else if (newIndex >= _pages.length) {
//                 // Navigate to HomePage when next is pressed on the last step
//                 Navigator.of(context).pushReplacement(
//                   MaterialPageRoute(builder: (contex) => HomeNavigationMenu()),
//                 );
//                 // Ensure the StepperNavigationBloc state is initialized to the first page
//                 context
//                     .read<StepperNavigationBloc>()
//                     .add(const PageChangedEvent(0));
//               } else {
//                 // Navigate within the steps
//                 context
//                     .read<StepperNavigationBloc>()
//                     .add(PageChangedEvent(newIndex));
//               }
//             },
//           ),
//         );
//       },
//     );
//   }
// }

// class StepperWidget extends StatelessWidget {
//   final int currentStep;

//   const StepperWidget({super.key, required this.currentStep});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         buildStep(
//           title: 'Location',
//           isActive: currentStep >= 1,
//         ),
//         Padding(
//           padding: const EdgeInsets.only(bottom: 20),
//           child: Container(
//             height: 3,
//             width: 80,
//             color: AppColor.toneEight.withOpacity(0.6),
//           ),
//         ),
//         buildStep(
//           title: 'Details',
//           isActive: currentStep >= 2,
//         ),
//         Padding(
//           padding: const EdgeInsets.only(bottom: 20),
//           child: Container(
//             height: 3,
//             width: 80,
//             color: AppColor.toneEight.withOpacity(0.6),
//           ),
//         ),
//         buildStep(
//           title: 'Success',
//           isActive: currentStep >= 3,
//         ),
//       ],
//     );
//   }

//   Widget buildStep({required String title, required bool isActive}) {
//     return Column(
//       children: [
//         CircleAvatar(
//           radius: 20,
//           backgroundColor: isActive ? AppColor.primary : AppColor.toneFive,
//           child: isActive
//               ? const Icon(
//                   FontAwesomeIcons.check,
//                   color: AppColor.background,
//                 )
//               : null,
//         ),
//         const SizedBox(height: 4),
//         Text(
//           title,
//           style: TextStyle(
//             fontSize: 12,
//             color: isActive ? AppColor.secondary : AppColor.toneThree,
//           ),
//         ),
//       ],
//     );
//   }
// }