// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';

// class GoogleMapPage extends StatefulWidget {
//   final num latitude;
//   final num longitude;
//   const GoogleMapPage({
//     super.key,
//     required this.latitude,
//     required this.longitude,
//   });

//   @override
//   State<GoogleMapPage> createState() => _GoogleMapPageState();
// }

// class _GoogleMapPageState extends State<GoogleMapPage> {
//   final locationController = Location();

//   LatLng? currentPosition;
//   Map<PolylineId, Polyline> polylines = {};

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance
//         .addPostFrameCallback((_) async => await initializeMap());
//   }

//   Future<void> initializeMap() async {
//     await fetchLocationUpdates();
//     final coordinates = await fetchPolylinePoints();
//     generatePolyLineFromPoints(coordinates);
//   }

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         body: currentPosition == null
//             ? const Center(child: CircularProgressIndicator())
//             : GoogleMap(
//                 initialCameraPosition: CameraPosition(
//                   target: currentPosition!,
//                   zoom: 13,
//                 ),
//                 markers: {
//                   Marker(
//                     markerId: const MarkerId('currentLocation'),
//                     icon: BitmapDescriptor.defaultMarker,
//                     position: currentPosition!,
//                   ),
//                   Marker(
//                     markerId: const MarkerId('destinationLocation'),
//                     icon: BitmapDescriptor.defaultMarker,
//                     position: LatLng(widget.latitude.toDouble(),
//                         widget.longitude.toDouble()),
//                   ),
//                 },
//                 polylines: Set<Polyline>.of(polylines.values),
//               ),
//       );

//   Future<void> fetchLocationUpdates() async {
//     bool serviceEnabled;
//     PermissionStatus permissionGranted;

//     serviceEnabled = await locationController.serviceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await locationController.requestService();
//     }

//     permissionGranted = await locationController.hasPermission();
//     if (permissionGranted == PermissionStatus.denied) {
//       permissionGranted = await locationController.requestPermission();
//       if (permissionGranted != PermissionStatus.granted) {
//         return;
//       }
//     }

//     locationController.onLocationChanged.listen((currentLocation) {
//       if (currentLocation.latitude != null &&
//           currentLocation.longitude != null) {
//         setState(() {
//           currentPosition = LatLng(
//             currentLocation.latitude!,
//             currentLocation.longitude!,
//           );
//         });
//       }
//     });
//   }

//   Future<List<LatLng>> fetchPolylinePoints() async {
//     final polylinePoints = PolylinePoints();

//     final result = await polylinePoints.getRouteBetweenCoordinates(
//       googleApiKey: dotenv.env['GOOGLE_MAP_API_KEY'] ?? '',
//       request: PolylineRequest(
//         origin:
//             PointLatLng(currentPosition!.latitude, currentPosition!.longitude),
//         destination: PointLatLng(
//             widget.latitude.toDouble(), widget.longitude.toDouble()),
//         mode: TravelMode.driving,
//       ),
//     );

//     if (result.points.isNotEmpty) {
//       return result.points
//           .map((point) => LatLng(point.latitude, point.longitude))
//           .toList();
//     } else {
//       debugPrint(result.errorMessage);
//       return [];
//     }
//   }

//   Future<void> generatePolyLineFromPoints(
//       List<LatLng> polylineCoordinates) async {
//     const id = PolylineId('polyline');

//     final polyline = Polyline(
//       polylineId: id,
//       color: Colors.blueAccent,
//       points: polylineCoordinates,
//       width: 5,
//     );

//     setState(() => polylines[id] = polyline);
//   }
// }
