import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskproject/view/home_screen.dart';
import '../controller/auth_provider.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Auth'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                authService.signInWithGoogle();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
              },
              child: Text('Sign in with Google'),
            ),
            ElevatedButton(
              onPressed: () {

                _showPhoneNumberInputDialog(context, authService);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));

              },
              child: Text('Sign in with Phone Number'),
            ),
          ],
        ),
      ),
    );
  }

  void _showPhoneNumberInputDialog(BuildContext context, AuthService authService) {
    final phoneController = TextEditingController();
    final codeController = TextEditingController();
    String? verificationId;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Phone Number Sign In'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            TextField(
              controller: codeController,
              decoration: InputDecoration(labelText: 'Verification Code'),
              enabled: verificationId != null,
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (verificationId == null) {
                authService.signInWithPhoneNumber(phoneController.text, (id) {
                  verificationId = id;
                  Navigator.of(context).pop();
                  _showPhoneNumberInputDialog(context, authService);
                });
              } else {
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                  verificationId: verificationId!,
                  smsCode: codeController.text,
                );
                authService.signInWithPhoneNumber(phoneController.text, (id) {});
                Navigator.of(context).pop();
              }
            },
            child: Text(verificationId == null ? 'Send Code' : 'Sign In'),
          ),
        ],
      ),
    );
  }
}
