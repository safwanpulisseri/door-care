import 'package:door_care/core/theme/color/app_color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:toastification/toastification.dart';
import '../../../../core/widget/toastifiaction_widget.dart';
import '../../../home/data/model/fetch_all_service_model.dart';
import '../widget/circle_avathar_widget.dart';
import 'enter_details_book_service.dart';

class FindLocationBookService extends StatefulWidget {
  final FetchAllServiceModel service;
  const FindLocationBookService({super.key, required this.service});

  @override
  createState() => _FindLocationBookServiceState();
}

class _FindLocationBookServiceState extends State<FindLocationBookService> {
  bool _isFetchingLocation = false;
  // Position? _currentPosition;
  String? _errorMessage;
  Map<String, double>? _selectedLocation; // Store selected location

  @override
  void initState() {
    super.initState();
    _checkLocationPermission(); // Check permission when page loads
  }

  Future<void> _checkLocationPermission() async {
    PermissionStatus locationStatus = await Permission.location.request();

    if (locationStatus.isGranted) {
      _fetchCurrentLocation();
    } else if (locationStatus.isDenied) {
      _showError('Location permission is denied!');
    } else if (locationStatus.isPermanentlyDenied) {
      openAppSettings(); // Open settings if permission is permanently denied
    }
  }

  Future<void> _fetchCurrentLocation() async {
    setState(() {
      _isFetchingLocation = true;
    });

    try {
      // Position position = await Geolocator.getCurrentPosition(
      //   desiredAccuracy: LocationAccuracy.high,
      // );

      setState(() {
        // _currentPosition = position;
        _isFetchingLocation = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to get current location: $e';
        _isFetchingLocation = false;
      });
    }
  }

  void _showError(String message) {
    ToastificationWidget.show(
      context: context,
      type: ToastificationType.error,
      title: 'Error',
      description: message,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const StepperWidget(
              titleOne: 'Location',
              titleTwo: 'Details',
              titleThree: 'Success',
              titleColorOne: AppColor.secondary,
              titleColorTwo: AppColor.toneThree,
              titleColorThree: AppColor.toneThree,
              circleColorOne: AppColor.primary,
              circleColorTwo: AppColor.toneFive,
              circleColorThree: AppColor.toneFive,
              iconOne: Icon(
                FontAwesomeIcons.check,
                color: AppColor.background,
              ),
              iconTwo: Icon(
                Icons.add,
                color: AppColor.background,
              ),
              iconThree: Icon(
                Icons.add,
                color: AppColor.background,
              ),
            ),
            // Implement Map in here
            Expanded(
              child: _isFetchingLocation
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColor.primary,
                      ),
                    )
                  : _errorMessage != null
                      ? Center(
                          child: Text(
                            _errorMessage!,
                            style: const TextStyle(
                              color: AppColor.secondary,
                            ),
                          ),
                        )
                      : OpenStreetMapSearchAndPick(
                          buttonWidth: 130,
                          zoomInIcon: Icons.zoom_in_sharp,
                          zoomOutIcon: Icons.zoom_out,
                          locationPinIconColor: AppColor.primary,
                          locationPinTextStyle: const TextStyle(
                            color: AppColor.secondary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          buttonColor: AppColor.primary,
                          buttonText: 'Pick Location',
                          buttonTextStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                          onPicked: (pickedData) {
                            final data = {
                              'lat': pickedData.latLong.latitude,
                              'long': pickedData.latLong.longitude,
                            };
                            setState(() {
                              _selectedLocation = data;
                            });
                            // Navigator.pop(
                            //     context, data); // Return the location data
                            if (_selectedLocation != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EnterDetailsBookService(
                                    service: widget.service,
                                    latitude: _selectedLocation!['lat']!,
                                    longitude: _selectedLocation!['long']!,
                                  ),
                                ),
                              );
                            } else {
                              _showError(
                                  'Please pick a location before proceeding.');
                            }
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
