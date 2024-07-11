import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/auth_provider.dart';
import 'home_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton.icon(
              onPressed: () {
                authService.signInWithGoogle(context);
              },
              icon: Image.asset('assets/google.jpg', height: 24),
              label: Text('Sign in with Google'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                _showPhoneNumberInputDialog(context, authService);
              },
              icon: Image.asset('assets/phone.jpg', height: 24),
              label: Text('Sign in with Phone Number'),
            ),
          ],
        ),
      ),
    );
  }

  void _showPhoneNumberInputDialog(BuildContext context, AuthService authService) {
    final phoneController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Phone Number Sign In'),
        content: TextField(
          controller: phoneController,
          decoration: const InputDecoration(labelText: 'Phone Number'),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              authService.signInWithPhoneNumber(phoneController.text, (verificationId) {
                Navigator.of(context).pop();
                _showOtpInputDialog(context, authService, verificationId);
              }, context);
            },
            child: const Text('Send Code'),
          ),
        ],
      ),
    );
  }

  void _showOtpInputDialog(BuildContext context, AuthService authService, String verificationId) {
    final codeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter Verification Code'),
        content: TextField(
          controller: codeController,
          decoration: const InputDecoration(labelText: 'Verification Code'),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              PhoneAuthCredential credential = PhoneAuthProvider.credential(
                verificationId: verificationId,
                smsCode: codeController.text,
              );
              authService.signInWithCredential(credential).then((_) {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              });
            },
            child: const Text('Sign In'),
          ),
        ],
      ),
    );
  }
}
