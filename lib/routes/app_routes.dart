import 'package:flutter/material.dart';
import '../models/models.dart';
import '../screens/details_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/main_layout.dart';

class AppRoutes {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static const String root = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String explore = '/explore';
  static const String details = '/details';
  static const String cart = '/cart';
  static const String favorites = '/favorites';
  static const String profile = '/profile';
  static const String orders = '/orders';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case root:
        return MaterialPageRoute(builder: (_) => const MainLayout());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case details:
        final shoe = settings.arguments;
        if (shoe is! Shoe) {
          return MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(child: Text('Invalid shoe details passed.')),
            ),
          );
        }
        return MaterialPageRoute(
          builder: (_) => DetailsScreen(shoe: shoe),
        );
      case orders:
        return MaterialPageRoute(builder: (_) => const OrdersScreen());
      case cart:
        return MaterialPageRoute(builder: (_) => const CartScreen());
      // Inner tabs are handled by MainLayout IndexedStack, 
      // but named routes can still be used for direct navigation if needed.
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
