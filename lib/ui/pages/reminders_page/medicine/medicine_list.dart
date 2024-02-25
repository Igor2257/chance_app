import 'package:chance_app/ui/pages/reminders_page/medicine/components/medicine_item.dart';
import 'package:chance_app/ux/bloc/reminders_bloc/reminders_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MedicineList extends StatefulWidget {
  const MedicineList({super.key});

  @override
  State<MedicineList> createState() => _MedicineListState();
}

class _MedicineListState extends State<MedicineList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemindersBloc, RemindersState>(
        builder: (context, state) {
      //List<TaskModel> myTasks = List.from(state.myTasks);
      //if (myTasks.isEmpty) {
      //  return const Text(
      //    "Додайте завдання",
      //    style: TextStyle(fontSize: 24),
      //  );
      //}
      List myMedicine = [];
      if (myMedicine.isEmpty) {
        return const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "Додайте нагадування про прийом ліків",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24),
          ),
        );
      }

      return ListView.builder(
          itemCount: myMedicine.length,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemBuilder: (context, position) {
            return const MedicineItem();
          });
    });
  }
}
