import 'dart:io';
import 'package:door_care/core/widget/padding_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toastification/toastification.dart';
import '../../../../core/theme/color/app_color.dart';
import '../../../../core/util/png_asset.dart';
import '../../../../core/widget/opacity_container.dart';
import '../../../../core/widget/toastifiaction_widget.dart';
import '../../../auth/bloc/auth_bloc/auth_bloc.dart';
import '../../../auth/view/widget/auth_text_formfield.dart';
import '../../bloc/bloc/update_profile_bloc.dart';
import '../widget/appbar_widget.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({super.key});

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  File? profileImage;
  String? imageUrl;

  // Method to pick image from camera or gallery
  Future<void> pickImage(ImageSource source) async {
    try {
      XFile? res = await _imagePicker.pickImage(source: source);
      if (res != null) {
        profileImage = File(res.path);
        await uploadImageToFirebase(profileImage!);
      }
    } catch (e) {
      ToastificationWidget.show(
        context: context,
        type: ToastificationType.error,
        title: 'Error',
        description: 'Failed to pick Image!',
      );
    }
  }

  // Method to upload image to Firebase
  Future<void> uploadImageToFirebase(File image) async {
    try {
      Reference reference = FirebaseStorage.instance.ref().child(
            "images/${DateTime.now().millisecondsSinceEpoch}.png",
          );
      await reference.putFile(image);

      imageUrl = await reference.getDownloadURL();

      // Dispatch BLoC event to update the profile image
      if (imageUrl != null) {
        BlocProvider.of<UpdateProfileBloc>(context).add(
          UpdateUserProfileImageEvent(profileImg: imageUrl!),
        );
      }

      ToastificationWidget.show(
        context: context,
        type: ToastificationType.success,
        title: 'Success',
        description: 'Image uploaded successfully!',
      );
    } catch (e) {
      ToastificationWidget.show(
        context: context,
        type: ToastificationType.error,
        title: 'Error',
        description: 'Failed to upload Image: $e',
      );
    }
  }

  // Show modal for image source selection
  void showImageSourceSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColor.background,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const FaIcon(FontAwesomeIcons.images),
                title: const Text('Photo Library'),
                onTap: () {
                  Navigator.of(context).pop(); // Close modal
                  pickImage(ImageSource.gallery); // Pick from gallery
                },
              ),
              ListTile(
                leading: const FaIcon(FontAwesomeIcons.cameraRetro),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.of(context).pop(); // Close modal
                  pickImage(ImageSource.camera); // Pick from camera
                },
              ),
            ],
          ),
        );
      },
    );
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
                  const Spacer(flex: 1),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     // Handle update logic
                  //   },
                  //   child: const Text('Update'),
                  // ),
                  const Spacer(flex: 3),
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
