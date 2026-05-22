import 'package:flutter/material.dart';

class PaymentMethodItem {
  final String id;
  final String type; // 'visa', 'mastercard', 'paypal'
  final String number; // masked
  final String expiry;
  final String holderName;
  final bool isDefault;

  PaymentMethodItem({
    required this.id,
    required this.type,
    required this.number,
    required this.expiry,
    required this.holderName,
    this.isDefault = false,
  });
}

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  final List<PaymentMethodItem> _methods = [
    PaymentMethodItem(
      id: '1',
      type: 'visa',
      number: '**** **** **** 4978',
      expiry: '10/24',
      holderName: 'Alexei Sidorenko',
      isDefault: true,
    ),
    PaymentMethodItem(
      id: '2',
      type: 'mastercard',
      number: '**** **** **** 2478',
      expiry: '10/24',
      holderName: 'Alexei Sidorenko',
    ),
    PaymentMethodItem(
      id: '3',
      type: 'paypal',
      number: 'Maciej Konokonos',
      expiry: '',
      holderName: 'Maciej Konokonos',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    const orangeColor = Color(0xFFFF5A16);

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Payment methods',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _methods.length,
              itemBuilder: (context, index) {
                final method = _methods[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Logo Icon Container
                      _buildLogoContainer(method.type),
                      const SizedBox(width: 15),
                      // Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              method.number,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E1E1E),
                              ),
                            ),
                            if (method.expiry.isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Text(
                                'expires ${method.expiry}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      // Edit Button
                      SizedBox(
                        height: 36,
                        child: ElevatedButton(
                          onPressed: () {
                            // Edit placeholder
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: orangeColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                          ),
                          child: const Text(
                            'Edit',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          // Add Card Button at bottom
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.of(context).push<PaymentMethodItem>(
                    MaterialPageRoute(builder: (context) => const AddCardScreen()),
                  );
                  if (result != null) {
                    setState(() {
                      _methods.add(result);
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: orangeColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Add card',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoContainer(String type) {
    Color bg = Colors.grey.shade100;
    Widget logoWidget = const SizedBox();

    if (type == 'visa') {
      bg = const Color(0xFF0F1B4E);
      logoWidget = const Text(
        'VISA',
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w900,
          fontStyle: FontStyle.italic,
        ),
      );
    } else if (type == 'mastercard') {
      bg = Colors.white;
      logoWidget = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: const Color(0xFFFF5A16).withValues(alpha: 0.8),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 2),
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: const Color(0xFFFFC816).withValues(alpha: 0.8),
              shape: BoxShape.circle,
            ),
          ),
        ],
      );
    } else if (type == 'paypal') {
      bg = Colors.white;
      logoWidget = const Text(
        'PP',
        style: TextStyle(
          color: Color(0xFF003087),
          fontSize: 14,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
      );
    }

    return Container(
      width: 50,
      height: 35,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
        border: type != 'visa' ? Border.all(color: Colors.grey.shade200) : null,
      ),
      alignment: Alignment.center,
      child: logoWidget,
    );
  }
}

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final _cardNumberController = TextEditingController();
  final _holderNameController = TextEditingController(text: 'ALEXEI SIDORENKO');
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  bool _isDefault = true;

  String _cardNumber = '';
  String _expiry = '';
  String _cvv = '';

  @override
  void initState() {
    super.initState();
    _cardNumberController.addListener(() {
      setState(() {
        _cardNumber = _cardNumberController.text;
      });
    });
    _expiryController.addListener(() {
      setState(() {
        _expiry = _expiryController.text;
      });
    });
    _cvvController.addListener(() {
      setState(() {
        _cvv = _cvvController.text;
      });
    });
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _holderNameController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const orangeColor = Color(0xFFFF5A16);

    // Format fields
    String displayCardNumber = _cardNumber.isEmpty ? '4950 45XX XXXX XXXX' : _cardNumber;
    String displayExpiry = _expiry.isEmpty ? '01/23' : _expiry;
    String displayCvv = _cvv.isEmpty ? 'XXX' : _cvv;

    // Detect card type (e.g. starting with 4 is Visa, otherwise Mastercard)
    bool isVisa = _cardNumber.startsWith('4');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Add card',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Dynamic Card Preview
              Container(
                width: double.infinity,
                height: 200,
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE3E9F3), Color(0xFFD6DFEC)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 15,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Top row: Holder Name & Logo
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            _holderNameController.text.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF333333),
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        // Dynamic Logo based on card type
                        isVisa ? _buildVisaLogo() : _buildMastercardLogo(),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Middle row: Card Number
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'CARD NUMBER',
                          style: TextStyle(
                            fontSize: 9,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          displayCardNumber,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF2C2C2C),
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                    // Bottom row: Month/Year & CVV
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'MONTH/YEAR',
                              style: TextStyle(
                                fontSize: 9,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              displayExpiry,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2C2C2C),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 50),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'CVV',
                              style: TextStyle(
                                fontSize: 9,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              displayCvv,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2C2C2C),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 35),

              // 2. Input Fields
              // Card Number Input
              const Text(
                'Card number',
                style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              TextField(
                controller: _cardNumberController,
                keyboardType: TextInputType.number,
                maxLength: 19,
                decoration: InputDecoration(
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Icon(Icons.credit_card, color: Colors.grey),
                  ),
                  hintText: '4950 45XX XXXX XXXX',
                  counterText: '',
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: orangeColor, width: 2),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
              ),
              const SizedBox(height: 25),

              // Card Holder Name Input
              const Text(
                'Card holder',
                style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              TextField(
                controller: _holderNameController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person_outline, color: Colors.grey),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: orangeColor, width: 2),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
              ),
              const SizedBox(height: 25),

              // Exp Date & CVV side-by-side
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Exp Date',
                          style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        TextField(
                          controller: _expiryController,
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                            hintText: 'MM/YY',
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: orangeColor, width: 2),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 25),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'CVV Code',
                          style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        TextField(
                          controller: _cvvController,
                          keyboardType: TextInputType.number,
                          maxLength: 3,
                          decoration: InputDecoration(
                            hintText: '000',
                            counterText: '',
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: orangeColor, width: 2),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 35),

              // Default payment method toggle
              Row(
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      value: _isDefault,
                      onChanged: (val) {
                        setState(() {
                          _isDefault = val ?? false;
                        });
                      },
                      activeColor: orangeColor,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Set as your default payment method',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF333333),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // Save Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    if (_cardNumber.isEmpty || _expiry.isEmpty || _cvv.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please fill all fields')),
                      );
                      return;
                    }
                    final newMethod = PaymentMethodItem(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      type: isVisa ? 'visa' : 'mastercard',
                      number: '**** **** **** ${_cardNumber.length > 4 ? _cardNumber.substring(_cardNumber.length - 4) : _cardNumber}',
                      expiry: _expiry,
                      holderName: _holderNameController.text,
                      isDefault: _isDefault,
                    );
                    Navigator.of(context).pop(newMethod);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: orangeColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Add',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVisaLogo() {
    return const Text(
      'VISA',
      style: TextStyle(
        color: Color(0xFF0F1B4E),
        fontSize: 18,
        fontWeight: FontWeight.w900,
        fontStyle: FontStyle.italic,
      ),
    );
  }

  Widget _buildMastercardLogo() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: const Color(0xFFFF5A16).withValues(alpha: 0.9),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 2),
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: const Color(0xFFFFC816).withValues(alpha: 0.9),
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}
