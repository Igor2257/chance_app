import 'dart:collection';

import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/reminders_page/medicine/medicine_item.dart';
import 'package:chance_app/ux/model/medicine_model.dart';
import 'package:cupertino_listview/cupertino_listview.dart';
import 'package:flutter/material.dart';

class MedicineList extends StatelessWidget {
  const MedicineList(
    this.medicines, {
    required this.dayDate,
    super.key,
  });

  final List<MedicineModel> medicines;
  final DateTime dayDate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final items = medicines
        .where((element) => !element.isRemoved)
        .where((element) => element.hasRemindersAt(dayDate));

    if (items.isEmpty) return _emptyListPlaceholder();

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
        return Container(
          color: theme.scaffoldBackgroundColor,
          width: double.infinity,
          child: Text(
            timeOffset.toTimeOfDay().format(context),
            style: const TextStyle(fontSize: 32, color: primaryText),
          ),
        );
      },
      childBuilder: (context, indexPath) {
        final timeOffset = groupedItems.keys.elementAt(indexPath.section);
        final time = timeOffset.toTimeOfDay();
        final group = groupedItems.values.elementAt(indexPath.section);
        final medicine = group[indexPath.child];
        return Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: MedicineItem(
            medicine,
            doseTime: dayDate.copyWith(
              hour: time.hour,
              minute: time.minute,
            ),
            onTap: () {},
          ),
        );
      },
    );
  }

  Widget _emptyListPlaceholder() {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Text(
        "Додайте нагадування про прийом ліків",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
