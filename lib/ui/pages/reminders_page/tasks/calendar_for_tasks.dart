import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/reminders_page/components/calendar.dart';
import 'package:chance_app/ux/bloc/reminders_bloc/reminders_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CalendarForTasks extends StatelessWidget {
  CalendarForTasks({super.key});
final DateTime now=DateTime.now();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<RemindersBloc, RemindersState>(
        builder: (context, state) {
      List<Map<String, dynamic>>
          days = List.from(state.daysForTasks);
      DateTime dateTime = DateTime.now();
      int count = getCount(days.first["weekDay"].toString());
      for (int i = 0; i < count; i++) {
        days.insert(0, {"number": -1,});
      }
      return Container(
        width: size.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
        child: Flex(
          direction: Axis.vertical,
          children: [
            Row(
              children: [

                Text(
                  "${getMonthName(state.dateForSwiping?.month ?? 0)}, ${state.dateForSwiping?.year ?? ""}",
                  style: TextStyle(fontSize: 22, color: primaryText),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      BlocProvider.of<RemindersBloc>(context)
                          .add(ChangeMonth(sideSwipe: SideSwipe.left));
                    },
                    icon: Icon(Icons.arrow_back_ios, color: primaryText)),
                IconButton(
                    onPressed: () {
                      BlocProvider.of<RemindersBloc>(context)
                          .add(ChangeMonth(sideSwipe: SideSwipe.right));
                    },
                    icon: Icon(Icons.arrow_forward_ios, color: primaryText)),

              ],
            ),
            SizedBox(
                child: Flex(
              direction: Axis.vertical,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.bottomCenter,
                      width: size.width / 8,
                      height: 26,
                      child: Text(
                        "ПН",
                        style: TextStyle(
                            color: primaryText, fontSize: 16, letterSpacing: 0.15),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      width: size.width / 8,
                      height: 26,
                      child: Text(
                        "ВТ",
                        style: TextStyle(
                            color: primaryText, fontSize: 16, letterSpacing: 0.15),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      width: size.width / 8,
                      height: 26,
                      child: Text(
                        "СР",
                        style: TextStyle(
                            color: primaryText, fontSize: 16, letterSpacing: 0.15),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      width: size.width / 8,
                      height: 26,
                      child: Text(
                        "ЧТ",
                        style: TextStyle(
                            color: primaryText, fontSize: 16, letterSpacing: 0.15),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      width: size.width / 8,
                      height: 26,
                      child: Text(
                        "ПТ",
                        style: TextStyle(
                            color: primaryText, fontSize: 16, letterSpacing: 0.15),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      width: size.width / 8,
                      height: 26,
                      child: Text(
                        "СБ",
                        style: TextStyle(
                            color: primaryText, fontSize: 16, letterSpacing: 0.15),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      width: size.width / 8,
                      height: 26,
                      child: Text(
                        "НД",
                        style: TextStyle(
                            color: primaryText, fontSize: 16, letterSpacing: 0.15),
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: beige300,
                ),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runAlignment: WrapAlignment.center,
                  alignment: WrapAlignment.start,
                  children: days.map((e) {
                    if (e["number"] == -1) {
                      return SizedBox(
                        height: size.width / 8,
                        width: size.width / 8,
                      );
                    }
                    return GestureDetector(
                      onTap: () {
                        BlocProvider.of<RemindersBloc>(context)
                            .add(SelectedDateForTasks(selectedDate: e));
                      },
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            height: size.width / 8,
                            width: size.width / 8,
                            alignment: Alignment.center,
                            decoration: e["isSelected"]
                                ? BoxDecoration(
                                    borderRadius: BorderRadius.circular(90),
                                    color: primary800)
                                : int.parse(e["number"]) == now.day &&
                                e["month"] == now.month &&
                                e["year"] == now.year
                                ? BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(90),
                                border: Border.all(color: primary800))
                                :null,
                            child: Text(
                              e["number"].toString(),
                              style: TextStyle(
                                  color: e["isSelected"] ? primary50 : primaryText,
                                  letterSpacing: 0.5,
                                  fontSize: 16),
                            ),
                          ),
                          if ((e["number"] == dateTime.day.toString()) &&
                              (e["month"] == dateTime.month) &&
                              (e["year"] == dateTime.year))
                            Container(
                              height: 10,
                              width: 10,
                              margin: const EdgeInsets.only(bottom: 2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(90),
                                  color: primary400),
                            ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ))
          ],
        ),
      );
    });
  }

  int getCount(String weekday) {
    switch (weekday) {
      case 'ПН':
        return 0;
      case 'ВТ':
        return 1;
      case 'СР':
        return 2;
      case 'ЧТ':
        return 3;
      case 'ПТ':
        return 4;
      case 'СБ':
        return 5;
      case 'НД':
        return 6;
      default:
        return 0;
    }
  }
}
