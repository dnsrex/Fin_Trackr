import 'package:fin_trackr/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OtpPage extends StatefulWidget {
  String verificationId;
  MultiFactorResolver resolver;

  OtpPage({super.key, required this.verificationId, required this.resolver});

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
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
                handleOTPSubmission(
                    resolver: widget.resolver,
                    verificationId: widget.verificationId);
              },
              child: Text('Submit OTP'),
            ),
          ],
        ),
      ),
    );
  }

  void handleOTPSubmission(
      {required String verificationId,
        required MultiFactorResolver resolver}) async {
    // Get the entered OTP
    String enteredOTP = otpController.text;

    // Validate the OTP (you may want to add more validation logic)
    if (enteredOTP.length == 6) {
      // Create a PhoneAuthCredential with the code
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: enteredOTP,
      );

      try {
        await resolver.resolveSignIn(
          PhoneMultiFactorGenerator.getAssertion(
            credential,
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HoemeScreen()),
        );
      } on FirebaseAuthException catch (e) {
        print(e.message);
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