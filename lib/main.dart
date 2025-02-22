import 'package:courseapp/auth/login.dart';
import 'package:courseapp/auth/signup.dart';
import 'package:courseapp/categories/add.dart';
import 'package:courseapp/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme:AppBarTheme(
          backgroundColor: Colors.grey[50],
          titleTextStyle: TextStyle(color: Colors.orange, fontSize: 17, fontWeight: FontWeight.bold),
          iconTheme: IconThemeData(color: Colors.orange),
        )
      ),
      home:(FirebaseAuth.instance.currentUser != null && FirebaseAuth.instance.currentUser!.emailVerified ) ? HomePage() : Login(),
      routes: {
        "signup": (context) => SignUp(),
        "login": (context) => Login(),
        "homepage": (context) => HomePage(),
        "addategory": (context) => AddCategory(),
      },
    );
  }
}
