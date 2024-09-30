import 'package:door_care/feature/manageService/chat/data/service/remote/start_chat.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';
import '../../../../core/theme/color/app_color.dart';
import '../../../../core/util/png_asset.dart';
import '../../../../core/widget/padding_widget.dart';
import '../../../../core/widget/toastifiaction_widget.dart';
import '../../../auth/view/widget/loading_dialog.dart';
import '../../../manageService/chat/bloc/bloc/create_conversation_bloc.dart';
import '../../../manageService/chat/view/chat_page.dart';
import '../../../manageService/chat/view/chat_page_three.dart';
import '../../data/model/fetch_all_booked_service_model.dart';
import 'location_fetching_widget.dart';

class CardWidgetTwo extends StatelessWidget {
  const CardWidgetTwo({
    super.key,
    required this.service,
  });

  final FetchAllBookedServiceModel service;

  @override
  Widget build(BuildContext context) {
    void navigateToChatPage(String senderId, String receiverId) async {
      try {
        // Get the conversation details from the API
        final response = await startConversation(senderId, receiverId);

        final conversationId = response['conversationId'];
        final workername = response['workername'];
        final workerProfile = response['workerProfile'];

        // Navigate to the chat page with the obtained conversation ID, username, and user profile
        Navigator.push(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
            builder: (context) => ChatPageThree(
              conversationId: conversationId,
              senderId: senderId,
              receiverId: receiverId,
              workername: workername,
              workerProfile: workerProfile,
            ),
          ),
        );
      } catch (e) {
        // Handle errors if the API call fails
        if (kDebugMode) {
          print('Error: $e');
        }
        // Optionally, show an error message to the user
      }
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColor.toneThree.withOpacity(0.4),
          ),
        ),
        child: PaddingWidget(
          // padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: service.serviceImg.isNotEmpty
                        ? NetworkImage(service.serviceImg)
                        : const AssetImage(AppPngPath.homeCleanTwo),
                    // onBackgroundImageError:
                    //     (exception, stackTrace) {
                    //   // Optionally handle image loading errors here
                    // },
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service.serviceName,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Booking ID:${service.id}',
                        style: const TextStyle(
                          color: AppColor.toneThree,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 5),
              const Divider(),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Work Status',
                    style: TextStyle(
                      color: AppColor.toneThree,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Chip(
                    side: BorderSide.none,
                    label: Text(
                      '${service.status}ted',
                      style: const TextStyle(color: AppColor.toneSix),
                    ),
                    backgroundColor: AppColor.toneSix.withOpacity(0.2),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Payment Status',
                    style: TextStyle(
                      color: AppColor.toneThree,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Chip(
                    side: BorderSide.none,
                    label: const Text(
                      'Pending',
                      style: TextStyle(color: AppColor.toneSix),
                    ),
                    backgroundColor: AppColor.toneSix.withOpacity(0.2),
                  ),
                ],
              ),
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColor.toneThree.withOpacity(0.7),
                          width: 1.0,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset("assets/svg/booking_one.svg"),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    DateFormat('dd-MM-yyyy').format(service.createdAt),
                    style: const TextStyle(
                      color: AppColor.secondary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              LocationFetchingWidget(
                latitude: service.latitude,
                longitude: service.longitude,
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(),
              BlocListener<CreateConversationBloc, CreateConversationState>(
                listener: (context, state) {
                  if (state is CreateConversationLoadingState) {
                    LoadingDialog.show(context);
                  } else if (state is CreateConversationSuccessState) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatPage(
                          conversation: state.conversationModel,
                        ),
                      ),
                    );
                    // ToastificationWidget.show(
                    //   context: context,
                    //   type: ToastificationType.success,
                    //   title: 'Success',
                    //   description: 'Successfully created chat with User',
                    // );
                  } else if (state is CreateConversationFailState) {
                    ToastificationWidget.show(
                      context: context,
                      type: ToastificationType.error,
                      title: 'Error',
                      description: 'Failed to Start conversation with User',
                    );
                  }
                },
                child: Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      // context.read<CreateConversationBloc>().add(
                      //       CreateAConversationEvent(
                      //         receiverId: service.userId,
                      //       ),
                      //     );
                      navigateToChatPage(service.userId, service.workerId!);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Chat',
                      style: TextStyle(color: AppColor.background),
                    ),
                  ),
                ),
              ),
              // Align(
              //   alignment: Alignment.centerRight,
              //   child: ElevatedButton(
              //     onPressed: () {
              //       context.read<CancelABookedPendingServiceBloc>().add(
              //             CancelBookedPendingServiceEvent(
              //               bookingId: service.id,
              //             ),
              //           );
              //     },
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: AppColor.toneSeven.withOpacity(0.8),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(8),
              //       ),
              //     ),
              //     child: const Text(
              //       'Cancel',
              //       style: TextStyle(color: AppColor.background),
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
