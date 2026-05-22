import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'providers/shoe_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/favorites_provider.dart';
import 'providers/order_provider.dart';
import 'providers/auth_provider.dart';
import 'providers/navigation_provider.dart';
import 'routes/app_routes.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase with Web options
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBvWAobAMLf8TCw92Pk0tl23gTwB44_7A8",
      appId: "1:918221994940:web:7e4aed3bbe4446eba7c9b9",
      messagingSenderId: "918221994940",
      projectId: "luxewear-app",
      storageBucket: "luxewear-app.firebasestorage.app",
      authDomain: "luxewear-app.firebaseapp.com",
      measurementId: "G-DHKNX54Q2D",
    ),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => ShoeProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
      ],
      child: const ShoeApp(),
    ),
  );
}

class ShoeApp extends StatelessWidget {
  const ShoeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shoe Shop',
      navigatorKey: AppRoutes.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.login,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
