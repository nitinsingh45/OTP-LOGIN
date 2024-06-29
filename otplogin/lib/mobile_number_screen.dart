import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MobileNumberScreen extends StatefulWidget {
  @override
  _MobileNumberScreenState createState() => _MobileNumberScreenState();
}

class _MobileNumberScreenState extends State<MobileNumberScreen> {
  TextEditingController _controller = TextEditingController();
  FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _verifyPhoneNumber(String phoneNumber) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {
          print('Auto verification completed: $credential');
          // Handle automatic verification if the SMS code is received
        },
        verificationFailed: (FirebaseAuthException e) {
          print('Verification Failed: ${e.message}');
          // Handle verification failure
        },
        codeSent: (String verificationId, int? resendToken) {
          print('Code sent to $phoneNumber');
          Navigator.pushNamed(context, '/verify-phone',
              arguments: verificationId);
          // Navigate to OTP verification screen with verificationId
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print('Auto retrieval timeout: $verificationId');
          // Handle timeout if code auto-retrieval timed out
        },
      );
    } catch (e) {
      print('Error during phone number verification: $e');
      // Handle other errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mobile Number'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Please enter your mobile number',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'You\'ll receive a 6 digit code to verify next.',
                style: TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Row(
                children: <Widget>[
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Mobile Number',
                      ),
                      keyboardType: TextInputType.phone,
                      focusNode: _focusNode,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  String phoneNumber = _controller.text.trim();
                  if (phoneNumber.isNotEmpty) {
                    print('Starting verification for $phoneNumber');
                    FocusScope.of(context).requestFocus(_focusNode);
                    _verifyPhoneNumber(phoneNumber);
                  } else {
                    print('Please enter a valid phone number');
                  }
                },
                child: Text('CONTINUE'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
