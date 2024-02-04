import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EnroleOTPPage extends StatefulWidget {
  String verificationId;
  String phoneNumber;

  EnroleOTPPage({required this.verificationId, required this.phoneNumber});

  @override
  _EnroleOTPPageState createState() => _EnroleOTPPageState();
}

class _EnroleOTPPageState extends State<EnroleOTPPage> {
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter OTP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Verification code sent to ${widget.phoneNumber}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: InputDecoration(
                labelText: 'Enter OTP',
                hintText: '123456',
                counterText: '',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Call the function to handle OTP submission
                handleOTPSubmission(verificationId: widget.verificationId);
              },
              child: Text('Submit OTP'),
            ),
          ],
        ),
      ),
    );
  }

  void handleOTPSubmission({required String verificationId}) async {
    // Get the entered OTP
    String enteredOTP = otpController.text;

    // Validate the OTP (you may want to add more validation logic)
    if (enteredOTP.length == 6) {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: enteredOTP,
      );

      try {
        User user = FirebaseAuth.instance.currentUser!;
        await user.multiFactor.enroll(
          PhoneMultiFactorGenerator.getAssertion(
            credential,
          ),
        );
      } catch (e) {
        print(e.toString());
      }
    } else {
      // Display an error message if the OTP length is not 6
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please enter a 6-digit OTP.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}