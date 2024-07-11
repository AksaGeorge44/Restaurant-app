import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskproject/controller/auth_provider.dart';
import 'package:taskproject/controller/cart_provider.dart';
import 'package:taskproject/firebase_options.dart';
import 'package:taskproject/view/auth_screen.dart';
import 'controller/category_provider.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => AuthService()),
        ChangeNotifierProvider(
            create: (context) => CartProvider()),
        ChangeNotifierProvider(
        create: (context) => CategoryProvider()),

      ],
        child: SafeArea(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: AuthScreen(),
          ),
        ),
    );
  }
}
