import 'dart:async';

import 'package:fin_trackr/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  String textStatusEmail = "cek apakah email sudah diverifikasi";
  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    print("cek apakah email sudah diverifikasi");
    textStatusEmail = "verifirkasi email = $isEmailVerified ";
    if (isEmailVerified) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HoemeScreen(),
      ));
    } else {
      sendEmailVerificationEmail();
      timer = Timer.periodic(Duration(seconds: 3), (timer) {
        checkEmailVerivied();
      });
    }
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  sendEmailVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user
          .sendEmailVerification()
          .onError((error, stackTrace) => print("error : $error"))
          .then((value) => {print('berhasil mengirim email')});

      setState(() {
        textStatusEmail = "Email verifikasi telah dikirim";
      });
    } catch (e) {
      print('Gagal mengirim email');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal mengirim email')),
      );
    }
  }

  checkEmailVerivied() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    print("verif stat : $isEmailVerified");
    if (isEmailVerified) {
      timer?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (this.isEmailVerified) {
      return HoemeScreen();
    } else {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                textStatusEmail,
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
        ),
      );
    }
  }
}