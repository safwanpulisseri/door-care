// import 'package:flutter/material.dart';
// import '../../data/services/remote/stripe_service.dart';

// class PaymentPage extends StatefulWidget {
//   final num amount;
//   final String bookingId;
//   final String workerId;

//   const PaymentPage({
//     Key? key,
//     required this.amount,
//     required this.bookingId,
//     required this.workerId,
//   }) : super(key: key);

//   @override
//   createState() => _PaymentPageState();
// }

// class _PaymentPageState extends State<PaymentPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text("Stripe Payment"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Service amount: ${widget.amount}'),
//             Text('Worker ID: ${widget.workerId}'),
//             Text('Booking ID: ${widget.bookingId}'),
//             ElevatedButton(
//               onPressed: () async {
//                 // Call StripeService to handle the payment
//                 await StripeService.instance.handlePayment(
//                     amount: widget.amount,
//                     bookingId: widget.bookingId,
//                     workerId: widget.workerId,
//                     context: context);
//               },
//               child: const Text('Pay with Stripe'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
