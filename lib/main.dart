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
      apiKey: "AIzaSyDEXwRXz04DL_mkYKwWET4B3Ebb6ys8SdU",
      appId: "1:592344843969:web:b8445b13c59f015c82f640",
      messagingSenderId: "592344843969",
      projectId: "shoe-shop-app-31dfb",
      storageBucket: "shoe-shop-app-31dfb.firebasestorage.app",
      authDomain: "shoe-shop-app-31dfb.firebaseapp.com",
      measurementId: "G-HWTMTP1CS2",
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
