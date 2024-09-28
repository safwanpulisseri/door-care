import 'package:door_care/feature/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:door_care/feature/drawer/view/page/user_details.dart';
import 'package:door_care/core/theme/color/app_color.dart';
import 'package:door_care/core/util/png_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/widget/toastifiaction_widget.dart';
import '../auth/view/page/sign_in_page.dart';
import 'view/page/booking_history_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColor.primary,
      child: Column(
        children: [
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthSuccessState) {
                final user = state.userModel;
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => const UserDetailsPage(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 70, left: 10),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: AppColor.toneEleven,
                          backgroundImage: user.profileImg.isNotEmpty
                              ? NetworkImage(
                                  user.profileImg,
                                )
                              : const AssetImage(
                                  AppPngPath.personImage,
                                ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge
                                  ?.copyWith(
                                    color: AppColor.background,
                                    fontSize: 17,
                                  ),
                            ),
                            Text(
                              user.email,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: AppColor.background,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 13,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Text(
                  'Failed to Fetch Your Details',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: AppColor.background,
                        fontSize: 17,
                      ),
                );
              }
            },
          ),
          Expanded(
            child: ListView(
              children: [
                DrawerItem(
                  icon: IconlyLight.bookmark,
                  text: 'Bookings',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BookingHistoryPage(),
                      ),
                    );
                  },
                ),
                // const DrawerItem(
                // icon: IconlyLight.wallet,
                //   text: 'Payments Methods',
                // ),
                DrawerItem(
                  icon: IconlyLight.activity,
                  text: 'How to use',
                  onTap: () async {
                    await launchPrivacyPolicy();
                  },
                ),
                // const DrawerItem(
                //   icon: Icons.notifications,
                //   text: 'Notification',
                // ),
                DrawerItem(
                  icon: IconlyLight.paper,
                  text: 'Privacy Policy',
                  onTap: () async {
                    await launchPrivacyPolicy();
                  },
                ),

                DrawerItem(
                  icon: IconlyLight.message,
                  text: 'Terms & Conditions',
                  onTap: () async {
                    await launchPrivacyPolicy();
                  },
                ),
                DrawerItem(
                  icon: IconlyLight.infoSquare,
                  text: 'About us',
                  onTap: () async {
                    await launchPrivacyPolicy();
                  },
                ),
                // const DrawerItem(
                //   icon: Icons.share,
                //   text: 'Share App',
                // ),
                DrawerItem(
                  icon: IconlyLight.logout,
                  text: 'Log Out',
                  onTap: () {
                    context.read<AuthBloc>().add(SignOutEvent());
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const SignInPage()),
                      (Route<dynamic> route) => false,
                    );
                    ToastificationWidget.show(
                      context: context,
                      type: ToastificationType.success,
                      title: 'Success',
                      description: 'You have been signed out successfully.',
                    );
                  },
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColor.textfield.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            height: 40,
            width: 250,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(IconlyLight.infoSquare, color: AppColor.background),
                SizedBox(width: 10),
                Text('Pulisseri Production',
                    style: TextStyle(color: AppColor.background)),
              ],
            ),
          ),
          const SizedBox(height: 5),
          const Divider(
            thickness: 0.5,
            indent: 30,
            endIndent: 30,
          ),
          const Text(
            'version: 1.0.0+1',
            style: TextStyle(
              color: AppColor.toneThree,
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  Future<void> launchPrivacyPolicy() async {
    final Uri url = Uri.parse(
        'https://www.termsfeed.com/live/8a6630b6-fbd7-4bd9-8c63-bd8fa04778f9');

    try {
      await launchUrl(url);
    } catch (e) {
      print('Error launching URL: $e');
      // Handle the error as needed
    }
  }
}

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onTap;

  const DrawerItem({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppColor.background,
      ),
      title: Text(
        text,
        style: const TextStyle(
          color: AppColor.background,
        ),
      ),
      onTap: onTap,
    );
  }
}
