import 'package:door_care/feature/manageService/inc/data/services/remote/pay_service_remote.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '../../../view/pages/payment_fail_page.dart';
import '../../../view/pages/payment_success.dart';

class StripeService {
  StripeService._();

  static final StripeService instance = StripeService._();

  Future<void> handlePayment({
    required num amount,
    required String bookingId,
    required String workerId,
    required BuildContext context, // Pass context to navigate
  }) async {
    try {
      // Create a payment session
      String? sessionId = await PayServiceRemote().createPaymentSession(
        amount: amount,
        bookingId: bookingId,
        workerId: workerId,
      );
      print('Session ID: $sessionId');

      if (sessionId != null) {
        // Initialize Stripe
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: sessionId,
            merchantDisplayName: 'Door care',
          ),
        );

        // Present the payment sheet
        await Stripe.instance.presentPaymentSheet();

        // Payment successful
        print('Payment successful');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (ctx) =>
                const PaymentSuccess(), // Navigate to PaymentSuccess on success
          ),
        );
      } else {
        print('Failed to create payment session');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (ctx) =>
                const PaymentFailure(), // Navigate to PaymentFailure on failure
          ),
        );
      }
    } catch (e) {
      if (e is StripeException) {
        print('Error from Stripe: ${e.error.localizedMessage}');
      } else {
        print('Error during payment: $e');
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (ctx) =>
              const PaymentFailure(), // Navigate to PaymentFailure on error
        ),
      );
    }
  }
}
