import 'package:flutter/material.dart';
import 'package:project/pages/api_test.dart';
import 'package:project/pages/login.dart';
import 'package:project/pages/register.dart';
import 'package:project/services/auth_provider.dart';
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

        // Add more providers here
      ],
      child: MyApp(),
    ),
  );
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ApiCallPage(),
    );
  }
}
