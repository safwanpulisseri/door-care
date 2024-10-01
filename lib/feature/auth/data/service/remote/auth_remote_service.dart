import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRemoteService {
  final String _link = dotenv.env['MAIN_API_LINK']!;
  final dio = Dio();

  //User sign in
  Future<Response<dynamic>> signIn({
    required String email,
    required String password,
  }) async {
    log("on dio");
    try {
      var response = await dio.post("${_link}login", data: {
        'email': email,
        'password': password,
      });
      log("success");
      return response;
    } catch (e) {
      log('Error during login $e');
      throw Exception();
    }
  }

  //User sign up
  Future<Response<dynamic>> signUp({
    required String name,
    required String mobile,
    required String email,
    required String password,
  }) async {
    log("signup in dio");
    try {
      var response = await dio.post("${_link}signup", data: {
        'name': name,
        'mobile': mobile,
        'email': email,
        'password': password,
      });
      return response;
    } catch (e) {
      log('Error during sign up$e');
      throw Exception();
    }
  }

  // Google sign in
  Future<Response?> googleAuth() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        log("googleAuth accessToken=>${googleAuth.accessToken}");
        log("googleAuth idToken=>${googleAuth.idToken}");

        UserCredential userCredential =
            await firebaseAuth.signInWithCredential(credential);
        User? user = userCredential.user;

        if (user != null) {
          String? idToken = await user.getIdToken();
          log("Firebase ID Token: $idToken");

          // Log the user data from Google
          log("Google User Data:");
          log("Name: ${user.displayName}");
          log("Email: ${user.email}");
          log("Photo URL: ${user.photoURL}");
          log("UID: ${user.uid}");
          log("Creation Time: ${user.metadata.creationTime}");
          log("Last Sign-in Time: ${user.metadata.lastSignInTime}");

          // Call your backend API with the ID Token and other required fields
          var response = await dio.post("${_link}googleAuth", data: {
            'name': user.displayName,
            'email': user.email,
            'password': user.uid, // You can use a default or generated password
            'profile_img': user.photoURL,
            // 'idToken': idToken,
          });

          // Convert the response data to a JSON string for logging
          log("Backend response: ${jsonEncode(response.data)}");

          // Print the entire response data
          log("Backend response data:");
          log(jsonEncode(response.data));
          return response;
        }
      }
    } catch (e) {
      log('Error during Google sign in $e');
      throw Exception();
    }
    return null;
  }
}
