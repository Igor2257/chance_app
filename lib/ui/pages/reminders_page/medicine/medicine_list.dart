import 'dart:collection';

import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/l10n/app_localizations.dart';
import 'package:chance_app/ui/pages/reminders_page/medicine/medicine_item.dart';
import 'package:chance_app/ux/model/medicine_model.dart';
import 'package:cupertino_listview/cupertino_listview.dart';
import 'package:flutter/material.dart';

class MedicineList extends StatelessWidget {
  const MedicineList(
    this.items, {
    super.key,
  });

  final List<MedicineModel> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return _emptyListPlaceholder();

    final theme = Theme.of(context);
    final groupedItems = SplayTreeMap<int, List<MedicineModel>>();

    for (final item in items) {
      for (final time in item.doses.keys) {
        if (!groupedItems.containsKey(time)) groupedItems[time] = [];
        groupedItems[time]!.add(item);
      }
    }

    return CupertinoListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sectionCount: groupedItems.length,
      itemInSectionCount: (i) => groupedItems.values.elementAt(i).length,
      sectionBuilder: (context, sectionPath, _) {
        final timeOffset = groupedItems.keys.elementAt(sectionPath.section);
        final time = timeOffset.toTimeOfDay();
        return Container(
          color: theme.scaffoldBackgroundColor,
          width: double.infinity,
          child: Text(
            [
              time.hour.toString().padLeft(2, "0"),
              time.minute.toString().padLeft(2, "0"),
            ].join(":"),
            style: TextStyle(fontSize: 32, color: primaryText),
          ),
        );
      },
      childBuilder: (context, indexPath) {
        final medicine = items[indexPath.child];
        final timeOffset = groupedItems.keys.elementAt(indexPath.section);
        return Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: MedicineItem(
            medicine,
            time: timeOffset.toTimeOfDay(),
            onTap: () {},
          ),
        );
      },
    );
  }

  Widget _emptyListPlaceholder() {
    return  Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        AppLocalizations.instance.translate("addMedicationReminders"),
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}
