import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class AcceptDialog {
  static Future<T?> show<T>(BuildContext context) {
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
                const Icon(
                  Icons.done,
                  size: 24.0,
                  color: darkNeutral1000,
                ),
                const SizedBox(height: 24.0),
                Text(
                  AppLocalizations.instance.translate('acceptChanges'),
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 22,
                    height: 28 / 22,
                    color: darkNeutral1000,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}