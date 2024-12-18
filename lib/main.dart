import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:project/pages/index.dart';
import 'package:project/pages/login.dart';
import 'package:project/services/auth_provider.dart';
import 'package:project/services/cart_provider.dart';
import 'package:project/services/location_provider.dart';
import 'package:project/services/order_provider.dart';
import 'package:project/services/shared_preference_service.dart';
import 'package:project/services/vehicle_provider.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51QRpopAuTZ1Aldd1TX11gUvIZetpikDCCR5qlDdc6YoaVkVHYcwNFVdEwfGYAS3czbCruQbOm79Ta7TlXofi6wyJ00Fvxj6q0y"; // Replace with your Stripe publishable key
  Stripe.merchantIdentifier = 'HeavyHub';
  await Stripe.instance.applySettings();
  await Supabase.initialize(
    url: 'https://lxoikupearehebbuyday.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imx4b2lrdXBlYXJlaGViYnV5ZGF5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzAzNjAxNjIsImV4cCI6MjA0NTkzNjE2Mn0.5WnBjYWXjhz27xS6RVtfC9FlbiaWhSehMQpORabxkwA',
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => VehicleProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
        ChangeNotifierProvider(create: (context) => LocationProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),

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
    Provider.of<VehicleProvider>(context, listen: false).fetchData();
    if (supabase.auth.currentUser != null) {
      Provider.of<OrderProvider>(context, listen: false).fetchTrans();
      Provider.of<LocationProvider>(context, listen: false).fetchData();
    }
    if (_isCheckingSession) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _isLoggedIn ? const Index() : const LoginPage(),
    );
  }
}
