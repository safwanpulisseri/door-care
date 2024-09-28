// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';

// class GoogleMapPageTwo extends StatefulWidget {
//   final num latitude;
//   final num longitude;

//   const GoogleMapPageTwo({
//     super.key,
//     required this.latitude,
//     required this.longitude,
//   });

//   @override
//   State<GoogleMapPageTwo> createState() => _GoogleMapPageState();
// }

// class _GoogleMapPageState extends State<GoogleMapPageTwo> {
//   final locationController = Location();
//   GoogleMapController? _mapController;

//   LatLng get destinationLocation =>
//       LatLng(widget.latitude.toDouble(), widget.longitude.toDouble());

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
//     if (currentPosition != null) {
//       final coordinates = await fetchPolylinePoints();
//       generatePolyLineFromPoints(coordinates);
//       _moveCameraToIncludeMarkers();
//     }
//   }

//   void _moveCameraToIncludeMarkers() {
//     final bounds = LatLngBounds(
//       southwest: LatLng(
//         currentPosition!.latitude < destinationLocation.latitude
//             ? currentPosition!.latitude
//             : destinationLocation.latitude,
//         currentPosition!.longitude < destinationLocation.longitude
//             ? currentPosition!.longitude
//             : destinationLocation.longitude,
//       ),
//       northeast: LatLng(
//         currentPosition!.latitude > destinationLocation.latitude
//             ? currentPosition!.latitude
//             : destinationLocation.latitude,
//         currentPosition!.longitude > destinationLocation.longitude
//             ? currentPosition!.longitude
//             : destinationLocation.longitude,
//       ),
//     );

//     _mapController?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
//   }

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         appBar: AppBar(
//           title: const Text("Manage Work"),
//           centerTitle: true,
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back),
//             onPressed: () {},
//           ),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     "Booking ID : 1A3AD399",
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.close),
//                     onPressed: () {},
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 8),
//               Container(
//                 width: double.infinity,
//                 height: 600,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   color: Colors.grey[200],
//                 ),
//                 child: currentPosition == null
//                     ? const Center(child: CircularProgressIndicator())
//                     : ClipRRect(
//                         borderRadius: BorderRadius.circular(12),
//                         child: GoogleMap(
//                           onMapCreated: (GoogleMapController controller) {
//                             _mapController = controller;
//                             _moveCameraToIncludeMarkers();
//                           },
//                           initialCameraPosition: CameraPosition(
//                             target: currentPosition!,
//                             zoom: 13,
//                           ),
//                           markers: {
//                             Marker(
//                               markerId: const MarkerId('currentLocation'),
//                               icon: BitmapDescriptor.defaultMarker,
//                               position: currentPosition!,
//                             ),
//                             Marker(
//                               markerId: const MarkerId('destinationLocation'),
//                               icon: BitmapDescriptor.defaultMarker,
//                               position: destinationLocation,
//                             ),
//                           },
//                           polylines: Set<Polyline>.of(polylines.values),
//                         ),
//                       ),
//               ),
//               const SizedBox(height: 8),
//               const Text(
//                 "Estimated Time : 0 hr 2 min (0.70 km)",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 16),
//               const Text(
//                 "04 : 17 : 33 : 31",
//                 style: TextStyle(
//                   fontSize: 32,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               const Text("Days : Hours : Minutes : Seconds"),
//               const Spacer(),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blueAccent,
//                     ),
//                     child: const Text("Chat"),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blueAccent,
//                     ),
//                     child: const Text("Start Your Work"),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       );

//   Future<void> fetchLocationUpdates() async {
//     bool serviceEnabled;
//     PermissionStatus permissionGranted;

//     serviceEnabled = await locationController.serviceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await locationController.requestService();
//       if (!serviceEnabled) {
//         return; // Service is still not enabled, so exit early
//       }
//     }

//     permissionGranted = await locationController.hasPermission();
//     if (permissionGranted == PermissionStatus.denied) {
//       permissionGranted = await locationController.requestPermission();
//       if (permissionGranted != PermissionStatus.granted) {
//         return; // Permission is still not granted, so exit early
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

//         // Move camera to the current location
//         if (_mapController != null) {
//           _mapController!.animateCamera(
//             CameraUpdate.newLatLng(currentPosition!),
//           );
//         }
//       }
//     });
//   }

//   Future<List<LatLng>> fetchPolylinePoints() async {
//     final polylinePoints = PolylinePoints();

//     final result = await polylinePoints.getRouteBetweenCoordinates(
//       googleApiKey: dotenv.env['GOOGLE_MAP_API_KEY'] ?? '',
//       request: PolylineRequest(
//         origin: PointLatLng(
//           currentPosition!.latitude,
//           currentPosition!.longitude,
//         ),
//         destination: PointLatLng(
//           destinationLocation.latitude,
//           destinationLocation.longitude,
//         ),
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
