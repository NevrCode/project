import 'package:flutter/material.dart';
import 'package:project/pages/index.dart';
import 'package:project/pages/login.dart';
import 'package:project/services/auth_provider.dart';
import 'package:project/services/shared_preference_service.dart';
import 'package:project/services/vehicle_provider.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://lxoikupearehebbuyday.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imx4b2lrdXBlYXJlaGViYnV5ZGF5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzAzNjAxNjIsImV4cCI6MjA0NTkzNjE2Mn0.5WnBjYWXjhz27xS6RVtfC9FlbiaWhSehMQpORabxkwA',
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => VehicleProvider())
        // Add more providers here
      ],
      child: const MyApp(),
    ),
  );
}

final supabase = Supabase.instance.client;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;
  bool _isCheckingSession = true;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    bool isLoggedIn = await SharedPreferenceService().isLoggedIn();
    setState(() {
      _isLoggedIn = isLoggedIn;
      _isCheckingSession = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isCheckingSession) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }
    return MaterialApp(
      home: _isLoggedIn ? Index() : LoginPage(),
    );
  }
}
