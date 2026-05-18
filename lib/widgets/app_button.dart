import 'package:flutter/material.dart';
import '../models/app_theme.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isLoading;
  final Color color;

  const AppButton({
    super.key,
    required this.label,
    required this.onTap,
    this.isLoading = false,
    this.color = kBlack,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: isLoading ? null : onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          disabledBackgroundColor: Colors.grey.shade400,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: kWhite,
                ),
              )
            : Text(label, style: kButtonText),
      ),
    );
  }
}
