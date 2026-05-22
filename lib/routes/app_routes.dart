import 'package:flutter/material.dart';
import '../models/models.dart';
import '../screens/details_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/main_layout.dart';
import '../screens/checkout_screen.dart';
import '../screens/personal_info_screen.dart';
import '../screens/placeholder_screens.dart';
import '../screens/payment_methods_screen.dart';

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
  static const String checkout = '/checkout';
  static const String personalInfo = '/personal-info';
  static const String addresses = '/addresses';
  static const String paymentMethods = '/payment-methods';
  static const String settingsScreen = '/settings';
  static const String helpCenter = '/help-center';

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
      case checkout:
        return MaterialPageRoute(builder: (_) => const CheckoutScreen());
      case personalInfo:
        return MaterialPageRoute(builder: (_) => const PersonalInfoScreen());
      case addresses:
        return MaterialPageRoute(builder: (_) => const PlaceholderScreen(title: 'Addresses'));
      case paymentMethods:
        return MaterialPageRoute(builder: (_) => const PaymentMethodsScreen());
      case settingsScreen:
        return MaterialPageRoute(builder: (_) => const PlaceholderScreen(title: 'Settings'));
      case helpCenter:
        return MaterialPageRoute(builder: (_) => const PlaceholderScreen(title: 'Help Center'));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
