import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_theme.dart';
import '../models/cart_provider.dart';
import '../widgets/app_button.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _paymentMethod = 0; // 0=Card, 1=PayPal, 2=Cash
  bool _orderPlaced = false;

  final _payments = [
    {'icon': '💳', 'label': 'Credit / Debit Card'},
    {'icon': '🅿️', 'label': 'PayPal'},
    {'icon': '💵', 'label': 'Cash on Delivery'},
  ];

  void _placeOrder() {
    setState(() => _orderPlaced = true);
    context.read<CartProvider>().clearCart();
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    if (_orderPlaced) {
      return Scaffold(
        backgroundColor: kBackground,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text('✅', style: TextStyle(fontSize: 48)),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Order Placed!',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: kBlack,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Your shoes are on their way.\nThank you for shopping with SOLE.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: kGrey, height: 1.5),
                  ),
                  const SizedBox(height: 36),
                  AppButton(
                    label: 'Back to Home',
                    onTap: () {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        backgroundColor: kBackground,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: kLightGrey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.arrow_back_rounded, color: kBlack, size: 20),
          ),
        ),
        title: const Text(
          'Checkout',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w700, color: kBlack),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Delivery address
            const Text('Delivery Address', style: kTitle),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: kBorder),
              ),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: kLightGrey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.location_on_outlined,
                        color: kBlack, size: 22),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Jordan Lee',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: kBlack)),
                        SizedBox(height: 2),
                        Text('123 Main Street, Colombo 03\nSri Lanka',
                            style: TextStyle(fontSize: 12, color: kGrey, height: 1.4)),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right_rounded, color: kGrey),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Payment method
            const Text('Payment Method', style: kTitle),
            const SizedBox(height: 12),
            Column(
              children: List.generate(_payments.length, (i) {
                final isSelected = _paymentMethod == i;
                return GestureDetector(
                  onTap: () => setState(() => _paymentMethod = i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isSelected ? kBlack : kBorder,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(_payments[i]['icon']!,
                            style: const TextStyle(fontSize: 22)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _payments[i]['label']!,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: kBlack,
                            ),
                          ),
                        ),
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isSelected ? kBlack : kWhite,
                            border: Border.all(
                              color: isSelected ? kBlack : kGrey,
                              width: 1.5,
                            ),
                          ),
                          child: isSelected
                              ? const Icon(Icons.check_rounded,
                                  size: 12, color: kWhite)
                              : null,
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),

            // Order summary
            const Text('Order Summary', style: kTitle),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: kBorder),
              ),
              child: Column(
                children: [
                  _row('Subtotal', '\$${cart.subtotal.toStringAsFixed(2)}'),
                  const SizedBox(height: 8),
                  _row('Shipping',
                      cart.shipping == 0 ? 'Free' : '\$${cart.shipping.toStringAsFixed(2)}'),
                  const SizedBox(height: 8),
                  _row('Discount',
                      cart.discount > 0 ? '-\$${cart.discount.toStringAsFixed(2)}' : '\$0.00',
                      valueColor: Colors.green),
                  const Divider(height: 20, color: kBorder),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: kBlack)),
                      Text('\$${cart.total.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: kBlack)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            AppButton(label: 'Place Order', onTap: _placeOrder),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value, {Color valueColor = kBlack}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, color: kGrey)),
        Text(value,
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: valueColor)),
      ],
    );
  }
}
