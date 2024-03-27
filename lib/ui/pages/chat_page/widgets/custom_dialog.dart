import 'package:chance_app/ui/constans.dart';
import 'package:flutter/material.dart';

class CustomDialog {
  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    String cancelText = 'Скасувати',
    String actionText = 'Покинути',
  }) {
    return showDialog<T>(
      context: context,
      builder: (_) {
        return Dialog(
          backgroundColor: beige100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    height: 24 / 16,
                    letterSpacing: 0.5,
                    color: darkNeutral1000,
                  ),
                ),
                const SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text(
                        cancelText,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          height: 24 / 16,
                          letterSpacing: 0.15,
                          color: primary700,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text(
                        actionText,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          height: 24 / 16,
                          letterSpacing: 0.15,
                          color: primary700,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
