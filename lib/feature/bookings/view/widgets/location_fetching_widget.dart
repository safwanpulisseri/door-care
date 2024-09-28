import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import '../../../../core/theme/color/app_color.dart';

class LocationFetchingWidget extends StatelessWidget {
  final num latitude;
  final num longitude;
  const LocationFetchingWidget({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  Future<String> _getLocationName(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude,
        longitude,
      );
      if (placemarks.isNotEmpty) {
        final Placemark placemark = placemarks.first;
        return '${placemark.locality}, ${placemark.administrativeArea}';
      } else {
        return 'Location not found';
      }
    } catch (e) {
      return 'Failed to get location name: $e';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getLocationName(
        latitude.toDouble(),
        longitude.toDouble(),
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Row(
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
                    child: SvgPicture.asset("assets/svg/booking_two.svg"),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Fetching location...',
                style: TextStyle(
                  color: AppColor.secondary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Row(
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
                    child: SvgPicture.asset("assets/svg/booking_two.svg"),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Error fetching location',
                style: TextStyle(
                  color: AppColor.secondary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        } else {
          return Row(
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
                    child: SvgPicture.asset("assets/svg/booking_two.svg"),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  snapshot.data ?? 'Unknown location',
                  style: const TextStyle(
                    color: AppColor.secondary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
