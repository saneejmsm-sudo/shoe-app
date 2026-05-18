import 'package:flutter/material.dart';
import '../models/app_theme.dart';
import '../widgets/app_text_field.dart';
import '../widgets/app_button.dart';
import 'main_nav.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _hidePass = true;
  bool _hideConfirm = true;
  bool _agreed = false;
  bool _loading = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  void _signup() async {
    if (_nameCtrl.text.trim().isEmpty ||
        _emailCtrl.text.trim().isEmpty ||
        _passCtrl.text.trim().isEmpty ||
        _confirmCtrl.text.trim().isEmpty) {
      _snack('Please fill in all fields.');
      return;
    }
    if (_passCtrl.text != _confirmCtrl.text) {
      _snack('Passwords do not match.');
      return;
    }
    if (!_agreed) {
      _snack('Please agree to the Terms & Conditions.');
      return;
    }
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    setState(() => _loading = false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const MainNav()),
    );
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // Back
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: kLightGrey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.arrow_back_rounded, size: 20, color: kBlack),
                ),
              ),
              const SizedBox(height: 24),

              const Text('Create Account', style: kHeadline),
              const SizedBox(height: 4),
              const Text('Join SOLE. and start shopping', style: kCaption),
              const SizedBox(height: 28),

              AppTextField(
                controller: _nameCtrl,
                label: 'Full Name',
                hint: 'Jordan Lee',
                prefixIcon: Icons.person_outline,
              ),
              const SizedBox(height: 16),

              AppTextField(
                controller: _emailCtrl,
                label: 'Email',
                hint: 'you@email.com',
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              AppTextField(
                controller: _passCtrl,
                label: 'Password',
                hint: 'At least 8 characters',
                prefixIcon: Icons.lock_outline,
                obscureText: _hidePass,
                suffixIcon: IconButton(
                  icon: Icon(
                    _hidePass ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    size: 20,
                    color: kGrey,
                  ),
                  onPressed: () => setState(() => _hidePass = !_hidePass),
                ),
              ),
              const SizedBox(height: 16),

              AppTextField(
                controller: _confirmCtrl,
                label: 'Confirm Password',
                hint: 'Re-enter your password',
                prefixIcon: Icons.lock_outline,
                obscureText: _hideConfirm,
                suffixIcon: IconButton(
                  icon: Icon(
                    _hideConfirm ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    size: 20,
                    color: kGrey,
                  ),
                  onPressed: () => setState(() => _hideConfirm = !_hideConfirm),
                ),
              ),
              const SizedBox(height: 20),

              // Terms
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => setState(() => _agreed = !_agreed),
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: _agreed ? kBlack : kWhite,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: _agreed ? kBlack : kGrey,
                          width: 1.5,
                        ),
                      ),
                      child: _agreed
                          ? const Icon(Icons.check_rounded, size: 14, color: kWhite)
                          : null,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'I agree to the Terms of Service and Privacy Policy',
                      style: TextStyle(fontSize: 12, color: kGrey, height: 1.5),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              AppButton(label: 'Create Account', onTap: _signup, isLoading: _loading),
              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account? ',
                      style: TextStyle(fontSize: 13, color: kGrey)),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text(
                      'Sign in',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: kBlack),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
