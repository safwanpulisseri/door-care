import 'package:door_care/core/widget/padding_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import '../../../../core/theme/color/app_color.dart';
import '../../../../core/util/png_asset.dart';
import '../../../../core/widget/opacity_container.dart';
import '../../../auth/auth_bloc/auth_bloc.dart';
import '../../../auth/view/widget/auth_text_formfield.dart';
import '../widget/appbar_widget.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({super.key});

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
    @override
  void dispose() {
    _nameController.dispose();
    _mobileNumberController.dispose();
    super.dispose();
  }
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarSingle(),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccessState) {
            final user = state.userModel;
            // Initialize controllers with user data
            _nameController.text = user.name;
            _mobileNumberController.text = user.mobile;
            return PaddingWidget(
              child: Column(
                children: [
                  Row(
                    children: [
                      const OpacityContainer(),
                      const SizedBox(width: 10),
                      Text(
                        'Profile',
                        style:
                            Theme.of(context).textTheme.headlineLarge?.copyWith(
                                  color: AppColor.secondary,
                                  fontSize: 30,
                                ),
                      ),
                    ],
                  ),
                  const Spacer(flex: 1),
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: AppColor.toneThree.withOpacity(0.5),
                    backgroundImage: user.profileImg.isNotEmpty
                        ? NetworkImage(user.profileImg)
                        : const AssetImage(AppPngPath.personImage)
                            as ImageProvider,
                  ),
                  const SizedBox(height: 10),
                  // ElevatedButton.icon(
                  //   onPressed: () {
                  //     showImageSourceSelection(context);
                  //   },
                  //   label: const Text('Select Image'),
                  //   icon: const Icon(Icons.add_a_photo_outlined,
                  //       color: AppColor.primary),
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: AppColor.background,
                  //     foregroundColor: AppColor.primary,
                  //     padding: const EdgeInsets.symmetric(
                  //         horizontal: 16, vertical: 8),
                  //   ),
                  // ),
                  const Spacer(flex: 1),
                  AuthTextFormField(
                    controller: _nameController,
                    labelText: 'Name',
                    hintText: 'Update your name',
                    prefixIcon: IconlyLight.profile,
                  ),
                  const SizedBox(height: 20),
                  AuthTextFormField(
                    controller: _mobileNumberController,
                    labelText: 'Mobile Number',
                    hintText: 'Update your number',
                    prefixIcon: IconlyLight.call,
                    textInputType: TextInputType.phone,
                  ),
                 
                ],
              ),
            );
          } else {
            return Text(
              'Failed Fetch User\'s Details',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: AppColor.background,
                    fontSize: 17,
                  ),
            );
          }
        },
      ),
    );
  }
}
