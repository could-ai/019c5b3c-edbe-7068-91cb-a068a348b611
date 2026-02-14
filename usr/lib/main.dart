import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Resume Builder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const RedirectScreen(),
        '/rb/01-problem': (context) => const RBProblemScreen(),
        '/rb/02-market': (context) => const RBMarketScreen(),
        '/rb/03-architecture': (context) => const RBArchitectureScreen(),
        '/rb/04-hld': (context) => const RBHLDScreen(),
        '/rb/05-lld': (context) => const RBLLDScreen(),
        '/rb/06-build': (context) => const RBBuildScreen(),
        '/rb/07-test': (context) => const RBTestScreen(),
        '/rb/08-ship': (context) => const RBShipScreen(),
        '/rb/proof': (context) => const RBProofScreen(),
      },
    );
  }
}

class RedirectScreen extends StatelessWidget {
  const RedirectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacementNamed(context, '/rb/01-problem');
    });
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}