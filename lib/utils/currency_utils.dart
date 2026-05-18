import 'package:intl/intl.dart';

class CurrencyUtils {
  static const double conversionRate = 100.0;
  
  static String format(double priceInUSD) {
    final lkrPrice = priceInUSD * conversionRate;
    final formatter = NumberFormat.currency(
      symbol: 'LKR ',
      decimalDigits: 2,
    );
    return formatter.format(lkrPrice);
  }
}
