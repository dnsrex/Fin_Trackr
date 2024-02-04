import 'package:fin_trackr/screens/authentication/MultiFactorAuth/EnroleOtpPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EnroleMFAPage extends StatefulWidget {
  @override
  _EnroleMFAPageState createState() => _EnroleMFAPageState();
}

class _EnroleMFAPageState extends State<EnroleMFAPage> {
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Phone Number'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Enter Phone Number',
                hintText: '+123456789', // Include the country code
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Call the function to initiate phone number verification
                initiatePhoneNumberVerification();
              },
              child: Text('Verify Phone Number'),
            ),
          ],
        ),
      ),
    );
  }

  void initiatePhoneNumberVerification() async {
    String phoneNumber = phoneController.text;

    User user = FirebaseAuth.instance.currentUser!;
    final multiFactorSession = await user.multiFactor.getSession();
    await FirebaseAuth.instance.verifyPhoneNumber(
      multiFactorSession: multiFactorSession,
      phoneNumber: phoneNumber,
      verificationCompleted: (_) {},
      verificationFailed: (_) {},
      codeSent: (String verificationId, int? resendToken) async {
        await FirebaseAuth.instance.verifyPhoneNumber(
          multiFactorSession: multiFactorSession,
          phoneNumber: phoneNumber,
          verificationCompleted: (_) {},
          verificationFailed: (_) {},
          codeSent: (String verificationId, int? resendToken) async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EnroleOTPPage(
                    phoneNumber: phoneNumber, verificationId: verificationId),
              ),
            );
          },
          codeAutoRetrievalTimeout: (_) {},
        );
      },
      codeAutoRetrievalTimeout: (_) {},
    );
  }
}