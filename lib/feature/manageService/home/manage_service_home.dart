import 'package:flutter/material.dart';

class ManageServiceHome extends StatelessWidget {
  final num latitude;
  final num longitude;
  const ManageServiceHome({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => GoogleMapPage(
                //       latitude: latitude,
                //       longitude: longitude,
                //     ),
                //   ),
                // );
              },
              child: const Text('Google Map'),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => GoogleMapPageTwo(
                //       latitude: latitude,
                //       longitude: longitude,
                //     ),
                //   ),
                // );
              },
              child:const Text('Google Map'),
            ),
          ),
        ],
      ),
    );
  }
}
