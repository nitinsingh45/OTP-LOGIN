import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'language_selection_screen.dart';
import 'mobile_number_screen.dart';
import 'verify_phone_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print('Error initializing Firebase: $e');
  }
  runApp(OTPLoginApp());
}

class OTPLoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OTP Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LanguageSelectionScreen(),
        '/mobile-number': (context) => MobileNumberScreen(),
        '/verify-phone': (context) => VerifyPhoneScreen(),
      },
    );
  }
}
