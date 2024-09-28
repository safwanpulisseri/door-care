// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:image_picker/image_picker.dart';
// import '../../../../core/theme/color/app_color.dart';

// class ImageContainerWidget extends StatefulWidget {
//   final void Function(File) onProfileImageSelected;

//   const ImageContainerWidget({
//     super.key,
//     required this.onProfileImageSelected,
//   });

//   @override
//   createState() => _ImageContainerWidgetState();
// }

// class _ImageContainerWidgetState extends State<ImageContainerWidget> {
//   File? _profileImage;

//   Future<void> _pickImage(BuildContext context) async {
//     final ImagePicker imagePicker = ImagePicker();
//     showModalBottomSheet(
//       backgroundColor: AppColor.background,
//       context: context,
//       builder: (context) => SafeArea(
//         child: Wrap(
//           children: <Widget>[
//             ListTile(
//               leading: const FaIcon(FontAwesomeIcons.images),
//               title: const Text('Photo Library'),
//               onTap: () async {
//                 final pickedFile =
//                     await imagePicker.pickImage(source: ImageSource.gallery);
//                 if (pickedFile != null) {
//                   setState(() {
//                     _profileImage = File(pickedFile.path);
//                   });
//                   widget.onProfileImageSelected(File(pickedFile.path));
//                 }
//                 Navigator.of(context).pop();
//               },
//             ),
//             ListTile(
//               leading: const FaIcon(FontAwesomeIcons.cameraRetro),
//               title: const Text('Camera'),
//               onTap: () async {
//                 final pickedFile =
//                     await imagePicker.pickImage(source: ImageSource.camera);
//                 if (pickedFile != null) {
//                   setState(() {
//                     _profileImage = File(pickedFile.path);
//                   });
//                   widget.onProfileImageSelected(File(pickedFile.path));
//                 }
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         _pickImage(context);
//       },
//       child: Container(
//         height: 120,
//         width: 120,
//         decoration: BoxDecoration(
//           color: AppColor.secondary.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: _profileImage == null
//             ? const Center(
//                 child: Icon(
//                   Icons.add_a_photo_outlined,
//                   color: AppColor.primary,
//                   size: 40,
//                 ),
//               )
//             : ClipRRect(
//                 borderRadius: BorderRadius.circular(10),
//                 child: Image.file(
//                   _profileImage!,
//                   fit: BoxFit.cover,
//                   width: double.infinity,
//                   height: double.infinity,
//                 ),
//               ),
//       ),
//     );
//   }
// }
