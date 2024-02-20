import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ux/bloc/reminders_bloc/reminders_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DateElement extends StatelessWidget {
  const DateElement(
      {super.key, required this.date, required this.isCurrentDate});

  final Map<String, dynamic> date;
  final bool isCurrentDate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<RemindersBloc>(context)
            .add(SelectedDate(selectedDate: date));
      },
      child: SizedBox(
        width: 49,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              date["weekDay"],
              style: TextStyle(color: beige0, fontSize: 16),
            ),
            Stack(alignment: Alignment.bottomCenter,children: [
              Container(
                height: 36,
                width: 36,
                alignment: Alignment.center,
                decoration: date["isSelected"]
                    ? BoxDecoration(
                    borderRadius: BorderRadius.circular(90), color: beige200)
                    :isCurrentDate
                    ? BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(90),
                    border: Border.all(color: beige200))
                    : null,
                child: Text(
                  date["number"].toString(),
                  style: TextStyle(
                      color: date["isSelected"] ? primaryText : beige0,
                      letterSpacing: 0.5,
                      fontSize: 16),
                ),
              ),
              if (date["hasTasks"])
                Container(
                  margin: EdgeInsets.only(bottom: 2),
                  height: 6,width: 6,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(90), color: primary400),
                ),
            ],)

          ],
        ),
      ),
    );
  }
}
