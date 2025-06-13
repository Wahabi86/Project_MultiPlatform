import "package:flutter/material.dart";
import "package:project_uts/login_page/login.dart";
import "package:project_uts/login_page/register.dart";
import "package:project_uts/widgets/bottom_nav.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "The Movie Apps",
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),

      // Login
      initialRoute: LoginPage.id,
      // Route
      routes: {
        LoginPage.id: (context) => const LoginPage(),
        Register.id: (context) => const Register(),
        "/home": (context) => const BottomNav()
      },
    );
  }
}
