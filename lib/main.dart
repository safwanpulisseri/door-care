import 'package:door_care/app.dart';
import 'package:door_care/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: ".env");

  // Initialize Stripe
  final stripeKey = dotenv.env['STRIPE_PUBLISHABLE_API_KEY']!;
  Stripe.publishableKey = stripeKey;
  await Stripe.instance.applySettings();

  // // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}
